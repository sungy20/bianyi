from pickle import NONE
from antlr_about.C2LLVMVisitor import C2LLVMVisitor
from antlr_about.C2LLVMParser import C2LLVMParser
import llvmlite.ir as ir
from generator.types import LLVMTypes
from generator.util import parse_escape
from generator.errors import *
import json

class LLVMGenerator(C2LLVMVisitor):
    def __init__(self,error_listener = AntlrErrorListener()):
        self.error_listener = error_listener  #错误监听器
        self.module = ir.Module(name = 'C2LLVM')  #创建一个空模型
        self.local_vars = {}
        self.structs = {}
        # key为struct名的python字符串，value为index字典
        # index字典的key为变量名的python字符串，value为对应偏移量的LLVM值
        self.struct_entry_types = {}
        # key为struct名的python字符串，value为size字典
        # index字典的key为变量名的python字符串，value为对应的type的LLVM值
        self.struct_sizes = {}
        # key为struct名的python字符串，value为结构体大小的LLVM值
        self.continue_block = None
        self.break_block = None
        self.Blocks = []
        self.str = ""
        self.scope = ""
        self._inside_struct_ = 0
        self._current_struct_ = None
        self._current_struct_size_ = LLVMTypes.int(0)
        self.global_context = ir.global_context
        self.included = 0
        self.msg = {}

    @staticmethod
    def match_rule(ctx, rule):
        #判断ctx.getRuleIndex()==rule是否成立.若ctx无getRuleIndex()则返回False.
        if hasattr(ctx, 'getRuleIndex'):
            return ctx.getRuleIndex() == rule
        else:
            return False

    @staticmethod
    def match_texts(ctx, texts):
        #判断ctx.getText() in texts是否成立.若ctx无getText()则返回False. texts是一个字符串列表
        if hasattr(ctx, 'getText'):
            return ctx.getText() in texts
        else:
            return False

    @classmethod
    def match_text(cls, ctx, text):
        """判断ctx.getText() == text是否成立.若ctx无getText()则返回False"""
        return cls.match_texts(ctx, [text])

    def emit_printf(self):
        """引入printf函数"""
        printf_type = ir.FunctionType(LLVMTypes.int, (LLVMTypes.get_pointer_type(LLVMTypes.char),), var_arg=True)
        printf_func = ir.Function(self.module, printf_type, "printf")
        self.local_vars["printf"] = printf_func

    def emit_scanf(self):
        scanf_type = ir.FunctionType(ir.IntType(32), [LLVMTypes.get_pointer_type(LLVMTypes.char),], var_arg=True)
        scanf_func = ir.Function(self.module, scanf_type, name="scanf")
        self.local_vars["scanf"] = scanf_func

    def visitInclude(self, ctx:C2LLVMParser.IncludeContext):
        if not self.included:
            self.emit_printf()
            self.emit_scanf()
            self.included = 1

    def visitStart(self, ctx:C2LLVMParser.StartContext):
        self.str = self.str + '{'
        for child in ctx.children:
            self.visit(child) 
        self.str = self.str + '},'

    def visitCodeBlock(self, ctx: C2LLVMParser.CodeBlockContext):
        self.str = self.str + '"codeBlock":{'
        # child = ctx.children[0]
        # if self.match_rule(child, C2LLVMParser.RULE_include):
        #     pass #TODO头文件
        # elif self.match_rule(child, C2LLVMParser.RULE_structPack):
        #     pass #TODO结构体定义
        # elif self.match_rule(child, C2LLVMParser.RULE_function):
        #     self.visit(child)
        for child in ctx.children:
            self.visit(child)
        self.str = self.str + '},'

    def visitFunction(self, ctx:C2LLVMParser.FunctionContext):
        """
        function : varType StrVar '(' params ')' packcontent;
        eg: void hi(char *who, int *i);
        """
        self.str = self.str + '"function":{'
        ret_type = LLVMTypes.str2type[ctx.varType().getText()]  #函数返回值的类型
        self.str = self.str + '"returnType":' + '"' + ctx.varType().getText() + '",'
        func_name = ctx.StrVar().getText()
        self.scope = func_name
        self.str = self.str + '"funcName":' + '"' + ctx.StrVar().getText() + '",'
        args_type, args_name = self.visit(ctx.params())
        function_type = ir.FunctionType(ret_type,(args_type))
        llvm_function = ir.Function(self.module, function_type, name=func_name)  #创建llvm函数
        self.builder = ir.IRBuilder(llvm_function.append_basic_block(name=func_name))#

        self.local_vars[func_name] = llvm_function

        for arg_name, llvm_arg in zip(args_name, llvm_function.args):
            varp = self.builder.alloca(llvm_arg.type)
            self.builder.store(llvm_arg,varp)
            self.local_vars[self.scope + arg_name] = varp

        self.continue_block = None
        self.break_block = None
        self.visit(ctx.packcontent())
        self.scope = ""
        # TODO补充函数没有return的情况

        self.str = self.str + '},'

    def visitParams(self, ctx:C2LLVMParser.ParamsContext):
        """
        params : param | param ',' params |;
        :param ctx:
        :return: 返回变量名字列表arg_names和变量类型列表arg_types
        """
        self.str = self.str + '"params":{'
        arg_names = []
        arg_types = []
        if ctx.children is None:
            self.str = self.str + '},'
            return arg_types, arg_names
        elif len(ctx.children) > 1:
            arg_types, arg_names = self.visit(ctx.params())
        arg_type, arg_name = self.visit(ctx.param())
        arg_names.append(arg_name)
        arg_types.append(arg_type)
        self.str = self.str + '},'
        return arg_types, arg_names

    def visitParam(self, ctx:C2LLVMParser.ParamContext):
        """
        param: usualType StrVar;
        :param ctx:
        :return: 声明变量的名字和类型
        """
        self.str = self.str + '"param":{'
        arg_type = self.visit(ctx.usualType())
        arg_name = ctx.StrVar().getText()
        self.str = self.str + '"StrVar":" ' + ctx.StrVar().getText() + '",'
        self.str = self.str + '},'
        return arg_type, arg_name

    def visitUsualType(self, ctx:C2LLVMParser.UsualTypeContext):
        """
        usualType: varType | pointerType ;
        pointerType: varType '*' | 'struct' StrVar '*' | StrVar '*';
        varType: varType: 'int' | 'char' | 'struct';
        :param ctx:
        :return: 对应的LLVM类型
        """
        self.str = self.str + '"usualType":{'
        if self.match_rule(ctx.children[0], C2LLVMParser.RULE_pointerType):
            # 指针类型
            pt = ctx.pointerType()
            var_tp = self.visit(pt)
            pointer_tp = LLVMTypes.get_pointer_type(var_tp)
            self.str = self.str + '},'
            return pointer_tp
        elif self.match_texts(ctx, LLVMTypes.str2type.keys()):
            # 'int' | 'char' | 'struct'
            self.str = self.str + '},'
            return LLVMTypes.str2type[ctx.getText()]   #TODO: sssssssssssss结构体
        else:
            print("Error: unknown type ", ctx.getText())
            exit(-1)

    def visitPointerType(self, ctx:C2LLVMParser.PointerTypeContext):
        """
        pointerType: varType '*' | 'struct' StrVar '*' | StrVar '*';
        return:指针对应类型
        """
        self.str = self.str + '"pointerType":{'

        returnType = LLVMTypes.char
        if ctx.varType():
            self.str = self.str + '"varType":"'+ ctx.varType().getText() +'",'
            returnType = LLVMTypes.str2type[ctx.varType().getText()]
        else:
            struct_name = ctx.children[0].getText()
            self.str = self.str + '"struct":"'+ struct_name +'",'
            if struct_name == 'struct':
                struct_name = ctx.children[1].getText()
                self.str = self.str + '"StrVar":"'+ struct_name +'",'
            returnType = self.global_context.get_identified_type(struct_name)
        self.str = self.str + '},'
        return returnType

    def visitPackcontent(self, ctx: C2LLVMParser.PackcontentContext):
        """
        packcontent: (stat | block | ) | ('{' content '}');
        """
        self.str = self.str + '"packcontent":{'
        if len(ctx.children) == 3:
            # self.str = self.str + '"content":{'
            self.visit(ctx.content())
            # self.str = self.str + '},'
        elif len(ctx.children) == 1:
            self.visit(ctx.children[0])
        self.str = self.str + '},'

    def visitContent(self, ctx: C2LLVMParser.ContentContext):
        """
        content : (stat|block) content | (stat|block) | ;
        """
        self.str = self.str + '"content":{'
        if ctx.children is None:
            self.str = self.str + '},'
            return
        elif len(ctx.children) == 1:
            self.visit(ctx.children[0])
        else:
            self.visit(ctx.children[0])
            self.visit(ctx.content())
        self.str = self.str + '},'

    def visitStat(self, ctx: C2LLVMParser.StatContext):
        """
        stat : declareStat | assignStat | breakStat | returnStat | freeStat | continueStat | (customFunc ';') | scanfStat | printfStat;
        """
        self.str = self.str + '"stat":{'
        self.visit(ctx.children[0])
        self.str = self.str + '},'

    def depthOfPointer(self, p):
        """
        输入p为指针的类型，输出为指针级数
        """
        depth = 0
        while isinstance(p, ir.PointerType):
            depth += 1
            p = p.pointee
        return depth

    def aCouldBeStoredInB(self, a, b):
        if self.depthOfPointer(a) - self.depthOfPointer(b) == -1:
            return True
        return False

    def visitDeclareStat(self, ctx: C2LLVMParser.DeclareStatContext):  #TODO
        """
        declareStat: (usualType StrVar |  varType array) ';';
        """
        self.str = self.str + '"declareStat":{'
        if ctx.children[0].getText() == "struct" and not self._inside_struct_:  # 声明结构体对象
            # TODO 目前不支持声明数组
            struct_type = ctx.children[1].getText()
            self.str = self.str + '"usualType":"' + struct_type + '",'
            struct_obj = ctx.children[2].getText()
            self.str = self.str + '"StrVar":"' + struct_obj + '",'
            type_self = self.global_context.get_identified_type(struct_type)
            varp = self.builder.alloca(type_self)
            self.local_vars[self.scope + struct_obj] = varp
        elif not self._inside_struct_:
            if len(ctx.children) == 3:  # 正常情况
                if self.match_rule(ctx.children[1], C2LLVMParser.RULE_array):  # 声明数组
                    vtype = LLVMTypes.str2type[ctx.varType().getText()]
                    self.str = self.str + '"varType":"' + ctx.varType().getText() + '",'
                    var, size = self.visit(ctx.array())
                    if size == None:
                        print("declare need size")
                    varp = LLVMTypes.get_array_type(vtype, size.constant)
                    varp = self.builder.alloca(varp, size)
                    self.local_vars[self.scope + var] = varp
                else:  # 声明单个变量
                    varType = self.visit(ctx.usualType())
                    var = ctx.children[1].getText()
                    self.str = self.str + '"StrVar":"' + var + '",'
                    # 申请栈空间，并返回对应的指针
                    varp = self.builder.alloca(varType)
                    self.local_vars[self.scope + var] = varp
            else:
                pass
        elif ctx.children[0].getText() != "struct": #结构体内声明正常变量
            if len(ctx.children) == 3:  # 正常情况
                if self.match_rule(ctx.children[1], C2LLVMParser.RULE_array):  # 声明数组
                    vtype = LLVMTypes.str2type[ctx.varType().getText()]
                    self.str = self.str + '"varType":"' + vtype + '",'
                    var, size = self.visit(ctx.array())
                    if size == None:
                        print("declare need size")
                    self.structs[self._current_struct_][var] = self._current_struct_size_
                    current_variable_size = LLVMTypes.int(1)
                    self.struct_entry_types[self._current_struct_][var] = vtype
                    self._current_struct_size_ = LLVMTypes.int(self._current_struct_size_.constant + current_variable_size.constant)
                else:  # 声明单个变量
                    vtype = self.visit(ctx.usualType())
                    var = ctx.children[1].getText()
                    self.str = self.str + '"usualType":"' + var + '",'
                    self.structs[self._current_struct_][var] = self._current_struct_size_
                    current_variable_size = LLVMTypes.int(1)
                    self.struct_entry_types[self._current_struct_][var] = vtype
                    self._current_struct_size_ = LLVMTypes.int(self._current_struct_size_.constant + current_variable_size.constant)
            else:
                print("结构体定义内声明结构体成员，尚未完成！")
        self.str = self.str + '},'

    def visitAssignStat(self, ctx: C2LLVMParser.AssignStatContext):
        """
        assignStat: (usualType StrVar | StrVar | arrayValue | expr | varType array) '=' expr ';';
        """
        self.str = self.str + '"AssignStat":{'
        if len(ctx.children) == 5: #usualType StrVar = expr ;的情况
            if ctx.usualType(): #单个变量的情况
                varType = self.visit(ctx.usualType())
                var = ctx.StrVar().getText()
                self.str = self.str + '"StrVar":"' + ctx.StrVar().getText() + '",'
                val = self.visit(ctx.expr()[0])
                # 申请栈空间，并返回对应的指针
                varp = self.builder.alloca(varType)
                if ctx.expr()[0].children[0].getText() == '&':
                    pass
                else:
                    if (not self.aCouldBeStoredInB(val.type, varp.type)) and isinstance(val.type, ir.PointerType):
                        val = self.builder.load(val)
                converted_rhs = LLVMTypes.cast_type(self.builder, varType, val)  # 将val转换为varType类型
                if converted_rhs is None:
                    converted_rhs = val
                if converted_rhs.type.is_pointer:
                    if isinstance(converted_rhs.type.pointee, ir.ArrayType):
                        converted_rhs = self.builder.gep(converted_rhs, [LLVMTypes.int(0), LLVMTypes.int(0)])
                # 将值存储到指定的位置
                self.builder.store(converted_rhs, varp)
                self.local_vars[self.scope + var] = varp
            else: #数组的情况
                vtype = LLVMTypes.str2type[ctx.varType().getText()]
                self.str = self.str + '"varType":"' + ctx.varType().getText() + '",'
                var, size = self.visit(ctx.children[1])
                val = self.visit(ctx.children[3])
                # TODO （可选做）检查赋值表达式跟数组类型一致
                varp = LLVMTypes.get_array_type(vtype, size.constant)
                varp = self.builder.alloca(varp, size)
                # 将值存储到指定的位置
                # TODO 考虑初始值长度比数组大
                for i in range(val.type.count):  # TODO 这里只考虑了给char asd[100] = "1234"的情况即字符数组和字符串
                    singleval = val.constant[i]
                    singleval = LLVMTypes.char(singleval)
                    singleval = LLVMTypes.cast_type(self.builder, vtype, singleval)
                    addr = self.builder.gep(varp, [LLVMTypes.int(0), LLVMTypes.int(i)])
                    self.builder.store(singleval, addr)
                # self.builder.bitcast(varp,LLVMTypes.get_pointer_type(vtype))   
                self.local_vars[self.scope + var] = varp
        elif len(ctx.children) == 4: #(expr|strvar|arrayvalue) = expr ;的情况
            if(ctx.StrVar()):
                var = ctx.children[0].getText()
                self.str = self.str + '"StrVar":"' + ctx.StrVar().getText() + '",'
                varp = self.local_vars[self.scope + var]
                varType = varp.type.pointee
                valp = self.visit(ctx.children[2])
                if (not self.aCouldBeStoredInB(valp.type, varp.type)) and isinstance(valp.type, ir.PointerType):
                    val = self.builder.load(valp)
                else:
                    val = valp
                converted_val = LLVMTypes.cast_type(self.builder, varType, val)
                if converted_val is None:
                    converted_val = val
                self.builder.store(converted_val, varp)
                # self.builder.store(LLVMTypes.int(1),valp)
            elif (ctx.arrayValue()):
                valp = self.visit(ctx.arrayValue())
                val = self.visit(ctx.expr()[0])
                varType = valp.type.pointee
                if isinstance(val.type, ir.PointerType) and not isinstance(varType, ir.PointerType):
                    val = self.builder.load(val)
                converted_val = LLVMTypes.cast_type(self.builder, varType, val)
                if converted_val is None:
                    converted_val = val
                self.builder.store(converted_val, valp)
            else:
                valp = self.visit(ctx.children[0])
                varType = valp.type.pointee  # valp指向的对象的类型
                val = self.visit(ctx.children[2])  # 要存入的值
                if not self.aCouldBeStoredInB(val.type, valp.type):
                    val = self.builder.load(val)
                converted_val = LLVMTypes.cast_type(self.builder, varType, val)
                if converted_val is None:
                    converted_val = val
                if converted_val.type.is_pointer:
                    if isinstance(converted_val.type.pointee, ir.ArrayType):
                        converted_val = self.builder.gep(converted_val, [LLVMTypes.int(0), LLVMTypes.int(0)])
                self.builder.store(converted_val, valp)
        else:
            pass
        self.str = self.str + '},'

    def visitBreakStat(self, ctx:C2LLVMParser.BreakStatContext):
        self.str = self.str + '"breakStat":"' + ctx.children[0].getText() + '",'
        self.builder.branch(self.break_block)

    def visitReturnStat(self, ctx: C2LLVMParser.ReturnStatContext):
        """
         'return' expr ';'
        """
        self.str = self.str + '"returnStat":{'
        ret_val = self.visit(ctx.expr())
        if isinstance(ret_val.type, ir.PointerType):
            ret_val = self.builder.load(ret_val)
        converted_val = LLVMTypes.cast_type(
            self.builder, target_type=self.builder.function.type.pointee.return_type, value=ret_val)
        self.builder.ret(converted_val)
        print(self.module)
        self.str = self.str + '},'

    def visitContinueStat(self, ctx:C2LLVMParser.ContinueStatContext):
        self.str = self.str + '"continueStat":"' + ctx.children[0].getText() + '",'
        self.builder.branch(self.continue_block)

    def visitFreeStat(self, ctx: C2LLVMParser.FreeStatContext):
        pass
        #TODO

    def visitPrintfStat(self, ctx: C2LLVMParser.PrintfStatContext):
        """
        printfStat: 'printf' '(' STRING (',' expr)* ')' ';';
        """
        self.str = self.str + '"printfStat":{'
        text = ctx.STRING().getText()
        self.str = self.str + '"STRING":"' + text + '",'
        if text in self.msg:
            variable = self.msg[text]
        else:
            str_len = len(parse_escape(text[1:-1]))
            msg = LLVMTypes.get_const_from_str(ir.ArrayType(LLVMTypes.char, str_len+1), const_value=text)
            variable = ir.GlobalVariable(self.builder.module, ir.ArrayType(LLVMTypes.char, str_len+1), name=text)
            variable.initializer = msg
            self.msg[text] = variable
        zero = ir.Constant(ir.types.IntType(32), 0)
        msg = variable.gep((zero, zero))
        args = [msg]
        for i in ctx.expr():
            if i.children[0].getText() == '&':
                arg = self.visit(i) 
            else:
                arg = self.visit(i)
                if isinstance(arg.type,ir.PointerType):
                    arg = self.builder.load(arg)
                if isinstance(arg.type,ir.ArrayType):
                    arg = self.local_vars[self.scope + i.getText()]
            args.append(arg)
        self.builder.call(self.local_vars["printf"],args)
        self.str = self.str + '},'

    def visitScanfStat(self, ctx:C2LLVMParser.ScanfStatContext):
        """
        scanfStat: 'scanf' '(' STRING (',' expr)+ ')' ';';
        """
        self.str = self.str + '"scanfStat":{'
        text = ctx.STRING().getText()
        self.str = self.str + '"STRING":"' + text + '",'
        if text in self.msg:
            variable = self.msg[text]
        else:
            str_len = len(parse_escape(text[1:-1]))
            msg = LLVMTypes.get_const_from_str(ir.ArrayType(LLVMTypes.char, str_len+1), const_value=text)
            variable = ir.GlobalVariable(self.builder.module, ir.ArrayType(LLVMTypes.char, str_len+1), name=text)
            variable.initializer = msg
            self.msg[text] = variable
        zero = ir.Constant(ir.types.IntType(32), 0)
        msg = variable.gep((zero, zero))
        args = [msg]
        for i in ctx.expr():
            arg = self.visit(i)
            if isinstance(arg.type,ir.ArrayType):
                arg = self.local_vars[self.scope + i.getText()]
            args.append(arg)
        self.builder.call(self.local_vars["scanf"],args)
        self.str = self.str + '},'

    def visitBlock(self, ctx: C2LLVMParser.BlockContext):
        """
        block: whileBlock | ifBlock | elseBlock | elseifBlock;
        """
        self.str = self.str + '"Block":{'
        self.visit(ctx.children[0]) #TODO补充所有block
        self.str = self.str + '},'

    def visitWhileBlock(self, ctx:C2LLVMParser.WhileBlockContext):
        """
        whileBlock: 'while' '(' condition ')' packcontent;
        """
        self.str = self.str + '"whileBlock":{'
        #nowd = self.depth
        #with self.builder.goto_block(self.Blocks[nowd]):
        #curblock = self.Blocks[-1]
        #self.builder.position_at_end(curblock)
        name_prefix = self.builder.block.name
        cond_block = self.builder.append_basic_block(name=name_prefix+".while_cond")  # 条件判断语句块
        loop_block = self.builder.append_basic_block(name=name_prefix+".while_body")  # 循环语句块
        end_block = self.builder.append_basic_block(name=name_prefix+".while_end")    # 循环结束后的语句块
        
        # 保存原先的continue_block和break_block
        last_continue, last_break = self.continue_block, self.break_block
        self.continue_block, self.break_block = cond_block, end_block
        
        cond = ctx.condition()
        self.builder.branch(cond_block)   #这里应该是写condblock的内容
        self.builder.position_at_start(cond_block)
        cond_val = self.visit(cond)
        cond_val = LLVMTypes.cast_python_to_LLVM(self.builder,cond_val)
        converted_cond_val = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.bool, value=cond_val)
        self.builder.cbranch(converted_cond_val, loop_block, end_block)   #第一参数为真，跳到loopblock

        self.builder.position_at_start(loop_block)  #这里是写loopblock的内容
        self.visit(ctx.packcontent())
        self.builder.branch(cond_block)

        # 恢复原先的continue_block和break_block
        self.builder.position_at_start(end_block)
        self.continue_block = last_continue
        self.break_block = last_break
        self.str = self.str + '},'

    def visitIfBlock(self, ctx:C2LLVMParser.IfBlockContext):
        """
        ifBlock: 'if' '(' condition ')' packcontent elseBlock?;
        """
        self.str = self.str + '"ifBlock":{'
        #nowd = self.depth
        #with self.builder.goto_block(self.Blocks[nowd]):
        #curblock = self.Blocks[-1]
        #self.builder.position_at_end(curblock)
        cond_val = self.visit(ctx.condition())
        converted_cond_val = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.bool, value=cond_val)
        if len(ctx.children) == 6:  # 存在else分支
            with self.builder.if_else(converted_cond_val) as (then, otherwise):
                with then:
                    self.visit(ctx.packcontent())
                with otherwise:
                    self.visit(ctx.elseBlock())
        else:  # 只有if分支
            with self.builder.if_then(converted_cond_val):
                self.visit(ctx.packcontent())
        self.str = self.str + '},'


    def visitElseBlock(self, ctx: C2LLVMParser.ElseBlockContext):
        """
        elseBlock: 'else' packcontent;
        """
        self.str = self.str + '"elseBlock":{'
        self.visit(ctx.packcontent())
        self.str = self.str + '},'


    def visitExpr(self, ctx:C2LLVMParser.ExprContext):
        """
        expr: (StrVar | number | arrayValue | funcExpr | CHAR | STRING)
	        | expr operator (StrVar | number | arrayValue | funcExpr | CHAR)
	        | '&' (StrVar | arrayValue);
        operator: '+' | '-' | '*' | '/' | '->';
        :param ctx:
        :return: 表达式的值
        """
        self.str = self.str + '"expr":{'
        retval = LLVMTypes.get_const_from_str(LLVMTypes.int, '-1')
        if ctx.StrVar():
            text = ctx.StrVar().getText()
            self.str = self.str + '"StrVar":"' + text + '",'
            if self.scope + text in self.local_vars:
                varp = self.local_vars[self.scope + text]
                retval = varp
            else:
                # TODO raise exception
                print(self.module.functions)
                print("Undefined identifier: '%s'\n" % text)
        elif ctx.number():
            text = ctx.number().getText()
            self.str = self.str + '"number":"' + text + '",'
            retval = LLVMTypes.get_const_from_str(LLVMTypes.int, text)
        elif ctx.arrayValue():  # 数组情况
            retval = self.visit(ctx.arrayValue())
        elif ctx.funcExpr():  #函数情况，注意有强制类型转换
            if len(ctx.children) == 2:
                convertedType = self.visit(ctx.children[0]) #转换后类型
                val = self.visit(ctx.children[1])
                if isinstance(convertedType, ir.PointerType):
                    val = self.builder.bitcast(val, convertedType)
                else:
                    val = LLVMTypes.cast_type(self.builder, convertedType, val)
                retval = val
            else: # func
                retval = self.visit(ctx.children[0])
        elif ctx.CHAR():
            text = ctx.CHAR().getText()
            self.str = self.str + '"CHAR":"' + text + '",'
            retval = LLVMTypes.get_const_from_str(LLVMTypes.char, text)
        elif ctx.STRING():
            text = ctx.STRING().getText()
            self.str = self.str + '"STRING":"' + text + '",'
            str_len = len(parse_escape(text[1:-1]))
            retval = LLVMTypes.get_const_from_str(ir.ArrayType(LLVMTypes.char, str_len+1), const_value=text)
        if len(ctx.children) == 3:  #需要判断运算符号以及运算对象是常量还是变量
            lval = self.visit(ctx.expr())
            op = ctx.operator().getText()
            if isinstance(lval.type,ir.PointerType) and op != "->":
                lval = self.builder.load(lval)
            op = ctx.operator().getText()
            self.str = self.str + '"op":"' + op + '",'
            if isinstance(retval.type,ir.PointerType):
                retval = self.builder.load(retval)
            if op == '+':
                retval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=retval)
                lval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=lval)  #将两个值都转换为int
                retval = self.builder.add(lval, retval)   #两值相加
            elif op == '/':
                retval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=retval)
                lval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=lval)  #将两个值都转换为int
                retval = self.builder.sdiv(lval, retval)
            elif op == '*':
                retval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=retval)
                lval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=lval)  #将两个值都转换为int
                retval = self.builder.mul(lval, retval)
            elif op == '-':
                retval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=retval)
                lval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=lval)  # 将两个值都转换为int
                retval = self.builder.sub(lval, retval)
            elif op == '==':  # TODO 其他运算符
                retval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=retval)
                lval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=lval)  # 将两个值都转换为int
                retval = self.builder.icmp_signed("==", lval, retval)  # retval是LLVM的bool值
            elif op == '!=':
                retval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=retval)
                lval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=lval)  # 将两个值都转换为int
                retval = self.builder.icmp_signed("!=", lval, retval)
            elif op == '->':
                varName = ctx.children[0].getText()
                memberName = ctx.children[2].getText()
                varp = self.local_vars[self.scope + varName]
                structName = varp.type
                while isinstance(structName, ir.PointerType):
                    structName = structName.pointee
                structName = structName.name
                index = self.structs[structName][memberName]
                while self.depthOfPointer(varp.type) > 1:
                    varp = self.builder.load(varp)
                retval = self.builder.gep(varp, [index])
                valueType = self.struct_entry_types[structName][memberName]
                valueType = LLVMTypes.get_pointer_type(valueType)
                retval = self.builder.bitcast(retval, valueType)
            self.str = self.str + '},'
            return retval
        elif len(ctx.children) == 2:
            if ctx.StrVar():
                text = ctx.StrVar().getText()
                self.str = self.str + '"StrVar":"' + text + '",'
                return_val = self.local_vars[self.scope + text]
                self.str = self.str + '},'
                return return_val
            else:
                return_val = self.visit(ctx.children[1])
                self.str = self.str + '},'
                return return_val
        else:
            self.str = self.str + '},'
            return retval

    def visitCustomFunc(self, ctx: C2LLVMParser.CustomFuncContext):
        """
        customFunc: StrVar '(' actualParams ')' ;
        :param ctx:
        :return: 函数返回值
        """
        self.str = self.str + '"customFunc":{'
        function_name = ctx.StrVar().getText()
        self.str = self.str + '"StrVar":"' + function_name + '",'
        if function_name in self.local_vars:
            function_var = self.local_vars[function_name]
            if type(function_var) in [ir.Argument, ir.Function]:
                pass
            else:
                if isinstance(function_var.type.pointee, ir.ArrayType) or isinstance(function_var.type.pointee, ir.IdentifiedStructType):
                    zero = ir.Constant(LLVMTypes.int, 0)
                    function_var = self.builder.gep(function_var, [zero, zero])
                else:
                    function_var = self.builder.load(function_var)
        else:
            # 报错，函数未声明
            raise SemanticError(ctx = ctx,msg ="undefined function_name"+function_name)
        actualParams = self.visit(ctx.actualParams()) #拿到传入参数的地址，然后我拿值，传进函数
        converted_args = []
        for argp, callee_arg in zip(actualParams, function_var.args):
            arg = argp
            if isinstance(argp.type,ir.PointerType):
                arg = self.builder.load(argp)
                if isinstance(arg.type,ir.ArrayType):
                    arg = self.builder.gep(argp,[LLVMTypes.int(0),LLVMTypes.int(0)])
                else:
                    pass
            # arg = LLVMTypes.cast_type(self.builder, value=arg, target_type=callee_arg.type)
            converted_args.append(arg)
        self.str = self.str + '},'
        return self.builder.call(function_var, converted_args)

    def visitActualParams(self, ctx: C2LLVMParser.ActualParamsContext):
        """
        actualParams: actualParam | actualParam ',' actualParams |;
        :param ctx:
        :return: 返回变量表达式列表actual_arg_expr_list
        """
        self.str = self.str + '"actualParams":{'
        actual_arg_expr_list = []
        if ctx.children is None:
            self.str = self.str + '},'
            return actual_arg_expr_list
        elif len(ctx.children) > 1:
            actual_arg_expr_list = self.visit(ctx.actualParams())
        actual_arg_expr = self.visit(ctx.actualParam())
        # if isinstance(actual_arg_expr.type,ir.PointerType):
        #     actual_arg_expr = self.builder.load(actual_arg_expr)
        actual_arg_expr_list.append(actual_arg_expr)
        self.str = self.str + '},'
        return actual_arg_expr_list

    def visitActualParam(self, ctx: C2LLVMParser.ActualParamContext):
        """
        actualParam: expr
        :param ctx:
        :return 返回变量表达式
        """
        self.str = self.str + '"actualParam":{'
        return_val = self.visit(ctx.expr())
        self.str = self.str + '},'
        return return_val


    def visitCondition(self, ctx: C2LLVMParser.ConditionContext):
        """
        condition: expr | '(' expr ')' logic condition | condition logic condition | '(' condition ')';
        return:表达式的值
        """
        self.str = self.str + '"condition":{'
        if len(ctx.children) == 1:
            val = self.visit(ctx.children[0])
            self.str = self.str + '},'
            return val
        elif len(ctx.children) == 3:  # TODO补充
            child = ctx.children[0]
            if self.match_rule(child, C2LLVMParser.RULE_condition):  # condition logic condition
                # logic: '&&' | '||' |  '==' | '!=' | '>' | '>=' | '<=' | '<' | '>';
                lval = self.visit(child)
                logic = ctx.logic().getText()
                self.str = self.str + '"logic":"' + logic + '",'
                rval = self.visit(ctx.children[2])
                if isinstance(lval.type, ir.PointerType):
                    lval = self.builder.load(lval)
                if isinstance(rval.type, ir.PointerType):
                    rval = self.builder.load(rval)
                if logic == "&&":
                    lval = LLVMTypes.cast_type(self.builder, LLVMTypes.bool, lval)
                    rval = LLVMTypes.cast_type(self.builder, LLVMTypes.bool, rval)
                    boolRetVal = self.builder.and_(lval, rval)
                    boolRetVal = LLVMTypes.cast_type(self.builder, LLVMTypes.bool, boolRetVal)
                elif logic == "||":
                    lval = LLVMTypes.cast_type(self.builder, LLVMTypes.bool, lval)
                    rval = LLVMTypes.cast_type(self.builder, LLVMTypes.bool, rval)
                    boolRetVal = self.builder.or_(lval, rval)
                    boolRetVal = LLVMTypes.cast_type(self.builder, LLVMTypes.bool, boolRetVal)
                else:
                    # rval = LLVMTypes.cast_type(self.builder, target_type=lval.type, value=rval)
                    boolRetVal = self.builder.icmp_signed(logic, lval, rval)
                self.str = self.str + '},'
                return boolRetVal
            else:
                return_val = self.visit(ctx.children[1])
                self.str = self.str + '},'
                return return_val

        # TODO补充长度为5时情况

    def visitArrayValue(self, ctx:C2LLVMParser.ArrayValueContext):
        """
        arrayValue: StrVar '[' expr ']';
        """
        self.str = self.str + '"arrayValue":{'
        var = ctx.StrVar().getText()
        self.str = self.str + '"StrVar":"' + var + '",'
        varp = self.local_vars[self.scope + var]
        index = self.visit(ctx.expr())
        if isinstance(index.type, ir.PointerType):
            index = self.builder.load(index)
        index = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=index)
        if isinstance(varp.type.pointee, ir.ArrayType):
            valp = self.builder.gep(varp, [LLVMTypes.int(0), index])
        else:
            valp = self.builder.load(varp)
            if isinstance(valp.type, ir.PointerType):
                valp = self.builder.gep(valp, [index])
        self.str = self.str + '},'
        return valp


    def visitArray(self, ctx:C2LLVMParser.ArrayContext):
        """
        array: StrVar '[' INT? ']';
        """
        self.str = self.str + '"array":{'
        if len(ctx.children) == 4:
            var = ctx.StrVar().getText()
            self.str = self.str + '"StrVar":"' + var + '",'
            size = LLVMTypes.get_const_from_str(LLVMTypes.int,ctx.INT().getText())
            self.str = self.str + '"size":"' + ctx.INT().getText() + '",'
            if size.constant <= 0:
                print("array size <= 0 error")
            self.str = self.str + '},'
            return var, size
        else:#TODO 不定长数组(也可以不做)，形如char i[]="hi"
            self.str = self.str + '},'
            return None, None

    def visitPre(self, ctx:C2LLVMParser.PreContext):
        """
        pre: '(' StrVar '*'? ')'
        return: StrVar -> type
        """
        self.str = self.str + '"pre":{'
        typeName = ctx.children[1].getText()
        varType = self.global_context.get_identified_type(typeName)
        if not varType:
            varType = LLVMTypes.str2type(typeName)
        if len(ctx.children) == 4:#指针类型转换
            self.str = self.str + '},'
            return LLVMTypes.get_pointer_type(varType)
        elif len(ctx.children) == 3:#正常类型转换
            self.str = self.str + '},'
            return varType

    def visitStructPack(self, ctx: C2LLVMParser.StructPackContext):
        self.str = self.str + '"structPack":{'
        children1 = ctx.children[1].getText()
        new_struct = self.global_context.get_identified_type(children1)
        self._inside_struct_ = 1
        self._current_struct_ = children1
        self.structs[children1] = {}
        self.struct_entry_types[children1] = {}
        self.visitContent(ctx)
        self._inside_struct_ = 0
        self.struct_sizes[children1] = self._current_struct_size_
        self._current_struct_size_ = LLVMTypes.int(0)
        values = self.struct_entry_types[children1].values()
        new_struct.set_body(*values)
        self.str = self.str + '},'

    def getTypeSize(self, llvm_type):
        """
        输入：llvm_type
        输出：其size的python值
        """
        if isinstance(llvm_type, ir.PointerType) or llvm_type == LLVMTypes.int:
            return 4
        elif llvm_type == LLVMTypes.char:
            return 1
        elif isinstance(llvm_type, ir.ArrayType):
            print("数组类型大小计算尚未实现！以后有需要再开发！")
            total_size = 0
            for i in llvm_type.elements:
                total_size = total_size + self.getTypeSize(i)
            return total_size
        elif isinstance(llvm_type, ir.IdentifiedStructType):
            total_size = 0
            for i in llvm_type.elements:
                total_size = total_size + self.getTypeSize(i)
            return total_size

    def visitMallocFunc(self, ctx: C2LLVMParser.MallocFuncContext):
        """
        'malloc' '(' 'sizeof' '(' StrVar ')' ')'
        StrVar is name of an identified_struct
        return：LLVM size of StrVar struct
        """
        typeName = ctx.children[4].getText()
        varType = self.global_context.get_identified_type(typeName)
        size = self.getTypeSize(varType)
        size = LLVMTypes.int(size)
        varp = self.builder.alloca(LLVMTypes.char, size)
        return varp

    def visitFunc(self, ctx: C2LLVMParser.FuncContext):
        return self.visit(ctx.children[0])

    def visitFuncExpr(self, ctx: C2LLVMParser.FuncExprContext):
        """
        pre func
        目前只实现了malloc,因为它是唯一的funcexpr
        """
        if len(ctx.children) == 2:  # 有类型转换pre
            varType = self.visit(ctx.children[0])
            varp = self.visit(ctx.children[1])
            varp = self.builder.bitcast(varp, varType)
            return varp
        else:
            return self.visit(ctx.children[0])
    def saveJSON(self, filename):
        """保存到文件"""
        with open(filename, "w") as f:
            f.write(self.str)

    def save(self, filename):
        """保存到文件"""
        with open(filename, "w") as f:
            f.write(repr(self.module))

