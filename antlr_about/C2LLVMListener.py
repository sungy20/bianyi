# Generated from C2LLVM.g4 by ANTLR 4.9.2
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .C2LLVMParser import C2LLVMParser
else:
    from C2LLVMParser import C2LLVMParser

# This class defines a complete listener for a parse tree produced by C2LLVMParser.
class C2LLVMListener(ParseTreeListener):

    # Enter a parse tree produced by C2LLVMParser#start.
    def enterStart(self, ctx:C2LLVMParser.StartContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#start.
    def exitStart(self, ctx:C2LLVMParser.StartContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#codeBlock.
    def enterCodeBlock(self, ctx:C2LLVMParser.CodeBlockContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#codeBlock.
    def exitCodeBlock(self, ctx:C2LLVMParser.CodeBlockContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#include.
    def enterInclude(self, ctx:C2LLVMParser.IncludeContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#include.
    def exitInclude(self, ctx:C2LLVMParser.IncludeContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#structPack.
    def enterStructPack(self, ctx:C2LLVMParser.StructPackContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#structPack.
    def exitStructPack(self, ctx:C2LLVMParser.StructPackContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#function.
    def enterFunction(self, ctx:C2LLVMParser.FunctionContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#function.
    def exitFunction(self, ctx:C2LLVMParser.FunctionContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#params.
    def enterParams(self, ctx:C2LLVMParser.ParamsContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#params.
    def exitParams(self, ctx:C2LLVMParser.ParamsContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#param.
    def enterParam(self, ctx:C2LLVMParser.ParamContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#param.
    def exitParam(self, ctx:C2LLVMParser.ParamContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#usualType.
    def enterUsualType(self, ctx:C2LLVMParser.UsualTypeContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#usualType.
    def exitUsualType(self, ctx:C2LLVMParser.UsualTypeContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#pointerType.
    def enterPointerType(self, ctx:C2LLVMParser.PointerTypeContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#pointerType.
    def exitPointerType(self, ctx:C2LLVMParser.PointerTypeContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#packcontent.
    def enterPackcontent(self, ctx:C2LLVMParser.PackcontentContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#packcontent.
    def exitPackcontent(self, ctx:C2LLVMParser.PackcontentContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#content.
    def enterContent(self, ctx:C2LLVMParser.ContentContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#content.
    def exitContent(self, ctx:C2LLVMParser.ContentContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#stat.
    def enterStat(self, ctx:C2LLVMParser.StatContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#stat.
    def exitStat(self, ctx:C2LLVMParser.StatContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#declareStat.
    def enterDeclareStat(self, ctx:C2LLVMParser.DeclareStatContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#declareStat.
    def exitDeclareStat(self, ctx:C2LLVMParser.DeclareStatContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#assignStat.
    def enterAssignStat(self, ctx:C2LLVMParser.AssignStatContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#assignStat.
    def exitAssignStat(self, ctx:C2LLVMParser.AssignStatContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#breakStat.
    def enterBreakStat(self, ctx:C2LLVMParser.BreakStatContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#breakStat.
    def exitBreakStat(self, ctx:C2LLVMParser.BreakStatContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#returnStat.
    def enterReturnStat(self, ctx:C2LLVMParser.ReturnStatContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#returnStat.
    def exitReturnStat(self, ctx:C2LLVMParser.ReturnStatContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#freeStat.
    def enterFreeStat(self, ctx:C2LLVMParser.FreeStatContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#freeStat.
    def exitFreeStat(self, ctx:C2LLVMParser.FreeStatContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#continueStat.
    def enterContinueStat(self, ctx:C2LLVMParser.ContinueStatContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#continueStat.
    def exitContinueStat(self, ctx:C2LLVMParser.ContinueStatContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#scanfStat.
    def enterScanfStat(self, ctx:C2LLVMParser.ScanfStatContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#scanfStat.
    def exitScanfStat(self, ctx:C2LLVMParser.ScanfStatContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#printfStat.
    def enterPrintfStat(self, ctx:C2LLVMParser.PrintfStatContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#printfStat.
    def exitPrintfStat(self, ctx:C2LLVMParser.PrintfStatContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#expr.
    def enterExpr(self, ctx:C2LLVMParser.ExprContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#expr.
    def exitExpr(self, ctx:C2LLVMParser.ExprContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#arrayValue.
    def enterArrayValue(self, ctx:C2LLVMParser.ArrayValueContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#arrayValue.
    def exitArrayValue(self, ctx:C2LLVMParser.ArrayValueContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#funcExpr.
    def enterFuncExpr(self, ctx:C2LLVMParser.FuncExprContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#funcExpr.
    def exitFuncExpr(self, ctx:C2LLVMParser.FuncExprContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#pre.
    def enterPre(self, ctx:C2LLVMParser.PreContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#pre.
    def exitPre(self, ctx:C2LLVMParser.PreContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#func.
    def enterFunc(self, ctx:C2LLVMParser.FuncContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#func.
    def exitFunc(self, ctx:C2LLVMParser.FuncContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#customFunc.
    def enterCustomFunc(self, ctx:C2LLVMParser.CustomFuncContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#customFunc.
    def exitCustomFunc(self, ctx:C2LLVMParser.CustomFuncContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#actualParams.
    def enterActualParams(self, ctx:C2LLVMParser.ActualParamsContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#actualParams.
    def exitActualParams(self, ctx:C2LLVMParser.ActualParamsContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#actualParam.
    def enterActualParam(self, ctx:C2LLVMParser.ActualParamContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#actualParam.
    def exitActualParam(self, ctx:C2LLVMParser.ActualParamContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#mallocFunc.
    def enterMallocFunc(self, ctx:C2LLVMParser.MallocFuncContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#mallocFunc.
    def exitMallocFunc(self, ctx:C2LLVMParser.MallocFuncContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#block.
    def enterBlock(self, ctx:C2LLVMParser.BlockContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#block.
    def exitBlock(self, ctx:C2LLVMParser.BlockContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#ifBlock.
    def enterIfBlock(self, ctx:C2LLVMParser.IfBlockContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#ifBlock.
    def exitIfBlock(self, ctx:C2LLVMParser.IfBlockContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#whileBlock.
    def enterWhileBlock(self, ctx:C2LLVMParser.WhileBlockContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#whileBlock.
    def exitWhileBlock(self, ctx:C2LLVMParser.WhileBlockContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#elseBlock.
    def enterElseBlock(self, ctx:C2LLVMParser.ElseBlockContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#elseBlock.
    def exitElseBlock(self, ctx:C2LLVMParser.ElseBlockContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#elseifBlock.
    def enterElseifBlock(self, ctx:C2LLVMParser.ElseifBlockContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#elseifBlock.
    def exitElseifBlock(self, ctx:C2LLVMParser.ElseifBlockContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#condition.
    def enterCondition(self, ctx:C2LLVMParser.ConditionContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#condition.
    def exitCondition(self, ctx:C2LLVMParser.ConditionContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#logic.
    def enterLogic(self, ctx:C2LLVMParser.LogicContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#logic.
    def exitLogic(self, ctx:C2LLVMParser.LogicContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#varType.
    def enterVarType(self, ctx:C2LLVMParser.VarTypeContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#varType.
    def exitVarType(self, ctx:C2LLVMParser.VarTypeContext):
        pass


    # Enter a parse tree produced by C2LLVMParser#operator.
    def enterOperator(self, ctx:C2LLVMParser.OperatorContext):
        pass

    # Exit a parse tree produced by C2LLVMParser#operator.
    def exitOperator(self, ctx:C2LLVMParser.OperatorContext):
        pass



del C2LLVMParser