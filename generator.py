﻿from pickle import NONE
from antlr_about.C2LLVMVisitor import C2LLVMVisitor
from antlr_about.C2LLVMParser import C2LLVMParser
import llvmlite.ir as ir
from generator.types import LLVMTypes
from generator.util import parse_escape

class LLVMGenerator(C2LLVMVisitor):
    def __init__(self):
        self.module = ir.Module(name = 'C2LLVM')  #创建一个空模型
        self.local_vars = {}
        self.structs = {}
        #key为struct名的LLVM值，value为index字典
        #index字典的key为变量名的python字符串，value为对应偏移量的LLVM值
        self.struct_entry_types = {}
        # key为struct名的LLVM值，value为size字典
        # index字典的key为变量名的python字符串，value为对应的type的LLVM值
        self.struct_sizes = {}
        #key为struct名的LLVM值，value为结构体大小的LLVM值
        self.continue_block = None
        self.break_block = None
        self.emit_printf()
        self.chooseElse = 0
        self.Blocks = []
        self.depth = -1
        self._inside_struct_ = 0
        self._current_struct_ = None
        self._current_struct_size_ = LLVMTypes.int(0)

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

    def visitStart(self, ctx:C2LLVMParser.StartContext):
        for child in ctx.children:
            self.visit(child) 

    def visitCodeBlock(self, ctx: C2LLVMParser.CodeBlockContext):
        child = ctx.children[0]
        if self.match_rule(child, C2LLVMParser.RULE_include):
            pass #TODO头文件
        elif self.match_rule(child, C2LLVMParser.RULE_structPack):
            pass #TODO结构体定义
        elif self.match_rule(child, C2LLVMParser.RULE_function):
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
        self.builder = ir.IRBuilder(llvm_function.append_basic_block(name=func_name))

        self.local_vars[func_name] = llvm_function

        for arg_name, llvm_arg in zip(args_name, llvm_function.args):
            self.local_vars[arg_name] = llvm_arg

        self.continue_block = None
        self.break_block = None
        self.Blocks.append(self.builder.block)
        self.depth = self.depth+1
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
            return LLVMTypes.get_pointer_type(self.visit(pt)) 
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
        if ctx.varType():
            return LLVMTypes.str2type[ctx.varType().getText()]
        else:
            return LLVMTypes.char #结构体直接用单字节指针，方便index，需要读取某个数据时再作类型转换
        return LLVMTypes.char

    def visitPackcontent(self, ctx: C2LLVMParser.PackcontentContext):
        """
        packcontent: (stat | block | ) | ('{' content '}');
        """
        if self.chooseElse == 1:
            if self.builder.block not in self.Blocks:
                self.Blocks.append(self.builder.block)
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

    def visitDeclareStat(self, ctx: C2LLVMParser.DeclareStatContext):
        """
        declareStat: (usualType StrVar |  varType array) ';';
        """
        if ctx.children[0].getText() == "struct": #声明结构体对象
            struct_type = self.visit(ctx.children[1])
            struct_obj = ctx.children[2].getText()
            varp = self.builder.alloca(LLVMTypes.char, self.struct_sizes[struct_type])
            self.local_vars[struct_obj] = varp
        elif not self._inside_struct_:
            if len(ctx.children) == 3: #正常情况
                if self.match_rule(ctx.children[1], C2LLVMParser.RULE_array): #声明数组
                    vtype = LLVMTypes.str2type[ctx.varType().getText()]
                    var, size = self.visit(ctx.array())
                    if size == None:
                        print("declare need size")
                    varp = LLVMTypes.get_array_type(vtype,size.constant)
                    varp = self.builder.alloca(varp,size)
                    self.local_vars[var] = varp
                else: #声明单个变量
                    varType = self.visit(ctx.usualType())
                    var = ctx.StrVar().getText()
                    # 申请栈空间，并返回对应的指针
                    varp = self.builder.alloca(varType)
                    self.local_vars[var] = varp
            else:
                pass
        else:
            if len(ctx.children) == 3:  # 正常情况
                if self.match_rule(ctx.children[1], C2LLVMParser.RULE_array): #声明数组
                    vtype = LLVMTypes.str2type[ctx.varType().getText()]
                    var, size = self.visit(ctx.array())
                    if size == None:
                        print("declare need size")
                    self.structs[self._current_struct_][var] = self._current_struct_size_
                    current_variable_size = LLVMTypes.int(0)
                    if(vtype == LLVMTypes.str2type["int"]):
                        current_variable_size = LLVMTypes.int(4)
                    elif (vtype == LLVMTypes.str2type["char"]):
                        current_variable_size = LLVMTypes.int(1)
                    current_variable_size = self.builder.mul(current_variable_size, size)
                    self.struct_entry_types[self._current_struct_][var] = vtype#???
                    self._current_struct_size_ = self.builder.add(self._current_struct_size_, current_variable_size)
                else:  #声明单个变量
                    vtype = self.visit(ctx.usualType())
                    var = ctx.StrVar().getText()
                    self.structs[self._current_struct_][var] = self._current_struct_size_
                    current_variable_size = LLVMTypes.int(0)
                    if (vtype == LLVMTypes.str2type["int"]):
                        current_variable_size = LLVMTypes.int(4)
                    elif (vtype == LLVMTypes.str2type["char"]):
                        current_variable_size = LLVMTypes.int(1)
                    self.struct_entry_types[self._current_struct_][var] = vtype
                    self._current_struct_size_ = self.builder.add(self._current_struct_size_, current_variable_size)
            else:
                pass

    def visitAssignStat(self, ctx: C2LLVMParser.AssignStatContext):
        """
        assignStat: (usualType StrVar | StrVar | arrayValue | expr | varType array) '=' expr ';';
        """
        if len(ctx.children) == 5: #usualType StrVar = expr ;的情况
            if ctx.usualType(): #单个变量的情况
                varType = self.visit(ctx.usualType())
                var = ctx.StrVar().getText()
                val = self.visit(ctx.expr()[0])
                if isinstance(val.type,ir.PointerType):
                    val = self.builder.load(val)
                converted_rhs = LLVMTypes.cast_type(self.builder, varType, val)  #将val转换为varType类型
                #申请栈空间，并返回对应的指针
                varp = self.builder.alloca(varType);
                #将值存储到指定的位置
                self.builder.store(converted_rhs, varp)
                self.local_vars[var] = varp
            else: #数组的情况
                vtype = LLVMTypes.str2type[ctx.varType().getText()]
                var, size = self.visit(ctx.children[1])
                val = self.visit(ctx.children[3])
                #TODO （可选做）检查赋值表达式跟数组类型一致
                varp = LLVMTypes.get_array_type(vtype,size.constant)
                varp = self.builder.alloca(varp,size)
                # 将值存储到指定的位置
                #TODO 考虑初始值长度比数组大
                for i in range(val.type.count):  #TODO 这里只考虑了给char asd[100] = "1234"的情况即字符数组和字符串
                    singleval = val.constant[i]
                    singleval = LLVMTypes.char(singleval)
                    singleval = LLVMTypes.cast_type(self.builder, vtype, singleval)
                    addr = self.builder.gep(varp,[LLVMTypes.int(i),LLVMTypes.int(i)])
                    self.builder.store(singleval, addr)
                self.local_vars[var] = varp
        elif len(ctx.children) == 4: #(expr|strvar|arrayvalue) = expr ;的情况
            if(ctx.StrVar()):
                var = ctx.children[0].getText()
                varp = self.local_vars[var]
                varType = varp.type.pointee
                valp = self.visit(ctx.children[2])
                if isinstance(valp.type,ir.PointerType):
                    val = self.builder.load(valp)
                else:
                    val = valp
                converted_val = LLVMTypes.cast_type(self.builder, varType, val)
                self.builder.store(converted_val, varp)
                #self.builder.store(LLVMTypes.int(1),valp)
            elif(ctx.arrayValue()):
                valp = self.visit(ctx.arrayValue())
                val = self.visit(ctx.expr()[0])
                if isinstance(val.type,ir.PointerType):
                    val = self.builder.load(val)
                varType = valp.type.pointee
                converted_val = LLVMTypes.cast_type(self.builder, varType, val)
                self.builder.store(converted_val, valp)
            else : #TODO expr = expr;情况
                pass
        else:
            pass

    def visitBreakStat(self, ctx:C2LLVMParser.BreakStatContext):
        self.builder.branch(self.break_block)

    def visitReturnStat(self, ctx:C2LLVMParser.ReturnStatContext):
        """
         'return' expr ';'
        """
        ret_val = self.visit(ctx.expr())
        if isinstance(ret_val.type,ir.PointerType):
            ret_val = self.builder.load(ret_val)
        converted_val = LLVMTypes.cast_type(
            self.builder, target_type=self.builder.function.type.pointee.return_type, value=ret_val)
        print(self.module)
        self.builder.ret(converted_val)

    def visitContinueStat(self, ctx:C2LLVMParser.ContinueStatContext):
        self.builder.branch(self.continue_block)

    def visitFreeStat(self, ctx: C2LLVMParser.FreeStatContext):
        pass

    def visitPrintfStat(self, ctx: C2LLVMParser.PrintfStatContext):
        """
        printfStat: 'printf' '(' STRING (',' expr)* ')' ';';
        """
        text = ctx.STRING().getText()
        str_len = len(parse_escape(text[1:-1]))
        msg = LLVMTypes.get_const_from_str(ir.ArrayType(LLVMTypes.char, str_len+1), const_value=text)
        variable = ir.GlobalVariable(self.builder.module, ir.ArrayType(LLVMTypes.char, str_len+1), name='msg')
        variable.initializer = msg
        zero = ir.Constant(ir.types.IntType(32), 0)
        msg = variable.gep((zero, zero))
        self.builder.call(self.local_vars["printf"],(msg,))

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
        if loop_block not in self.Blocks:
            self.Blocks.append(loop_block)
        
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

        self.depth = self.depth +1
        self.builder.position_at_start(loop_block)  #这里是写loopblock的内容
        self.visit(ctx.packcontent())
        self.builder.branch(cond_block)

        # 恢复原先的continue_block和break_block
        self.Blocks.pop()
        self.depth = self.depth -1
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
        self.chooseElse = 1
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
        self.chooseElse = 0
        self.Blocks.pop()


    def visitElseBlock(self, ctx: C2LLVMParser.ElseBlockContext):
        """
        elseBlock: 'else' packcontent;
        """
        self.visit(ctx.packcontent())


    def visitExpr(self, ctx:C2LLVMParser.ExprContext):
        """
        expr: (StrVar | number | arrayValue | funcExpr | CHAR | STRING) |
        (StrVar | number | arrayValue | funcExpr | CHAR) operator expr ;
        operator: '+' | '-' | '*' | '/' | '->';
        :param ctx:
        :return: 表达式的值
        """
        retval = LLVMTypes.get_const_from_str(LLVMTypes.int, '-1')
        if ctx.StrVar():
            text = ctx.StrVar().getText()
            if text in self.local_vars:
                varp = self.local_vars[text]
                retval = self.builder.load(varp)
            else:
                # TODO raise exception
                print(self.module.functions)
                print("Undefined identifier: '%s'\n" % text)
        elif ctx.number():
            text = ctx.number().getText()
            retval = LLVMTypes.get_const_from_str(LLVMTypes.int, text)
        elif ctx.arrayValue():  #数组情况
            retval = self.visit(ctx.arrayValue())
        elif ctx.funcExpr():  #函数情况，注意有强制类型转换
            pass
        elif ctx.CHAR():
            text = ctx.CHAR().getText()
            retval = LLVMTypes.get_const_from_str(LLVMTypes.char, text)
        elif ctx.STRING():
            text = ctx.STRING().getText()
            str_len = len(parse_escape(text[1:-1]))
            retval = LLVMTypes.get_const_from_str(ir.ArrayType(LLVMTypes.char, str_len+1), const_value=text)
        if len(ctx.children) == 3:  #需要判断运算符号以及运算对象是常量还是变量
            lval = self.visit(ctx.expr()) #seems actually it's lval
            op = ctx.operator().getText()
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
            elif op == '==':
                retval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=retval)
                lval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=lval)  # 将两个值都转换为int
                retval = self.builder.icmp_signed("==", lval, retval)  # retval是LLVM的bool值
            elif op == '!=':
                retval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=retval)
                lval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=lval)  # 将两个值都转换为int
                retval = self.builder.icmp_signed("!=", lval, retval)
            elif op == '->':
                struct_name = self.structs[lval]
                index = struct_name[retval.getText()]
                retval = self.builder.gep(lval, [index, index])
            return retval

        else:
            return retval

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
                #if logic == '==':
                #    boolRetVal = self.builder.icmp_signed("==", lval, rval)
                #    return boolRetVal
                #elif logic == '!=':
                #    boolRetVal = self.builder.icmp_signed("!=", lval, rval)
                #    return boolRetVal
                boolRetVal = self.builder.icmp_signed(logic, lval, rval)
                return boolRetVal

        # TODO补充长度为5时情况

    def visitArrayValue(self, ctx:C2LLVMParser.ArrayValueContext):
        """
        arrayValue: StrVar '[' expr ']';
        """
        var = ctx.StrVar().getText()
        varp = self.local_vars[var]
        index = self.visit(ctx.expr())
        index = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=index)
        valp = self.builder.gep(varp, [index, index])
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

    #def visitPrintfStat(self, ctx:C2LLVMParser.PrintfStatContext):
    #    #todo
    #    #用printf打印变量值
    #    #目前采用直接print的方法测试，因此在编译时就会输出
    #    #最后会改成存到test.ll中
    #    format = ctx.children[2].getText()
    #    format = format[1:-1]
    #    var_index = 0
    #    flag = 0
    #    self.builder
    #    for c in format:
    #        if c == '%':
    #            if flag == 1:
    #                print('%')
    #            flag = 1
    #        elif flag == 1:
    #            val = self.visit(ctx.children[4+2*var_index])
    #            if c == 's' or c == 'c':
    #                print(val)
    #            elif c == 'd':
    #                print(val)
    #            flag = 0
    #            var_index = var_index + 1
    #        else:
    #            print(c)

    def visitScanfStat(self, ctx:C2LLVMParser.ScanfStatContext):
        pass

    def visitStructPack(self, ctx:C2LLVMParser.StructPackContext):
        self._inside_struct_ = 1
        self._current_struct_ = ctx.children[1]
        self.structs[ctx.children[1]] = {}
        self.visitContent(ctx)
        self._inside_struct_ = 0
        self.struct_sizes[ctx.children[1]] = self._current_struct_size_
        self._current_struct_size_ = LLVMTypes.int(0)

    def visitMallocFunc(self, ctx:C2LLVMParser.MallocFuncContext):
        size = self.visit(ctx.children[2])
        varp = self.builder.alloca(LLVMTypes.char, size)
        return varp

    def save(self, filename):
        """保存到文件"""
        with open(filename, "w") as f:
            f.write(repr(self.module))

