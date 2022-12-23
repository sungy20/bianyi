from pickle import NONE
from antlr_about.C2LLVMVisitor import C2LLVMVisitor
from antlr_about.C2LLVMParser import C2LLVMParser
import llvmlite.ir as ir
from generator.types import LLVMTypes
from generator.util import parse_escape
from generator.errors import *

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
        self.emit_printf()
        self.Blocks = []
        self._inside_struct_ = 0
        self._current_struct_ = None
        self._current_struct_size_ = LLVMTypes.int(0)
        self.global_context = ir.global_context

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

    def visitStart(self, ctx:C2LLVMParser.StartContext):
        for child in ctx.children:
            self.visit(child) 

    def visitCodeBlock(self, ctx: C2LLVMParser.CodeBlockContext):
        for child in ctx.children:
            self.visit(child)

    def visitFunction(self, ctx:C2LLVMParser.FunctionContext):
        """
        function : varType StrVar '(' params ')' packcontent;
        eg: void hi(char *who, int *i);
        """
        ret_type = LLVMTypes.str2type[ctx.varType().getText()]  #函数返回值的类型
        func_name = ctx.StrVar().getText()
        args_type, args_name = self.visit(ctx.params())
        function_type = ir.FunctionType(ret_type,(args_type))
        llvm_function = ir.Function(self.module, function_type, name=func_name)  #创建llvm函数
        self.builder = ir.IRBuilder(llvm_function.append_basic_block(name=func_name))#

        self.local_vars[func_name] = llvm_function

        for arg_name, llvm_arg in zip(args_name, llvm_function.args):
            varp = self.builder.alloca(llvm_arg.type)
            self.builder.store(llvm_arg, varp)
            self.local_vars[arg_name] = varp

        self.continue_block = None
        self.break_block = None
        self.visit(ctx.packcontent())
        # TODO补充函数没有return的情况

    def visitParams(self, ctx:C2LLVMParser.ParamsContext):
        """
        params : param | param ',' params |;
        :param ctx:
        :return: 返回变量名字列表arg_names和变量类型列表arg_types
        """
        arg_names = []
        arg_types = []
        if ctx.children is None:
            return arg_types, arg_names
        elif len(ctx.children) > 1:
            arg_types, arg_names = self.visit(ctx.params())
        arg_type, arg_name = self.visit(ctx.param())
        arg_names.append(arg_name)
        arg_types.append(arg_type)
        return arg_types, arg_names

    def visitParam(self, ctx:C2LLVMParser.ParamContext):
        """
        param: usualType StrVar;
        :param ctx:
        :return: 声明变量的名字和类型
        """
        arg_type = self.visit(ctx.usualType())
        arg_name = ctx.StrVar().getText()
        return arg_type, arg_name

    def visitUsualType(self, ctx:C2LLVMParser.UsualTypeContext):
        """
        usualType: varType | pointerType ;
        pointerType: varType '*' | 'struct' StrVar '*' | StrVar '*';
        varType: varType: 'int' | 'char' | 'struct';
        :param ctx:
        :return: 对应的LLVM类型
        """
        if self.match_rule(ctx.children[0], C2LLVMParser.RULE_pointerType):
            # 指针类型
            pt = ctx.pointerType()
            var_tp = self.visit(pt)
            pointer_tp = LLVMTypes.get_pointer_type(var_tp)
            return pointer_tp
        elif self.match_texts(ctx, LLVMTypes.str2type.keys()):
            # 'int' | 'char' | 'struct'
            return LLVMTypes.str2type[ctx.getText()]   #TODO: sssssssssssss结构体
        else:
            print("Error: unknown type ", ctx.getText())
            exit(-1)

    def visitPointerType(self, ctx:C2LLVMParser.PointerTypeContext):
        """
        pointerType: varType '*' | 'struct' StrVar '*' | StrVar '*';
        return:指针对应类型
        """
        returnType = LLVMTypes.char
        if ctx.varType():
            returnType = LLVMTypes.str2type[ctx.varType().getText()]
        else:
            struct_name = ctx.children[0].getText()
            if struct_name == 'struct':
                struct_name = ctx.children[1].getText()
            returnType = self.global_context.get_identified_type(struct_name)
        return returnType

    def visitPackcontent(self, ctx: C2LLVMParser.PackcontentContext):
        """
        packcontent: (stat | block | ) | ('{' content '}');
        """
        if len(ctx.children) == 3:
            self.visit(ctx.content())
        elif len(ctx.children) == 1:
            self.visit(ctx.children[0])

    def visitContent(self, ctx: C2LLVMParser.ContentContext):
        """
        content : (stat|block) content | (stat|block) | ;
        """
        if ctx.children is None:
            return
        elif len(ctx.children) == 1:
            self.visit(ctx.children[0])
        else:
            self.visit(ctx.children[0])
            self.visit(ctx.content())

    def visitStat(self, ctx: C2LLVMParser.StatContext):
        """
        stat : declareStat | assignStat | breakStat | returnStat | freeStat | continueStat | (customFunc ';') | scanfStat | printfStat;
        """
        self.visit(ctx.children[0])

    def visitDeclareStat(self, ctx: C2LLVMParser.DeclareStatContext):  #TODO
        """
        declareStat: (usualType StrVar |  varType array) ';';
        """
        if ctx.children[0].getText() == "struct" and not self._inside_struct_:  # 声明结构体对象
            # TODO 目前不支持声明数组
            struct_type = ctx.children[1].getText()
            struct_obj = ctx.children[2].getText()
            type_self = self.global_context.get_identified_type(struct_type)
            varp = self.builder.alloca(type_self)
            self.local_vars[struct_obj] = varp
        elif not self._inside_struct_:
            if len(ctx.children) == 3:  # 正常情况
                if self.match_rule(ctx.children[1], C2LLVMParser.RULE_array):  # 声明数组
                    vtype = LLVMTypes.str2type[ctx.varType().getText()]
                    var, size = self.visit(ctx.array())
                    if size == None:
                        print("declare need size")
                    varp = LLVMTypes.get_array_type(vtype, size.constant)
                    varp = self.builder.alloca(varp, size)
                    self.local_vars[var] = varp
                else:  # 声明单个变量
                    varType = self.visit(ctx.usualType())
                    var = ctx.StrVar().getText()
                    # 申请栈空间，并返回对应的指针
                    varp = self.builder.alloca(varType)
                    self.local_vars[var] = varp
            else:
                pass
        elif ctx.children[0].getText() != "struct": #结构体内声明正常变量
            if len(ctx.children) == 3:  # 正常情况
                if self.match_rule(ctx.children[1], C2LLVMParser.RULE_array):  # 声明数组
                    vtype = LLVMTypes.str2type[ctx.varType().getText()]
                    var, size = self.visit(ctx.array())
                    if size == None:
                        print("declare need size")
                    self.structs[self._current_struct_][var] = self._current_struct_size_
                    current_variable_size = LLVMTypes.int(1)
                    current_variable_size = self.builder.mul(current_variable_size, size)
                    self.struct_entry_types[self._current_struct_][var] = vtype
                    self._current_struct_size_ = LLVMTypes.int(self._current_struct_size_.constant + current_variable_size.constant)
                else:  # 声明单个变量
                    vtype = self.visit(ctx.usualType())
                    var = ctx.children[1].getText()
                    self.structs[self._current_struct_][var] = self._current_struct_size_
                    current_variable_size = LLVMTypes.int(1)
                    self.struct_entry_types[self._current_struct_][var] = vtype
                    self._current_struct_size_ = LLVMTypes.int(self._current_struct_size_.constant + current_variable_size.constant)
            else:
                print("结构体定义内声明结构体成员，尚未完成！")

    def visitAssignStat(self, ctx: C2LLVMParser.AssignStatContext):
        """
        assignStat: (usualType StrVar | StrVar | arrayValue | expr | varType array) '=' expr ';';
        """
        """
        if len(ctx.children) == 6:  #struct StrVar StrVar = expr ;的情况
            if ctx.children[0].getText() == "struct":
                struct_type = self.visit(ctx.children[1])
                struct_obj = ctx.children[2].getText()
                varp = self.builder.alloca(LLVMTypes.char, self.struct_sizes[struct_type])
                self.local_vars[struct_obj] = varp
                val = self.visit(ctx.children[4])
                varp = LLVMTypes.cast_type(self.builder, LLVMTypes.get_pointer_type(val.type), varp)
                self.builder.store(val, varp)
        """
        if len(ctx.children) == 5:  # usualType StrVar = expr ;的情况
            if ctx.usualType():  # 单个变量的情况
                varType = self.visit(ctx.usualType())
                var = ctx.StrVar().getText()
                val = self.visit(ctx.expr()[0])
                if ctx.expr()[0].children[0].getText() == '&':
                    pass
                else:
                    if isinstance(val.type, ir.PointerType) and not isinstance(varType, ir.PointerType):
                        val = self.builder.load(val)
                if isinstance(val.type, ir.IdentifiedStructType) or isinstance(varType, ir.IdentifiedStructType):
                    converted_rhs = val
                else:
                    converted_rhs = LLVMTypes.cast_type(self.builder, varType, val)  # 将val转换为varType类型
                # 申请栈空间，并返回对应的指针
                varp = self.builder.alloca(varType)
                # 将值存储到指定的位置
                self.builder.store(converted_rhs, varp)
                self.local_vars[var] = varp
            else:  # 数组的情况
                vtype = LLVMTypes.str2type[ctx.varType().getText()]
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
                    addr = self.builder.gep(varp, [LLVMTypes.int(i), LLVMTypes.int(i)])
                    self.builder.store(singleval, addr)
                # self.builder.bitcast(varp,LLVMTypes.get_pointer_type(vtype))   
                self.local_vars[var] = varp
        elif len(ctx.children) == 4:  # (expr|strvar|arrayvalue) = expr ;的情况
            if (ctx.StrVar()):
                var = ctx.children[0].getText()
                varp = self.local_vars[var]
                varType = varp.type.pointee
                valp = self.visit(ctx.children[2])
                if isinstance(valp.type, ir.PointerType) and not isinstance(varType, ir.PointerType):
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
                varType = valp.type.pointee
                val = self.visit(ctx.children[2])
                if isinstance(val.type, ir.PointerType) and not isinstance(varType, ir.PointerType):
                    val = self.builder.load(val)
                converted_val = LLVMTypes.cast_type(self.builder, varType, val)
                if converted_val is None:
                    converted_val = val
                self.builder.store(converted_val, valp)
                print("yes")
        else:
            pass

    def visitBreakStat(self, ctx: C2LLVMParser.BreakStatContext):
        self.builder.branch(self.break_block)

    def visitReturnStat(self, ctx: C2LLVMParser.ReturnStatContext):
        """
         'return' expr ';'
        """
        ret_val = self.visit(ctx.expr())
        if isinstance(ret_val.type, ir.PointerType):
            ret_val = self.builder.load(ret_val)
        converted_val = LLVMTypes.cast_type(
            self.builder, target_type=self.builder.function.type.pointee.return_type, value=ret_val)
        self.builder.ret(converted_val)
        print(self.module)

    def visitContinueStat(self, ctx:C2LLVMParser.ContinueStatContext):
        self.builder.branch(self.continue_block)

    def visitFreeStat(self, ctx: C2LLVMParser.FreeStatContext):
        pass
        #TODO

    def visitPrintfStat(self, ctx: C2LLVMParser.PrintfStatContext):
        """
        printfStat: 'printf' '(' STRING (',' expr)* ')' ';';
        """
        text = ctx.STRING().getText()
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
                    arg = self.local_vars[i.getText()]
            args.append(arg)
        self.builder.call(self.local_vars["printf"],args)

    def visitScanfStat(self, ctx:C2LLVMParser.ScanfStatContext):
        """
        scanfStat: 'scanf' '(' STRING (',' expr)+ ')' ';';
        """
        text = ctx.STRING().getText()
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
                arg = self.local_vars[i.getText()]
            args.append(arg)
        self.builder.call(self.local_vars["scanf"],args)

    def visitBlock(self, ctx: C2LLVMParser.BlockContext):
        """
        block: whileBlock | ifBlock | elseBlock | elseifBlock;
        """
        
        self.visit(ctx.children[0]) #TODO补充所有block

    def visitWhileBlock(self, ctx:C2LLVMParser.WhileBlockContext):
        """
        whileBlock: 'while' '(' condition ')' packcontent;
        """
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

    def visitIfBlock(self, ctx:C2LLVMParser.IfBlockContext):
        """
        ifBlock: 'if' '(' condition ')' packcontent elseBlock?;
        """
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


    def visitElseBlock(self, ctx: C2LLVMParser.ElseBlockContext):
        """
        elseBlock: 'else' packcontent;
        """
        self.visit(ctx.packcontent())


    def visitExpr(self, ctx:C2LLVMParser.ExprContext):
        """
        expr: (StrVar | number | arrayValue | funcExpr | CHAR | STRING)
	        | expr operator (StrVar | number | arrayValue | funcExpr | CHAR)
	        | '&' (StrVar | arrayValue);
        operator: '+' | '-' | '*' | '/' | '->';
        :param ctx:
        :return: 表达式的值
        """
        retval = LLVMTypes.get_const_from_str(LLVMTypes.int, '-1')
        if ctx.StrVar():
            text = ctx.StrVar().getText()
            if text in self.local_vars:
                varp = self.local_vars[text]
                retval = varp
            else:
                # TODO raise exception
                print(self.module.functions)
                print("Undefined identifier: '%s'\n" % text)
        elif ctx.number():
            text = ctx.number().getText()
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
            retval = LLVMTypes.get_const_from_str(LLVMTypes.char, text)
        elif ctx.STRING():
            text = ctx.STRING().getText()
            str_len = len(parse_escape(text[1:-1]))
            retval = LLVMTypes.get_const_from_str(ir.ArrayType(LLVMTypes.char, str_len+1), const_value=text)
        if len(ctx.children) == 3:  #需要判断运算符号以及运算对象是常量还是变量
            lval = self.visit(ctx.expr())
            op = ctx.operator().getText()
            if isinstance(lval.type,ir.PointerType) and op != "->":
                lval = self.builder.load(lval)
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
                varp = self.local_vars[varName]
                structName = varp.type
                while isinstance(structName, ir.PointerType):
                    structName = structName.pointee
                structName = structName.name
                index = self.structs[structName][memberName]
                retval = self.builder.gep(varp, [index])
                valueType = self.struct_entry_types[structName][memberName]
                valueType = LLVMTypes.get_pointer_type(valueType)
                retval = self.builder.bitcast(retval, valueType)
            return retval
        elif len(ctx.children) == 2:
            if ctx.StrVar():
                text = ctx.StrVar().getText()
                return self.local_vars[text]
            else:
                return self.visit(ctx.children[1])
        else:
            return retval

    def visitCustomFunc(self, ctx: C2LLVMParser.CustomFuncContext):
        """
        customFunc: StrVar '(' actualParams ')' ;
        :param ctx:
        :return: 函数返回值
        """
        function_name = ctx.StrVar().getText()
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
        # args_val=[]
        # for arg in actualParams:
        #     if isinstance(arg.type,ir.PointerType):
        #         args_val.append(self.builder.load(arg))
        #     else:
        #         args_val.append(arg)
        converted_args = []
        for argp, callee_arg in zip(actualParams, function_var.args):
            if isinstance(argp.type,ir.PointerType):
                arg = self.builder.load(argp)
                if isinstance(arg.type,ir.ArrayType):
                    # arg = LLVMTypes.cast_type(self.builder, value=arg, target_type=callee_arg.type)
                    arg = self.builder.gep(argp,[LLVMTypes.int(0),LLVMTypes.int(0)])
                else:
                    pass
            converted_args.append(arg)
            # if isinstance(arg.type,ir.types.IntType):
            #     # varpp = self.builder.alloca(varp.type)
            #     # self.builder.store(varp,varpp)

            #     converted_args.append(arg)
            # else:
            # converted_args.append(LLVMTypes.cast_type(self.builder, value=arg, target_type=callee_arg.type))
        # if len(converted_args) < len(actualParams):  # 考虑变长参数
        #     converted_args += actualParams[len(function_var.args):]

        return self.builder.call(function_var, converted_args)

    def visitActualParams(self, ctx: C2LLVMParser.ActualParamsContext):
        """
        actualParams: actualParam | actualParam ',' actualParams |;
        :param ctx:
        :return: 返回变量表达式列表actual_arg_expr_list
        """
        actual_arg_expr_list = []
        if ctx.children is None:
            return actual_arg_expr_list
        elif len(ctx.children) > 1:
            actual_arg_expr_list = self.visit(ctx.actualParams())
        actual_arg_expr = self.visit(ctx.actualParam())
        # if isinstance(actual_arg_expr.type,ir.PointerType):
        #     actual_arg_expr = self.builder.load(actual_arg_expr)
        actual_arg_expr_list.append(actual_arg_expr)
        return actual_arg_expr_list

    def visitActualParam(self, ctx: C2LLVMParser.ActualParamContext):
        """
        actualParam: expr
        :param ctx:
        :return 返回变量表达式
        """
        return self.visit(ctx.expr())

    def visitCondition(self, ctx: C2LLVMParser.ConditionContext):
        """
        condition: expr | '(' expr ')' logic condition | condition logic condition | '(' condition ')';
        return:表达式的值
        """
        if len(ctx.children) == 1:
            val = self.visit(ctx.children[0])
            return val
        elif len(ctx.children) == 3:  # TODO补充
            child = ctx.children[0]
            if self.match_rule(child, C2LLVMParser.RULE_condition):  # condition logic condition
                # logic: '&&' | '||' |  '==' | '!=' | '>' | '>=' | '<=' | '<' | '>';
                lval = self.visit(child)
                logic = ctx.logic().getText()
                rval = self.visit(ctx.children[2])
                if isinstance(lval.type, ir.PointerType):
                    lval = self.builder.load(lval)
                if isinstance(rval.type, ir.PointerType):
                    rval = self.builder.load(rval)
                if logic == "&&":
                    boolRetVal = self.builder.and_(lval, rval)
                elif logic == "||":
                    boolRetVal = self.builder.or_(lval, rval)
                else:
                    boolRetVal = self.builder.icmp_signed(logic, lval, rval)
                return boolRetVal
            else:
                return self.visit(ctx.children[1])

        # TODO补充长度为5时情况

    def visitArrayValue(self, ctx:C2LLVMParser.ArrayValueContext):
        """
        arrayValue: StrVar '[' expr ']';
        """
        var = ctx.StrVar().getText()
        varp = self.local_vars[var]
        index = self.visit(ctx.expr())
        if isinstance(index.type, ir.PointerType):
            index = self.builder.load(index)
        index = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=index)
        if isinstance(varp.type.pointee, ir.ArrayType):
            valp = self.builder.gep(varp, [LLVMTypes.int(0),index])
        else:
            valp = self.builder.load(varp)
            if isinstance(valp.type, ir.PointerType):
                valp = self.builder.gep(valp, [index])
        return valp


    def visitArray(self, ctx:C2LLVMParser.ArrayContext):
        """
        array: StrVar '[' INT? ']';
        """
        if len(ctx.children) == 4:
            var = ctx.StrVar().getText()
            size = LLVMTypes.get_const_from_str(LLVMTypes.int,ctx.INT().getText())
            if size.constant <= 0:
                print("array size <= 0 error")
            return var, size
        else:#TODO 不定长数组(也可以不做)，形如char i[]="hi"
            return None, None

    def visitPre(self, ctx:C2LLVMParser.PreContext):
        """
        pre: '(' StrVar '*'? ')'
        return: StrVar -> type
        """
        typeName = ctx.children[1].getText()
        varType = self.global_context.get_identified_type(typeName)
        if not varType:
            varType = LLVMTypes.str2type(typeName)
        if len(ctx.children) == 4:#指针类型转换
            return LLVMTypes.get_pointer_type(varType)
        elif len(ctx.children) == 3:#正常类型转换
            return varType

    def visitStructPack(self, ctx: C2LLVMParser.StructPackContext):
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

    def save(self, filename):
        """保存到文件"""
        with open(filename, "w") as f:
            f.write(repr(self.module))

