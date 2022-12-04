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
        self.func_params = {}
        self.continue_block = None
        self.break_block = None
        self.emit_printf()
        self.emit_scanf()
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
        self.builder = ir.IRBuilder(llvm_function.append_basic_block(name=func_name))#

        self.local_vars[func_name] = llvm_function

        for arg_name, llvm_arg in zip(args_name, llvm_function.args):
            varp = self.builder.alloca(llvm_arg.type)
            self.builder.store(llvm_arg,varp)
            self.local_vars[arg_name] = varp

        for arg_name, llvm_arg in zip(args_name, llvm_function.args):
            # varp = self.builder.alloca(llvm_arg.type)
            # self.builder.store(llvm_arg,varp)
            self.func_params[arg_name] = llvm_arg

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
        # self.builder.store()
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
            pass #TODO sssssssssssssssss结构体
        pass

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
        if len(ctx.children) == 3: #正常情况
            if self.match_rule(ctx.children[1], C2LLVMParser.RULE_array): #TODO 声明数组
                vtype = LLVMTypes.str2type[ctx.varType().getText()]
                var, size = self.visit(ctx.array())
                if size == None:
                    print("declare need size")
                varp = LLVMTypes.get_array_type(vtype,size.constant)
                varp = self.builder.alloca(varp,size)
                self.local_vars[var] = varp
            else: #TODO 声明单个变量
                varType = self.visit(ctx.usualType())
                var = ctx.StrVar().getText()
                # 申请栈空间，并返回对应的指针
                varp = self.builder.alloca(varType);
                self.local_vars[var] = varp
        else:
            pass

    def visitAssignStat(self, ctx: C2LLVMParser.AssignStatContext):
        """
        assignStat: (usualType StrVar | StrVar | arrayValue | expr | varType array) '=' expr ';';
        """
        if len(ctx.children) == 5: #usualType StrVar = expr ;的情况
            if ctx.usualType(): #单个变量的情况
                # 或许可以判断左右type是否相等
                varType = self.visit(ctx.usualType())
                var = ctx.StrVar().getText()
                val = self.visit(ctx.expr()[0])
                # if isinstance(val.type,ir.PointerType):
                #     val = self.builder.load(val)
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
                    addr = self.builder.gep(varp,[LLVMTypes.int(0),LLVMTypes.int(i)])
                    self.builder.store(singleval, addr)
                # self.builder.bitcast(varp,LLVMTypes.get_pointer_type(vtype))   
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
                varp = self.visit(ctx.arrayValue())
                val = self.visit(ctx.expr()[0])
                if isinstance(val.type,ir.PointerType):
                    val = self.builder.load(val)
                varType = varp.type.pointee
                converted_val = LLVMTypes.cast_type(self.builder, varType, val)
                self.builder.store(converted_val,varp)
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
        self.builder.ret(converted_val)
        # print(self.module)

    def visitContinueStat(self, ctx:C2LLVMParser.ContinueStatContext):
        self.builder.branch(self.continue_block)

    def visitFreeStat(self, ctx: C2LLVMParser.FreeStatContext):
        pass  #TODO

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
            arg = self.visit(i)
            if isinstance(arg.type,ir.ArrayType):
                arg = self.local_vars[i.getText()]
            elif isinstance(arg.type,ir.PointerType):
                arg = self.builder.load(arg)
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
	        | '&' StrVar;
        operator: '+' | '-' | '*' | '/' | '->';
        :param ctx:
        :return: 表达式的值
        """
        retval = LLVMTypes.get_const_from_str(LLVMTypes.int, '-1')
        if ctx.StrVar():
            text = ctx.StrVar().getText()
            if text in self.local_vars:
                varp = self.local_vars[text]
                if isinstance(varp.type, ir.PointerType):
                    # 字符指针得返回字符指针
                    retval = self.builder.load(varp)
                else:
                    retval = varp
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
            if len(ctx.children) == 2:
                pass # TODO pre func
            else: # func
                retval = self.visit(ctx.children[0])
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
            elif op == '==':  # TODO 其他运算符
                retval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=retval)
                lval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=lval)  # 将两个值都转换为int
                retval = self.builder.icmp_signed("==", lval, retval)  # retval是LLVM的bool值
            elif op == '!=':
                retval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=retval)
                lval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=lval)  # 将两个值都转换为int
                retval = self.builder.icmp_signed("!=", lval, retval)
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
        for arg, callee_arg in zip(actualParams, function_var.args):
            if isinstance(arg.type,ir.ArrayType):
                arg = LLVMTypes.cast_type(self.builder, value=arg, target_type=callee_arg.type)
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
                #if logic == '==':
                #    boolRetVal = self.builder.icmp_signed("==", lval, rval)
                #    return boolRetVal
                #elif logic == '!=':
                #    boolRetVal = self.builder.icmp_signed("!=", lval, rval)
                #    return boolRetVal
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
        varp = self.local_vars[var] # varp指向var的地址，var的值是str的地址
        index = self.visit(ctx.expr())
        # if isinstance(index.type,ir.PointerType):
        #     index = self.builder.load(index)
        index = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=index)
        if isinstance(varp.type.pointee, ir.ArrayType):
            valp = self.builder.gep(varp, [LLVMTypes.int(0),index])
        else:
            valp = self.builder.load(varp)
            if isinstance(valp.type, ir.PointerType):
                valp = self.builder.gep(valp, [index])
        return valp #返回值是str的地址+expr


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


    def save(self, filename):
        """保存到文件"""
        with open(filename, "w") as f:
            f.write(repr(self.module))

