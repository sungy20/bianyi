// Generated from C2LLVM.g4 by ANTLR 4.9.2
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link C2LLVMParser}.
 */
public interface C2LLVMListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#start}.
	 * @param ctx the parse tree
	 */
	void enterStart(C2LLVMParser.StartContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#start}.
	 * @param ctx the parse tree
	 */
	void exitStart(C2LLVMParser.StartContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#codeBlock}.
	 * @param ctx the parse tree
	 */
	void enterCodeBlock(C2LLVMParser.CodeBlockContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#codeBlock}.
	 * @param ctx the parse tree
	 */
	void exitCodeBlock(C2LLVMParser.CodeBlockContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#include}.
	 * @param ctx the parse tree
	 */
	void enterInclude(C2LLVMParser.IncludeContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#include}.
	 * @param ctx the parse tree
	 */
	void exitInclude(C2LLVMParser.IncludeContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#structPack}.
	 * @param ctx the parse tree
	 */
	void enterStructPack(C2LLVMParser.StructPackContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#structPack}.
	 * @param ctx the parse tree
	 */
	void exitStructPack(C2LLVMParser.StructPackContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#function}.
	 * @param ctx the parse tree
	 */
	void enterFunction(C2LLVMParser.FunctionContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#function}.
	 * @param ctx the parse tree
	 */
	void exitFunction(C2LLVMParser.FunctionContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#params}.
	 * @param ctx the parse tree
	 */
	void enterParams(C2LLVMParser.ParamsContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#params}.
	 * @param ctx the parse tree
	 */
	void exitParams(C2LLVMParser.ParamsContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#param}.
	 * @param ctx the parse tree
	 */
	void enterParam(C2LLVMParser.ParamContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#param}.
	 * @param ctx the parse tree
	 */
	void exitParam(C2LLVMParser.ParamContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#usualType}.
	 * @param ctx the parse tree
	 */
	void enterUsualType(C2LLVMParser.UsualTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#usualType}.
	 * @param ctx the parse tree
	 */
	void exitUsualType(C2LLVMParser.UsualTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#pointerType}.
	 * @param ctx the parse tree
	 */
	void enterPointerType(C2LLVMParser.PointerTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#pointerType}.
	 * @param ctx the parse tree
	 */
	void exitPointerType(C2LLVMParser.PointerTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#packcontent}.
	 * @param ctx the parse tree
	 */
	void enterPackcontent(C2LLVMParser.PackcontentContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#packcontent}.
	 * @param ctx the parse tree
	 */
	void exitPackcontent(C2LLVMParser.PackcontentContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#content}.
	 * @param ctx the parse tree
	 */
	void enterContent(C2LLVMParser.ContentContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#content}.
	 * @param ctx the parse tree
	 */
	void exitContent(C2LLVMParser.ContentContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#stat}.
	 * @param ctx the parse tree
	 */
	void enterStat(C2LLVMParser.StatContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#stat}.
	 * @param ctx the parse tree
	 */
	void exitStat(C2LLVMParser.StatContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#declareStat}.
	 * @param ctx the parse tree
	 */
	void enterDeclareStat(C2LLVMParser.DeclareStatContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#declareStat}.
	 * @param ctx the parse tree
	 */
	void exitDeclareStat(C2LLVMParser.DeclareStatContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#assignStat}.
	 * @param ctx the parse tree
	 */
	void enterAssignStat(C2LLVMParser.AssignStatContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#assignStat}.
	 * @param ctx the parse tree
	 */
	void exitAssignStat(C2LLVMParser.AssignStatContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#breakStat}.
	 * @param ctx the parse tree
	 */
	void enterBreakStat(C2LLVMParser.BreakStatContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#breakStat}.
	 * @param ctx the parse tree
	 */
	void exitBreakStat(C2LLVMParser.BreakStatContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#returnStat}.
	 * @param ctx the parse tree
	 */
	void enterReturnStat(C2LLVMParser.ReturnStatContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#returnStat}.
	 * @param ctx the parse tree
	 */
	void exitReturnStat(C2LLVMParser.ReturnStatContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#freeStat}.
	 * @param ctx the parse tree
	 */
	void enterFreeStat(C2LLVMParser.FreeStatContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#freeStat}.
	 * @param ctx the parse tree
	 */
	void exitFreeStat(C2LLVMParser.FreeStatContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#continueStat}.
	 * @param ctx the parse tree
	 */
	void enterContinueStat(C2LLVMParser.ContinueStatContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#continueStat}.
	 * @param ctx the parse tree
	 */
	void exitContinueStat(C2LLVMParser.ContinueStatContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#scanfStat}.
	 * @param ctx the parse tree
	 */
	void enterScanfStat(C2LLVMParser.ScanfStatContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#scanfStat}.
	 * @param ctx the parse tree
	 */
	void exitScanfStat(C2LLVMParser.ScanfStatContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#printfStat}.
	 * @param ctx the parse tree
	 */
	void enterPrintfStat(C2LLVMParser.PrintfStatContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#printfStat}.
	 * @param ctx the parse tree
	 */
	void exitPrintfStat(C2LLVMParser.PrintfStatContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(C2LLVMParser.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(C2LLVMParser.ExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#arrayValue}.
	 * @param ctx the parse tree
	 */
	void enterArrayValue(C2LLVMParser.ArrayValueContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#arrayValue}.
	 * @param ctx the parse tree
	 */
	void exitArrayValue(C2LLVMParser.ArrayValueContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#array}.
	 * @param ctx the parse tree
	 */
	void enterArray(C2LLVMParser.ArrayContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#array}.
	 * @param ctx the parse tree
	 */
	void exitArray(C2LLVMParser.ArrayContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#funcExpr}.
	 * @param ctx the parse tree
	 */
	void enterFuncExpr(C2LLVMParser.FuncExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#funcExpr}.
	 * @param ctx the parse tree
	 */
	void exitFuncExpr(C2LLVMParser.FuncExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#pre}.
	 * @param ctx the parse tree
	 */
	void enterPre(C2LLVMParser.PreContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#pre}.
	 * @param ctx the parse tree
	 */
	void exitPre(C2LLVMParser.PreContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#func}.
	 * @param ctx the parse tree
	 */
	void enterFunc(C2LLVMParser.FuncContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#func}.
	 * @param ctx the parse tree
	 */
	void exitFunc(C2LLVMParser.FuncContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#customFunc}.
	 * @param ctx the parse tree
	 */
	void enterCustomFunc(C2LLVMParser.CustomFuncContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#customFunc}.
	 * @param ctx the parse tree
	 */
	void exitCustomFunc(C2LLVMParser.CustomFuncContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#actualParams}.
	 * @param ctx the parse tree
	 */
	void enterActualParams(C2LLVMParser.ActualParamsContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#actualParams}.
	 * @param ctx the parse tree
	 */
	void exitActualParams(C2LLVMParser.ActualParamsContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#actualParam}.
	 * @param ctx the parse tree
	 */
	void enterActualParam(C2LLVMParser.ActualParamContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#actualParam}.
	 * @param ctx the parse tree
	 */
	void exitActualParam(C2LLVMParser.ActualParamContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#mallocFunc}.
	 * @param ctx the parse tree
	 */
	void enterMallocFunc(C2LLVMParser.MallocFuncContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#mallocFunc}.
	 * @param ctx the parse tree
	 */
	void exitMallocFunc(C2LLVMParser.MallocFuncContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#block}.
	 * @param ctx the parse tree
	 */
	void enterBlock(C2LLVMParser.BlockContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#block}.
	 * @param ctx the parse tree
	 */
	void exitBlock(C2LLVMParser.BlockContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#ifBlock}.
	 * @param ctx the parse tree
	 */
	void enterIfBlock(C2LLVMParser.IfBlockContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#ifBlock}.
	 * @param ctx the parse tree
	 */
	void exitIfBlock(C2LLVMParser.IfBlockContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#whileBlock}.
	 * @param ctx the parse tree
	 */
	void enterWhileBlock(C2LLVMParser.WhileBlockContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#whileBlock}.
	 * @param ctx the parse tree
	 */
	void exitWhileBlock(C2LLVMParser.WhileBlockContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#elseBlock}.
	 * @param ctx the parse tree
	 */
	void enterElseBlock(C2LLVMParser.ElseBlockContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#elseBlock}.
	 * @param ctx the parse tree
	 */
	void exitElseBlock(C2LLVMParser.ElseBlockContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#elseifBlock}.
	 * @param ctx the parse tree
	 */
	void enterElseifBlock(C2LLVMParser.ElseifBlockContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#elseifBlock}.
	 * @param ctx the parse tree
	 */
	void exitElseifBlock(C2LLVMParser.ElseifBlockContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#condition}.
	 * @param ctx the parse tree
	 */
	void enterCondition(C2LLVMParser.ConditionContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#condition}.
	 * @param ctx the parse tree
	 */
	void exitCondition(C2LLVMParser.ConditionContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#logic}.
	 * @param ctx the parse tree
	 */
	void enterLogic(C2LLVMParser.LogicContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#logic}.
	 * @param ctx the parse tree
	 */
	void exitLogic(C2LLVMParser.LogicContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#varType}.
	 * @param ctx the parse tree
	 */
	void enterVarType(C2LLVMParser.VarTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#varType}.
	 * @param ctx the parse tree
	 */
	void exitVarType(C2LLVMParser.VarTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#operator}.
	 * @param ctx the parse tree
	 */
	void enterOperator(C2LLVMParser.OperatorContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#operator}.
	 * @param ctx the parse tree
	 */
	void exitOperator(C2LLVMParser.OperatorContext ctx);
	/**
	 * Enter a parse tree produced by {@link C2LLVMParser#number}.
	 * @param ctx the parse tree
	 */
	void enterNumber(C2LLVMParser.NumberContext ctx);
	/**
	 * Exit a parse tree produced by {@link C2LLVMParser#number}.
	 * @param ctx the parse tree
	 */
	void exitNumber(C2LLVMParser.NumberContext ctx);
}