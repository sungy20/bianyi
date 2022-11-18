from pickle import NONE
from antlr_about.C2LLVMVisitor import C2LLVMVisitor
from antlr_about.C2LLVMParser import C2LLVMParser
import llvmlite.ir as ir
from generator.types import LLVMTypes
from generator.util import parse_escape


class LLVMGenerator(C2LLVMVisitor):
    def __init__(self):
        self.module = ir.Module(name = 'C2LLVM')  #创建一个空模型
        self.local_vars = {}
        self.continue_block = None
        self.break_block = None

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


    def visitStart(self, ctx:C2LLVMParser.StartContext):
        for child in ctx.children:
            self.visit(child) #TODO头文件,结构体定义
            if self.match_rule(child, C2LLVMParser.RULE_include):
                pass #TODO头文件
            elif self.match_rule(child, C2LLVMParser.RULE_structPack):
                pass #TODO结构体定义
            elif self.match_rule(child, C2LLVMParser.RULE_function):
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
        functionDefinition
            :   declarationSpecifiers declarator compoundStatement
        function : varType StrVar '(' params ')' packcontent;
        eg: void hi(char *who, int *i);
        """
        ret_type = LLVMTypes.str2type[ctx.varType().getText()]  #函数返回值的类型
        func_name = ctx.StrVar().getText()
        args_type, args_name = self.visit(ctx.params())
        function_type = ir.FunctionType(ret_type,(args_type))
        #func_name, function_type, arg_names = self.visit(ctx.declarator())
        llvm_function = ir.Function(self.module, function_type, name=func_name)  #创建llvm函数
        self.builder = ir.IRBuilder(llvm_function.append_basic_block(name="entry"))

        self.local_vars[func_name] = llvm_function

        for arg_name, llvm_arg in zip(args_name, llvm_function.args):
            self.local_vars[arg_name] = llvm_arg

        self.continue_block = None
        self.break_block = None

        self.visit(ctx.packcontent())

    def visitParams(self, ctx:C2LLVMParser.ParamsContext):
        """
        params : param | param ',' params |;
        :param ctx:
        :return: 返回变量名字列表arg_names和变量类型列表arg_types
        """
        if ctx.children is None:
            arg_names = []
            arg_types = []
            return arg_types, arg_names
        else:
            arg_types, arg_names = self.visit(ctx.params())
        arg_type, arg_name = self.visit(ctx.param())
        arg_names.append(arg_name)
        arg_types.append(arg_type)
        return arg_types, arg_names

    def visitParam(self, ctx:C2LLVMParser.ParamContext):
        """
        param: usualType StrVar;
        parameterDeclaration
            :   declarationSpecifiers declarator
            ;
        :param ctx:
        :return: 声明变量的名字和类型
        """
        #base_type = self.visit(ctx.usualType())
        #ctx.StrVar.base_type = base_type  # 将声明变量的基础类型向下传递到declarator子树中
        arg_type = self.visit(ctx.usualType())
        arg_name = ctx.StrVar().getText()
        return arg_type, arg_name

    def visitUsualType(self, ctx:C2LLVMParser.UsualTypeContext):
        """
        usualType: varType | pointerType ;
        pointerType: varType '*' | 'struct' StrVar '*' | StrVar '*';
        varType: varType: 'int' | 'char' | 'struct';
        typeSpecifier
            :   'void'
            |   'char'
            |   'short'
            |   'int'
            |   'long'
            |   'float'
            |   'double'
            |   typeSpecifier pointer
        :param ctx:
        :return: 对应的LLVM类型
        """
        if self.match_rule(ctx.children[0], C2LLVMParser.RULE_pointerType):
            # 指针类型
            pt = ctx.pointerType()
            return LLVMTypes.get_pointer_type(self.visit(ctx.pointerType()))  #TODO: sssssssssssss
        elif self.match_texts(ctx, LLVMTypes.str2type.keys()):
            # 'int' | 'char' | 'struct'
            return LLVMTypes.str2type[ctx.getText()]   #TODO: sssssssssssss结构体
        else:
            print("Error: unknown type ", ctx.getText())
            exit(-1)
    
    def visitPackcontent(self, ctx: C2LLVMParser.PackcontentContext):
        self.visit(ctx.content())

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
        pass

    def visitAssignStat(self, ctx: C2LLVMParser.AssignStatContext):
        """
        assignStat: (usualType StrVar | StrVar | arrayValue | expr) '=' expr ';';
        """
        if len(ctx.children) == 5: #usualType StrVar = expr ;的情况
            varType = self.visit(ctx.usualType())
            var = ctx.StrVar().getText()
            val = self.visit(ctx.expr()[0])
            converted_rhs = LLVMTypes.cast_type(self.builder, varType, val)  #将val转换为varType类型
            #申请栈空间，并返回对应的指针
            varp = self.builder.alloca(LLVMTypes.int);
            #将值存储到指定的位置
            self.builder.store(converted_rhs, varp)
            self.local_vars[var] = varp
        else:  #TODO
            pass

    def visitBreakStat(self, ctx:C2LLVMParser.BreakStatContext):
        self.builder.branch(self.break_block)

    def visitReturnStat(self, ctx:C2LLVMParser.ReturnStatContext):
        """
         'return' expr ';'
        """
        ret_val = self.visit(ctx.expr())
        converted_val = LLVMTypes.cast_type(
            self.builder, target_type=self.builder.function.type.pointee.return_type, value=ret_val)
        self.builder.ret(converted_val)

    def visitContinueStat(self, ctx:C2LLVMParser.ContinueStatContext):
        self.builder.branch(self.continue_block)

    def visitFreeStat(self, ctx: C2LLVMParser.FreeStatContext):
        pass  #TODO

    def visitExpr(self, ctx:C2LLVMParser.ExprContext):
        """
        expr: (StrVar | INT | arrayValue | funcExpr | CHAR) |
        (StrVar | INT | arrayValue | funcExpr | CHAR) operator expr ;
        assignmentExpression
            :   conditionalExpression
            |   unaryExpression assignmentOperator assignmentExpression
        :param ctx:
        :return: 表达式的值
        """
        retval = LLVMTypes.get_const_from_str(LLVMTypes.int, '-1')
        text = ctx.getText()
        if ctx.StrVar():
            if text in self.local_vars:
                var = self.local_vars[text]
                retval = var
            else:
                # TODO raise exception
                print(self.module.functions)
                print("Undefined identifier: '%s'\n" % text)
        elif ctx.INT():
            retval = LLVMTypes.get_const_from_str(LLVMTypes.int, text)
        elif ctx.arrayValue():  #数组情况
            pass
        elif ctx.funcExpr():  #函数情况，注意有强制类型转换
            pass
        elif ctx.CHAR():
            retval = LLVMTypes.get_const_from_str(ir.ArrayType, text)
        if len(ctx.children) == 3:  #需要判断运算符号以及运算对象是常量还是变量
            rval = self.visit(ctx.expr())
            op = ctx.operator().getText()
            if op == '+':
                retval = retval + rval
        else:
            return retval

    def save(self, filename):
        """保存到文件"""
        with open(filename, "w") as f:
            f.write(repr(self.module))

