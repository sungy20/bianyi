# Generated from C2LLVM.g4 by ANTLR 4.9.2
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .C2LLVMParser import C2LLVMParser
else:
    from C2LLVMParser import C2LLVMParser

# This class defines a complete generic visitor for a parse tree produced by C2LLVMParser.

class C2LLVMVisitor(ParseTreeVisitor):

    # Visit a parse tree produced by C2LLVMParser#start.
    def visitStart(self, ctx:C2LLVMParser.StartContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#codeBlock.
    def visitCodeBlock(self, ctx:C2LLVMParser.CodeBlockContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#include.
    def visitInclude(self, ctx:C2LLVMParser.IncludeContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#structPack.
    def visitStructPack(self, ctx:C2LLVMParser.StructPackContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#function.
    def visitFunction(self, ctx:C2LLVMParser.FunctionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#params.
    def visitParams(self, ctx:C2LLVMParser.ParamsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#param.
    def visitParam(self, ctx:C2LLVMParser.ParamContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#usualType.
    def visitUsualType(self, ctx:C2LLVMParser.UsualTypeContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#pointerType.
    def visitPointerType(self, ctx:C2LLVMParser.PointerTypeContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#packcontent.
    def visitPackcontent(self, ctx:C2LLVMParser.PackcontentContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#content.
    def visitContent(self, ctx:C2LLVMParser.ContentContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#stat.
    def visitStat(self, ctx:C2LLVMParser.StatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#declareStat.
    def visitDeclareStat(self, ctx:C2LLVMParser.DeclareStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#assignStat.
    def visitAssignStat(self, ctx:C2LLVMParser.AssignStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#breakStat.
    def visitBreakStat(self, ctx:C2LLVMParser.BreakStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#returnStat.
    def visitReturnStat(self, ctx:C2LLVMParser.ReturnStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#freeStat.
    def visitFreeStat(self, ctx:C2LLVMParser.FreeStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#continueStat.
    def visitContinueStat(self, ctx:C2LLVMParser.ContinueStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#scanfStat.
    def visitScanfStat(self, ctx:C2LLVMParser.ScanfStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#printfStat.
    def visitPrintfStat(self, ctx:C2LLVMParser.PrintfStatContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#expr.
    def visitExpr(self, ctx:C2LLVMParser.ExprContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#arrayValue.
    def visitArrayValue(self, ctx:C2LLVMParser.ArrayValueContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#funcExpr.
    def visitFuncExpr(self, ctx:C2LLVMParser.FuncExprContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#pre.
    def visitPre(self, ctx:C2LLVMParser.PreContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#func.
    def visitFunc(self, ctx:C2LLVMParser.FuncContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#customFunc.
    def visitCustomFunc(self, ctx:C2LLVMParser.CustomFuncContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#actualParams.
    def visitActualParams(self, ctx:C2LLVMParser.ActualParamsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#actualParam.
    def visitActualParam(self, ctx:C2LLVMParser.ActualParamContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#mallocFunc.
    def visitMallocFunc(self, ctx:C2LLVMParser.MallocFuncContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#block.
    def visitBlock(self, ctx:C2LLVMParser.BlockContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#ifBlock.
    def visitIfBlock(self, ctx:C2LLVMParser.IfBlockContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#whileBlock.
    def visitWhileBlock(self, ctx:C2LLVMParser.WhileBlockContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#elseBlock.
    def visitElseBlock(self, ctx:C2LLVMParser.ElseBlockContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#elseifBlock.
    def visitElseifBlock(self, ctx:C2LLVMParser.ElseifBlockContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#condition.
    def visitCondition(self, ctx:C2LLVMParser.ConditionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#logic.
    def visitLogic(self, ctx:C2LLVMParser.LogicContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#varType.
    def visitVarType(self, ctx:C2LLVMParser.VarTypeContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by C2LLVMParser#operator.
    def visitOperator(self, ctx:C2LLVMParser.OperatorContext):
        return self.visitChildren(ctx)



del C2LLVMParser