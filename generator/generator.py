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
        self.emit_printf()

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
            pass #TODO sssssssssssssssss结构体
        pass

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
        if len(ctx.children) == 3: #正常情况
            if False: #TODO 声明数组
                pass
            else: #TODO 声明单个变量
                varType = self.visit(ctx.usualType())
                var = ctx.StrVar().getText()
                # 申请栈空间，并返回对应的指针
                varp = self.builder.alloca(varType);
                # 将值存储到指定的位置
                self.local_vars[var] = varp
        else:
            pass

    def visitAssignStat(self, ctx: C2LLVMParser.AssignStatContext):
        """
        assignStat: (usualType StrVar | StrVar | arrayValue | expr) '=' expr ';';
        """
        if len(ctx.children) == 5: #usualType StrVar = expr ;的情况
            if ctx.usualType(): #单个变量的情况
                varType = self.visit(ctx.usualType())
                var = ctx.StrVar().getText()
                val = self.visit(ctx.expr()[0])
                converted_rhs = LLVMTypes.cast_type(self.builder, varType, val)  #将val转换为varType类型
                #申请栈空间，并返回对应的指针
                varp = self.builder.alloca(varType);
                #将值存储到指定的位置
                self.builder.store(converted_rhs, varp)
                self.local_vars[var] = varp
            else: #数组的情况
                var, size = self.visit(ctx.children[1])
                val = self.visit(ctx.children[3])
                #TODO （可选做）检查赋值表达式跟数组类型一致
                #varTypeText = ctx.children[0].children[0].getText()
                #varType = LLVMTypes.str2type[varTypeText]#单个元素类型
                varp = self.builder.alloca(val.type);
                # 将值存储到指定的位置
                self.builder.store(val, varp)
                self.local_vars[var] = varp
        elif len(ctx.children) == 4: #expr = expr ;的情况
            var = ctx.children[0].getText()
            varp = self.local_vars[var]
            varType = varp.type.pointee
            val = self.visit(ctx.children[2])
            converted_val = LLVMTypes.cast_type(self.builder, varType, val)
            self.builder.store(converted_val, varp)
        else:
            pass
        return True

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

    def visitBlock(self, ctx: C2LLVMParser.BlockContext):
        """
        block: whileBlock | ifBlock | elseBlock | elseifBlock;
        """
        self.visit(ctx.children[0]) #TODO补充所有block

    def visitWhileBlock(self, ctx:C2LLVMParser.WhileBlockContext):
        """
        whileBlock: 'while' '(' condition ')' packcontent;
        """
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
        ifBlock: 'if' '(' condition ')' packcontent;
        """
        cond = self.visit(ctx.condition())
        if cond:
            self.visit(ctx.packcontent())

    def visitCondition(self, ctx:C2LLVMParser.ConditionContext):
        """
        condition: expr | '(' expr ')' logic condition | expr logic condition | condition logic condition | '(' condition ')';
        return:LLVM的bool值
        """
        if len(ctx.children) == 1:
            val = self.visit(ctx.expr())
            return val
        elif len(ctx.children) == 3:  #TODO补充
            child = ctx.children[0]
            if self.match_rule(child, C2LLVMParser.RULE_expr):
                lval = self.visit(child)

        #TODO补充长度为5时情况

    def visitExpr(self, ctx:C2LLVMParser.ExprContext):
        """
        expr: (StrVar | INT | arrayValue | funcExpr | CHAR | STRING) |
        (StrVar | INT | arrayValue | funcExpr | CHAR) operator expr ;
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
        elif ctx.INT():
            text = ctx.INT().getText()
            retval = LLVMTypes.get_const_from_str(LLVMTypes.int, text)
        elif ctx.arrayValue():  #数组情况
            self.visit(ctx.arrayValue())
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
            rval = self.visit(ctx.expr())
            op = ctx.operator().getText()
            if op == '+':
                retval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=retval)
                rval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=rval)  #将两个值都转换为int
                retval = self.builder.add(retval, rval)   #两值相加
            elif op == '==':  #TODO 其他运算符
                retval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=retval)
                rval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=rval)  #将两个值都转换为int
                retval = self.builder.icmp_signed("==", retval, rval)   #retval是LLVM的bool值
            elif op == '!=':
                retval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=retval)
                rval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=rval)  #将两个值都转换为int
                retval = self.builder.icmp_signed("!=", retval, rval)
            elif op == '/':
                retval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=retval)
                rval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=rval)  #将两个值都转换为int
                retval = self.builder.sdiv(retval,rval)
            elif op == '*':
                retval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=retval)
                rval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=rval)  #将两个值都转换为int
                retval = self.builder.mul(retval,rval)
            elif op == '-':
                retval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=retval)
                rval = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=rval)  # 将两个值都转换为int
                retval = self.builder.sub(retval, rval)
            return retval

        else:
            return retval

    def visitArrayValue(self, ctx:C2LLVMParser.ArrayValueContext):
        """
        arrayValue: StrVar '[' expr ']';
        """
        var = ctx.StrVar().getText()
        varp = self.local_vars[var]
        index = self.visit(ctx.expr())
        index = LLVMTypes.cast_type(self.builder, target_type=LLVMTypes.int, value=index)
        valp = self.builder.gep(varp,[index])
        return valp

    def visitArray(self, ctx:C2LLVMParser.ArrayContext):
        if len(ctx.children) == 4:
            var = ctx.children[0].getText()
            size = int(ctx.children[2].getText())
            return var, size
        else:#TODO 不定长数组(也可以不做)，形如char i[]="hi"
            return None, None

    def save(self, filename):
        """保存到文件"""
        with open(filename, "w") as f:
            f.write(repr(self.module))

