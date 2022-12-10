﻿from pickle import NONE
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
        self.continue_block = None
        self.break_block = None
        self.emit_printf()
        self.emit_scanf()
        self.msg = {}
        self.str = ""

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
        self.str = self.str + '{'
        for child in ctx.children:
            self.visit(child) 
        self.str = self.str + '},'

    def visitCodeBlock(self, ctx: C2LLVMParser.CodeBlockContext):
        self.str = self.str + '"codeBlock":{'
        child = ctx.children[0]
        if self.match_rule(child, C2LLVMParser.RULE_include):
            pass #TODO头文件
        elif self.match_rule(child, C2LLVMParser.RULE_structPack):
            pass #TODO结构体定义
        elif self.match_rule(child, C2LLVMParser.RULE_function):
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
        self.str = self.str + '"funcName":' + '"' + ctx.StrVar().getText() + '",'
        self.str = self.str + '"params":['
        args_type, args_name = self.visit(ctx.params())
        self.str = self.str + '],'
        function_type = ir.FunctionType(ret_type,(args_type))
        llvm_function = ir.Function(self.module, function_type, name=func_name)  #创建llvm函数
        self.builder = ir.IRBuilder(llvm_function.append_basic_block(name=func_name))#

        self.local_vars[func_name] = llvm_function

        for arg_name, llvm_arg in zip(args_name, llvm_function.args):
            varp = self.builder.alloca(llvm_arg.type)
            self.builder.store(llvm_arg,varp)
            self.local_vars[arg_name] = varp

        self.continue_block = None
        self.break_block = None
        self.visit(ctx.packcontent())
        
        # TODO补充函数没有return的情况

        self.str = self.str + '},'

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
        self.str = self.str + '"StrVar": ' + ctx.StrVar().getText() + ','
        return arg_type, arg_name

    def visitUsualType(self, ctx:C2LLVMParser.UsualTypeContext):
        """
        usualType: varType | pointerType ;
        pointerType: varType '*' | 'struct' StrVar '*' | StrVar '*';
        varType: varType: 'int' | 'char' | 'struct';
        :param ctx:
        :return: 对应的LLVM类型
        """
        self.str = self.str + '"usualType":"'+ ctx.getText() +'",'
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
        self.str = self.str + '"pointerType":"'+ ctx.varType().getText() +'",'
        if ctx.varType():
            return LLVMTypes.str2type[ctx.varType().getText()]
        else:
            pass #TODO sssssssssssssssss结构体
        pass

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

    def visitDeclareStat(self, ctx: C2LLVMParser.DeclareStatContext):  #TODO
        """
        declareStat: (usualType StrVar |  varType array) ';';
        """
        self.str = self.str + '"declareStat":{'
        if len(ctx.children) == 3: #正常情况
            if self.match_rule(ctx.children[1], C2LLVMParser.RULE_array): #TODO 声明数组
                vtype = LLVMTypes.str2type[ctx.varType().getText()]
                self.str = self.str + '"varType":"' + ctx.varType().getText() + '",'
                var, size = self.visit(ctx.array())
                if size == None:
                    print("declare need size")
                varp = LLVMTypes.get_array_type(vtype,size.constant)
                varp = self.builder.alloca(varp,size)
                self.local_vars[var] = varp
            else: #TODO 声明单个变量
                varType = self.visit(ctx.usualType())

                var = ctx.StrVar().getText()
                self.str = self.str + '"StrVar":"' + ctx.StrVar().getText() + '",'
                # 申请栈空间，并返回对应的指针
                varp = self.builder.alloca(varType);
                self.local_vars[var] = varp
        else:
            pass
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
                if ctx.expr()[0].children[0].getText() == '&':
                    pass
                else:
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
                self.str = self.str + '"varType":"' + ctx.varType().getText() + '",'
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
                self.str = self.str + '"StrVar":"' + ctx.StrVar().getText() + '",'
                varp = self.local_vars[var]
                varType = varp.type.pointee
                valp = self.visit(ctx.children[2])
                if ctx.children[2].children[0].getText() == '&':
                    pass
                else:
                    if isinstance(valp.type,ir.PointerType):
                        valp = self.builder.load(valp)
                converted_val = LLVMTypes.cast_type(self.builder, varType, valp)
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
        self.str = self.str + '},'

    def visitBreakStat(self, ctx:C2LLVMParser.BreakStatContext):
        self.str = self.str + '"breakStat":"' + ctx.children[0].getText() + '",'
        self.builder.branch(self.break_block)

    def visitReturnStat(self, ctx:C2LLVMParser.ReturnStatContext):
        """
         'return' expr ';'
        """
        self.str = self.str + '"returnStat":{' 
        ret_val = self.visit(ctx.expr())
        if isinstance(ret_val.type,ir.PointerType):
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
        pass  #TODO

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
                    arg = self.local_vars[i.getText()]
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
                arg = self.local_vars[i.getText()]
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
            if text in self.local_vars:
                varp = self.local_vars[text]
                retval = varp
            else:
                # TODO raise exception
                print(self.module.functions)
                print("Undefined identifier: '%s'\n" % text)
        elif ctx.number():
            text = ctx.number().getText()
            self.str = self.str + '"number":"' + text + '",'
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
            self.str = self.str + '"CHAR":"' + text + '",'
            retval = LLVMTypes.get_const_from_str(LLVMTypes.char, text)
        elif ctx.STRING():
            text = ctx.STRING().getText()
            self.str = self.str + '"STRING":"' + text + '",'
            str_len = len(parse_escape(text[1:-1]))
            retval = LLVMTypes.get_const_from_str(ir.ArrayType(LLVMTypes.char, str_len+1), const_value=text)
        if len(ctx.children) == 3:  #需要判断运算符号以及运算对象是常量还是变量
            lval = self.visit(ctx.expr()) 
            if isinstance(lval.type,ir.PointerType):
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
            self.str = self.str + '},'
            return retval
        elif len(ctx.children) == 2:
            if ctx.StrVar():
                text = ctx.StrVar().getText()
                self.str = self.str + '"StrVar":"' + text + '",'
                return_val = self.local_vars[text]
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
                    boolRetVal = self.builder.and_(lval, rval)
                elif logic == "||":
                    boolRetVal = self.builder.or_(lval, rval)
                else:
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

    def saveJSON(self, filename):
        """保存到文件"""
        with open(filename, "w") as f:
            f.write(self.str)

    def save(self, filename):
        """保存到文件"""
        with open(filename, "w") as f:
            f.write(repr(self.module))

