// Generated from d:\CodeStorage\GitHub\bianyi\antlr_about\C2LLVM.g4 by ANTLR 4.9.2
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class C2LLVMParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.9.2", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, T__8=9, 
		T__9=10, T__10=11, T__11=12, T__12=13, T__13=14, T__14=15, T__15=16, T__16=17, 
		T__17=18, T__18=19, T__19=20, T__20=21, T__21=22, T__22=23, T__23=24, 
		T__24=25, T__25=26, T__26=27, T__27=28, T__28=29, T__29=30, T__30=31, 
		T__31=32, T__32=33, T__33=34, T__34=35, T__35=36, T__36=37, T__37=38, 
		T__38=39, T__39=40, StrVar=41, INT=42, CHAR=43, STRING=44, Comment=45, 
		LineComment=46, WS=47;
	public static final int
		RULE_start = 0, RULE_codeBlock = 1, RULE_include = 2, RULE_structPack = 3, 
		RULE_function = 4, RULE_params = 5, RULE_param = 6, RULE_usualType = 7, 
		RULE_pointerType = 8, RULE_packcontent = 9, RULE_content = 10, RULE_stat = 11, 
		RULE_declareStat = 12, RULE_assignStat = 13, RULE_breakStat = 14, RULE_returnStat = 15, 
		RULE_freeStat = 16, RULE_continueStat = 17, RULE_scanfStat = 18, RULE_printfStat = 19, 
		RULE_expr = 20, RULE_arrayValue = 21, RULE_array = 22, RULE_funcExpr = 23, 
		RULE_pre = 24, RULE_func = 25, RULE_customFunc = 26, RULE_actualParams = 27, 
		RULE_actualParam = 28, RULE_mallocFunc = 29, RULE_block = 30, RULE_ifBlock = 31, 
		RULE_whileBlock = 32, RULE_elseBlock = 33, RULE_elseifBlock = 34, RULE_condition = 35, 
		RULE_logic = 36, RULE_varType = 37, RULE_operator = 38, RULE_number = 39;
	private static String[] makeRuleNames() {
		return new String[] {
			"start", "codeBlock", "include", "structPack", "function", "params", 
			"param", "usualType", "pointerType", "packcontent", "content", "stat", 
			"declareStat", "assignStat", "breakStat", "returnStat", "freeStat", "continueStat", 
			"scanfStat", "printfStat", "expr", "arrayValue", "array", "funcExpr", 
			"pre", "func", "customFunc", "actualParams", "actualParam", "mallocFunc", 
			"block", "ifBlock", "whileBlock", "elseBlock", "elseifBlock", "condition", 
			"logic", "varType", "operator", "number"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'#include'", "'<'", "'.'", "'>'", "'struct'", "'{'", "'}'", "';'", 
			"'('", "')'", "','", "'*'", "'='", "'break'", "'return'", "'free'", "'continue'", 
			"'scanf'", "'printf'", "'&'", "'['", "']'", "'malloc'", "'sizeof'", "'if'", 
			"'while'", "'else'", "'else if'", "'&&'", "'||'", "'=='", "'!='", "'>='", 
			"'<='", "'int'", "'char'", "'+'", "'-'", "'/'", "'->'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, "StrVar", "INT", "CHAR", "STRING", "Comment", 
			"LineComment", "WS"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "C2LLVM.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public C2LLVMParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	public static class StartContext extends ParserRuleContext {
		public List<CodeBlockContext> codeBlock() {
			return getRuleContexts(CodeBlockContext.class);
		}
		public CodeBlockContext codeBlock(int i) {
			return getRuleContext(CodeBlockContext.class,i);
		}
		public StartContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_start; }
	}

	public final StartContext start() throws RecognitionException {
		StartContext _localctx = new StartContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_start);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(83);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__4) | (1L << T__34) | (1L << T__35))) != 0)) {
				{
				{
				setState(80);
				codeBlock();
				}
				}
				setState(85);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class CodeBlockContext extends ParserRuleContext {
		public IncludeContext include() {
			return getRuleContext(IncludeContext.class,0);
		}
		public StructPackContext structPack() {
			return getRuleContext(StructPackContext.class,0);
		}
		public FunctionContext function() {
			return getRuleContext(FunctionContext.class,0);
		}
		public CodeBlockContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_codeBlock; }
	}

	public final CodeBlockContext codeBlock() throws RecognitionException {
		CodeBlockContext _localctx = new CodeBlockContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_codeBlock);
		try {
			setState(89);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,1,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(86);
				include();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(87);
				structPack();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(88);
				function();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class IncludeContext extends ParserRuleContext {
		public List<TerminalNode> StrVar() { return getTokens(C2LLVMParser.StrVar); }
		public TerminalNode StrVar(int i) {
			return getToken(C2LLVMParser.StrVar, i);
		}
		public IncludeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_include; }
	}

	public final IncludeContext include() throws RecognitionException {
		IncludeContext _localctx = new IncludeContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_include);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(91);
			match(T__0);
			setState(92);
			match(T__1);
			setState(93);
			match(StrVar);
			setState(94);
			match(T__2);
			setState(95);
			match(StrVar);
			setState(96);
			match(T__3);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StructPackContext extends ParserRuleContext {
		public TerminalNode StrVar() { return getToken(C2LLVMParser.StrVar, 0); }
		public ContentContext content() {
			return getRuleContext(ContentContext.class,0);
		}
		public StructPackContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_structPack; }
	}

	public final StructPackContext structPack() throws RecognitionException {
		StructPackContext _localctx = new StructPackContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_structPack);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(98);
			match(T__4);
			setState(99);
			match(StrVar);
			setState(100);
			match(T__5);
			setState(101);
			content();
			setState(102);
			match(T__6);
			setState(103);
			match(T__7);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FunctionContext extends ParserRuleContext {
		public VarTypeContext varType() {
			return getRuleContext(VarTypeContext.class,0);
		}
		public TerminalNode StrVar() { return getToken(C2LLVMParser.StrVar, 0); }
		public ParamsContext params() {
			return getRuleContext(ParamsContext.class,0);
		}
		public PackcontentContext packcontent() {
			return getRuleContext(PackcontentContext.class,0);
		}
		public FunctionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_function; }
	}

	public final FunctionContext function() throws RecognitionException {
		FunctionContext _localctx = new FunctionContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_function);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(105);
			varType();
			setState(106);
			match(StrVar);
			setState(107);
			match(T__8);
			setState(108);
			params();
			setState(109);
			match(T__9);
			setState(110);
			packcontent();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ParamsContext extends ParserRuleContext {
		public ParamContext param() {
			return getRuleContext(ParamContext.class,0);
		}
		public ParamsContext params() {
			return getRuleContext(ParamsContext.class,0);
		}
		public ParamsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_params; }
	}

	public final ParamsContext params() throws RecognitionException {
		ParamsContext _localctx = new ParamsContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_params);
		try {
			setState(118);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,2,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(112);
				param();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(113);
				param();
				setState(114);
				match(T__10);
				setState(115);
				params();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ParamContext extends ParserRuleContext {
		public UsualTypeContext usualType() {
			return getRuleContext(UsualTypeContext.class,0);
		}
		public TerminalNode StrVar() { return getToken(C2LLVMParser.StrVar, 0); }
		public ParamContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_param; }
	}

	public final ParamContext param() throws RecognitionException {
		ParamContext _localctx = new ParamContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_param);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(120);
			usualType();
			setState(121);
			match(StrVar);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class UsualTypeContext extends ParserRuleContext {
		public VarTypeContext varType() {
			return getRuleContext(VarTypeContext.class,0);
		}
		public PointerTypeContext pointerType() {
			return getRuleContext(PointerTypeContext.class,0);
		}
		public UsualTypeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_usualType; }
	}

	public final UsualTypeContext usualType() throws RecognitionException {
		UsualTypeContext _localctx = new UsualTypeContext(_ctx, getState());
		enterRule(_localctx, 14, RULE_usualType);
		try {
			setState(125);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,3,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(123);
				varType();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(124);
				pointerType();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class PointerTypeContext extends ParserRuleContext {
		public VarTypeContext varType() {
			return getRuleContext(VarTypeContext.class,0);
		}
		public TerminalNode StrVar() { return getToken(C2LLVMParser.StrVar, 0); }
		public PointerTypeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pointerType; }
	}

	public final PointerTypeContext pointerType() throws RecognitionException {
		PointerTypeContext _localctx = new PointerTypeContext(_ctx, getState());
		enterRule(_localctx, 16, RULE_pointerType);
		try {
			setState(135);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,4,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(127);
				varType();
				setState(128);
				match(T__11);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(130);
				match(T__4);
				setState(131);
				match(StrVar);
				setState(132);
				match(T__11);
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(133);
				match(StrVar);
				setState(134);
				match(T__11);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class PackcontentContext extends ParserRuleContext {
		public StatContext stat() {
			return getRuleContext(StatContext.class,0);
		}
		public BlockContext block() {
			return getRuleContext(BlockContext.class,0);
		}
		public ContentContext content() {
			return getRuleContext(ContentContext.class,0);
		}
		public PackcontentContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_packcontent; }
	}

	public final PackcontentContext packcontent() throws RecognitionException {
		PackcontentContext _localctx = new PackcontentContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_packcontent);
		try {
			setState(146);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case EOF:
			case T__0:
			case T__4:
			case T__6:
			case T__8:
			case T__13:
			case T__14:
			case T__15:
			case T__16:
			case T__17:
			case T__18:
			case T__19:
			case T__22:
			case T__24:
			case T__25:
			case T__26:
			case T__27:
			case T__34:
			case T__35:
			case T__36:
			case T__37:
			case StrVar:
			case INT:
			case CHAR:
			case STRING:
				enterOuterAlt(_localctx, 1);
				{
				setState(140);
				_errHandler.sync(this);
				switch ( getInterpreter().adaptivePredict(_input,5,_ctx) ) {
				case 1:
					{
					setState(137);
					stat();
					}
					break;
				case 2:
					{
					setState(138);
					block();
					}
					break;
				case 3:
					{
					}
					break;
				}
				}
				break;
			case T__5:
				enterOuterAlt(_localctx, 2);
				{
				{
				setState(142);
				match(T__5);
				setState(143);
				content();
				setState(144);
				match(T__6);
				}
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ContentContext extends ParserRuleContext {
		public ContentContext content() {
			return getRuleContext(ContentContext.class,0);
		}
		public StatContext stat() {
			return getRuleContext(StatContext.class,0);
		}
		public BlockContext block() {
			return getRuleContext(BlockContext.class,0);
		}
		public ContentContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_content; }
	}

	public final ContentContext content() throws RecognitionException {
		ContentContext _localctx = new ContentContext(_ctx, getState());
		enterRule(_localctx, 20, RULE_content);
		try {
			setState(159);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,9,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(150);
				_errHandler.sync(this);
				switch (_input.LA(1)) {
				case T__4:
				case T__8:
				case T__13:
				case T__14:
				case T__15:
				case T__16:
				case T__17:
				case T__18:
				case T__19:
				case T__22:
				case T__34:
				case T__35:
				case T__36:
				case T__37:
				case StrVar:
				case INT:
				case CHAR:
				case STRING:
					{
					setState(148);
					stat();
					}
					break;
				case T__24:
				case T__25:
				case T__27:
					{
					setState(149);
					block();
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				setState(152);
				content();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(156);
				_errHandler.sync(this);
				switch (_input.LA(1)) {
				case T__4:
				case T__8:
				case T__13:
				case T__14:
				case T__15:
				case T__16:
				case T__17:
				case T__18:
				case T__19:
				case T__22:
				case T__34:
				case T__35:
				case T__36:
				case T__37:
				case StrVar:
				case INT:
				case CHAR:
				case STRING:
					{
					setState(154);
					stat();
					}
					break;
				case T__24:
				case T__25:
				case T__27:
					{
					setState(155);
					block();
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StatContext extends ParserRuleContext {
		public DeclareStatContext declareStat() {
			return getRuleContext(DeclareStatContext.class,0);
		}
		public AssignStatContext assignStat() {
			return getRuleContext(AssignStatContext.class,0);
		}
		public BreakStatContext breakStat() {
			return getRuleContext(BreakStatContext.class,0);
		}
		public ReturnStatContext returnStat() {
			return getRuleContext(ReturnStatContext.class,0);
		}
		public FreeStatContext freeStat() {
			return getRuleContext(FreeStatContext.class,0);
		}
		public ContinueStatContext continueStat() {
			return getRuleContext(ContinueStatContext.class,0);
		}
		public CustomFuncContext customFunc() {
			return getRuleContext(CustomFuncContext.class,0);
		}
		public ScanfStatContext scanfStat() {
			return getRuleContext(ScanfStatContext.class,0);
		}
		public PrintfStatContext printfStat() {
			return getRuleContext(PrintfStatContext.class,0);
		}
		public StatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_stat; }
	}

	public final StatContext stat() throws RecognitionException {
		StatContext _localctx = new StatContext(_ctx, getState());
		enterRule(_localctx, 22, RULE_stat);
		try {
			setState(172);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,10,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(161);
				declareStat();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(162);
				assignStat();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(163);
				breakStat();
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(164);
				returnStat();
				}
				break;
			case 5:
				enterOuterAlt(_localctx, 5);
				{
				setState(165);
				freeStat();
				}
				break;
			case 6:
				enterOuterAlt(_localctx, 6);
				{
				setState(166);
				continueStat();
				}
				break;
			case 7:
				enterOuterAlt(_localctx, 7);
				{
				{
				setState(167);
				customFunc();
				setState(168);
				match(T__7);
				}
				}
				break;
			case 8:
				enterOuterAlt(_localctx, 8);
				{
				setState(170);
				scanfStat();
				}
				break;
			case 9:
				enterOuterAlt(_localctx, 9);
				{
				setState(171);
				printfStat();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class DeclareStatContext extends ParserRuleContext {
		public UsualTypeContext usualType() {
			return getRuleContext(UsualTypeContext.class,0);
		}
		public TerminalNode StrVar() { return getToken(C2LLVMParser.StrVar, 0); }
		public VarTypeContext varType() {
			return getRuleContext(VarTypeContext.class,0);
		}
		public ArrayContext array() {
			return getRuleContext(ArrayContext.class,0);
		}
		public DeclareStatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_declareStat; }
	}

	public final DeclareStatContext declareStat() throws RecognitionException {
		DeclareStatContext _localctx = new DeclareStatContext(_ctx, getState());
		enterRule(_localctx, 24, RULE_declareStat);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(180);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,11,_ctx) ) {
			case 1:
				{
				setState(174);
				usualType();
				setState(175);
				match(StrVar);
				}
				break;
			case 2:
				{
				setState(177);
				varType();
				setState(178);
				array();
				}
				break;
			}
			setState(182);
			match(T__7);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssignStatContext extends ParserRuleContext {
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public UsualTypeContext usualType() {
			return getRuleContext(UsualTypeContext.class,0);
		}
		public TerminalNode StrVar() { return getToken(C2LLVMParser.StrVar, 0); }
		public ArrayValueContext arrayValue() {
			return getRuleContext(ArrayValueContext.class,0);
		}
		public VarTypeContext varType() {
			return getRuleContext(VarTypeContext.class,0);
		}
		public ArrayContext array() {
			return getRuleContext(ArrayContext.class,0);
		}
		public AssignStatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assignStat; }
	}

	public final AssignStatContext assignStat() throws RecognitionException {
		AssignStatContext _localctx = new AssignStatContext(_ctx, getState());
		enterRule(_localctx, 26, RULE_assignStat);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(193);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,12,_ctx) ) {
			case 1:
				{
				setState(184);
				usualType();
				setState(185);
				match(StrVar);
				}
				break;
			case 2:
				{
				setState(187);
				match(StrVar);
				}
				break;
			case 3:
				{
				setState(188);
				arrayValue();
				}
				break;
			case 4:
				{
				setState(189);
				expr(0);
				}
				break;
			case 5:
				{
				setState(190);
				varType();
				setState(191);
				array();
				}
				break;
			}
			setState(195);
			match(T__12);
			setState(196);
			expr(0);
			setState(197);
			match(T__7);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class BreakStatContext extends ParserRuleContext {
		public BreakStatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_breakStat; }
	}

	public final BreakStatContext breakStat() throws RecognitionException {
		BreakStatContext _localctx = new BreakStatContext(_ctx, getState());
		enterRule(_localctx, 28, RULE_breakStat);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(199);
			match(T__13);
			setState(200);
			match(T__7);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ReturnStatContext extends ParserRuleContext {
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public ReturnStatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_returnStat; }
	}

	public final ReturnStatContext returnStat() throws RecognitionException {
		ReturnStatContext _localctx = new ReturnStatContext(_ctx, getState());
		enterRule(_localctx, 30, RULE_returnStat);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(202);
			match(T__14);
			setState(203);
			expr(0);
			setState(204);
			match(T__7);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FreeStatContext extends ParserRuleContext {
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public FreeStatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_freeStat; }
	}

	public final FreeStatContext freeStat() throws RecognitionException {
		FreeStatContext _localctx = new FreeStatContext(_ctx, getState());
		enterRule(_localctx, 32, RULE_freeStat);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(206);
			match(T__15);
			setState(207);
			match(T__8);
			setState(208);
			expr(0);
			setState(209);
			match(T__9);
			setState(210);
			match(T__7);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ContinueStatContext extends ParserRuleContext {
		public ContinueStatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_continueStat; }
	}

	public final ContinueStatContext continueStat() throws RecognitionException {
		ContinueStatContext _localctx = new ContinueStatContext(_ctx, getState());
		enterRule(_localctx, 34, RULE_continueStat);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(212);
			match(T__16);
			setState(213);
			match(T__7);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ScanfStatContext extends ParserRuleContext {
		public TerminalNode STRING() { return getToken(C2LLVMParser.STRING, 0); }
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public ScanfStatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_scanfStat; }
	}

	public final ScanfStatContext scanfStat() throws RecognitionException {
		ScanfStatContext _localctx = new ScanfStatContext(_ctx, getState());
		enterRule(_localctx, 36, RULE_scanfStat);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(215);
			match(T__17);
			setState(216);
			match(T__8);
			setState(217);
			match(STRING);
			setState(220); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(218);
				match(T__10);
				setState(219);
				expr(0);
				}
				}
				setState(222); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( _la==T__10 );
			setState(224);
			match(T__9);
			setState(225);
			match(T__7);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class PrintfStatContext extends ParserRuleContext {
		public TerminalNode STRING() { return getToken(C2LLVMParser.STRING, 0); }
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public PrintfStatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_printfStat; }
	}

	public final PrintfStatContext printfStat() throws RecognitionException {
		PrintfStatContext _localctx = new PrintfStatContext(_ctx, getState());
		enterRule(_localctx, 38, RULE_printfStat);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(227);
			match(T__18);
			setState(228);
			match(T__8);
			setState(229);
			match(STRING);
			setState(234);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__10) {
				{
				{
				setState(230);
				match(T__10);
				setState(231);
				expr(0);
				}
				}
				setState(236);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(237);
			match(T__9);
			setState(238);
			match(T__7);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExprContext extends ParserRuleContext {
		public TerminalNode StrVar() { return getToken(C2LLVMParser.StrVar, 0); }
		public NumberContext number() {
			return getRuleContext(NumberContext.class,0);
		}
		public ArrayValueContext arrayValue() {
			return getRuleContext(ArrayValueContext.class,0);
		}
		public FuncExprContext funcExpr() {
			return getRuleContext(FuncExprContext.class,0);
		}
		public TerminalNode CHAR() { return getToken(C2LLVMParser.CHAR, 0); }
		public TerminalNode STRING() { return getToken(C2LLVMParser.STRING, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public OperatorContext operator() {
			return getRuleContext(OperatorContext.class,0);
		}
		public ExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expr; }
	}

	public final ExprContext expr() throws RecognitionException {
		return expr(0);
	}

	private ExprContext expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		ExprContext _localctx = new ExprContext(_ctx, _parentState);
		ExprContext _prevctx = _localctx;
		int _startState = 40;
		enterRecursionRule(_localctx, 40, RULE_expr, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(254);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__8:
			case T__22:
			case T__36:
			case T__37:
			case StrVar:
			case INT:
			case CHAR:
			case STRING:
				{
				setState(247);
				_errHandler.sync(this);
				switch ( getInterpreter().adaptivePredict(_input,15,_ctx) ) {
				case 1:
					{
					setState(241);
					match(StrVar);
					}
					break;
				case 2:
					{
					setState(242);
					number();
					}
					break;
				case 3:
					{
					setState(243);
					arrayValue();
					}
					break;
				case 4:
					{
					setState(244);
					funcExpr();
					}
					break;
				case 5:
					{
					setState(245);
					match(CHAR);
					}
					break;
				case 6:
					{
					setState(246);
					match(STRING);
					}
					break;
				}
				}
				break;
			case T__19:
				{
				setState(249);
				match(T__19);
				setState(252);
				_errHandler.sync(this);
				switch ( getInterpreter().adaptivePredict(_input,16,_ctx) ) {
				case 1:
					{
					setState(250);
					match(StrVar);
					}
					break;
				case 2:
					{
					setState(251);
					arrayValue();
					}
					break;
				}
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			_ctx.stop = _input.LT(-1);
			setState(267);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,19,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new ExprContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_expr);
					setState(256);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(257);
					operator();
					setState(263);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,18,_ctx) ) {
					case 1:
						{
						setState(258);
						match(StrVar);
						}
						break;
					case 2:
						{
						setState(259);
						number();
						}
						break;
					case 3:
						{
						setState(260);
						arrayValue();
						}
						break;
					case 4:
						{
						setState(261);
						funcExpr();
						}
						break;
					case 5:
						{
						setState(262);
						match(CHAR);
						}
						break;
					}
					}
					} 
				}
				setState(269);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,19,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class ArrayValueContext extends ParserRuleContext {
		public TerminalNode StrVar() { return getToken(C2LLVMParser.StrVar, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public ArrayValueContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_arrayValue; }
	}

	public final ArrayValueContext arrayValue() throws RecognitionException {
		ArrayValueContext _localctx = new ArrayValueContext(_ctx, getState());
		enterRule(_localctx, 42, RULE_arrayValue);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(270);
			match(StrVar);
			setState(271);
			match(T__20);
			setState(272);
			expr(0);
			setState(273);
			match(T__21);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ArrayContext extends ParserRuleContext {
		public TerminalNode StrVar() { return getToken(C2LLVMParser.StrVar, 0); }
		public TerminalNode INT() { return getToken(C2LLVMParser.INT, 0); }
		public ArrayContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_array; }
	}

	public final ArrayContext array() throws RecognitionException {
		ArrayContext _localctx = new ArrayContext(_ctx, getState());
		enterRule(_localctx, 44, RULE_array);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(275);
			match(StrVar);
			setState(276);
			match(T__20);
			setState(278);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==INT) {
				{
				setState(277);
				match(INT);
				}
			}

			setState(280);
			match(T__21);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FuncExprContext extends ParserRuleContext {
		public PreContext pre() {
			return getRuleContext(PreContext.class,0);
		}
		public FuncContext func() {
			return getRuleContext(FuncContext.class,0);
		}
		public FuncExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_funcExpr; }
	}

	public final FuncExprContext funcExpr() throws RecognitionException {
		FuncExprContext _localctx = new FuncExprContext(_ctx, getState());
		enterRule(_localctx, 46, RULE_funcExpr);
		try {
			setState(286);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__8:
				enterOuterAlt(_localctx, 1);
				{
				setState(282);
				pre();
				setState(283);
				func();
				}
				break;
			case T__22:
			case StrVar:
				enterOuterAlt(_localctx, 2);
				{
				setState(285);
				func();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class PreContext extends ParserRuleContext {
		public VarTypeContext varType() {
			return getRuleContext(VarTypeContext.class,0);
		}
		public TerminalNode StrVar() { return getToken(C2LLVMParser.StrVar, 0); }
		public PreContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pre; }
	}

	public final PreContext pre() throws RecognitionException {
		PreContext _localctx = new PreContext(_ctx, getState());
		enterRule(_localctx, 48, RULE_pre);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(288);
			match(T__8);
			setState(292);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__4:
			case T__34:
			case T__35:
				{
				setState(289);
				varType();
				}
				break;
			case StrVar:
				{
				setState(290);
				match(StrVar);
				setState(291);
				match(T__11);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			setState(294);
			match(T__9);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FuncContext extends ParserRuleContext {
		public CustomFuncContext customFunc() {
			return getRuleContext(CustomFuncContext.class,0);
		}
		public MallocFuncContext mallocFunc() {
			return getRuleContext(MallocFuncContext.class,0);
		}
		public FuncContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_func; }
	}

	public final FuncContext func() throws RecognitionException {
		FuncContext _localctx = new FuncContext(_ctx, getState());
		enterRule(_localctx, 50, RULE_func);
		try {
			setState(298);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case StrVar:
				enterOuterAlt(_localctx, 1);
				{
				setState(296);
				customFunc();
				}
				break;
			case T__22:
				enterOuterAlt(_localctx, 2);
				{
				setState(297);
				mallocFunc();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class CustomFuncContext extends ParserRuleContext {
		public TerminalNode StrVar() { return getToken(C2LLVMParser.StrVar, 0); }
		public ActualParamsContext actualParams() {
			return getRuleContext(ActualParamsContext.class,0);
		}
		public CustomFuncContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_customFunc; }
	}

	public final CustomFuncContext customFunc() throws RecognitionException {
		CustomFuncContext _localctx = new CustomFuncContext(_ctx, getState());
		enterRule(_localctx, 52, RULE_customFunc);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(300);
			match(StrVar);
			setState(301);
			match(T__8);
			setState(302);
			actualParams();
			setState(303);
			match(T__9);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ActualParamsContext extends ParserRuleContext {
		public ActualParamContext actualParam() {
			return getRuleContext(ActualParamContext.class,0);
		}
		public ActualParamsContext actualParams() {
			return getRuleContext(ActualParamsContext.class,0);
		}
		public ActualParamsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_actualParams; }
	}

	public final ActualParamsContext actualParams() throws RecognitionException {
		ActualParamsContext _localctx = new ActualParamsContext(_ctx, getState());
		enterRule(_localctx, 54, RULE_actualParams);
		try {
			setState(311);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,24,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(305);
				actualParam();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(306);
				actualParam();
				setState(307);
				match(T__10);
				setState(308);
				actualParams();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ActualParamContext extends ParserRuleContext {
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public ActualParamContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_actualParam; }
	}

	public final ActualParamContext actualParam() throws RecognitionException {
		ActualParamContext _localctx = new ActualParamContext(_ctx, getState());
		enterRule(_localctx, 56, RULE_actualParam);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(313);
			expr(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class MallocFuncContext extends ParserRuleContext {
		public TerminalNode StrVar() { return getToken(C2LLVMParser.StrVar, 0); }
		public MallocFuncContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_mallocFunc; }
	}

	public final MallocFuncContext mallocFunc() throws RecognitionException {
		MallocFuncContext _localctx = new MallocFuncContext(_ctx, getState());
		enterRule(_localctx, 58, RULE_mallocFunc);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(315);
			match(T__22);
			setState(316);
			match(T__8);
			setState(317);
			match(T__23);
			setState(318);
			match(T__8);
			setState(319);
			match(StrVar);
			setState(320);
			match(T__9);
			setState(321);
			match(T__9);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class BlockContext extends ParserRuleContext {
		public WhileBlockContext whileBlock() {
			return getRuleContext(WhileBlockContext.class,0);
		}
		public IfBlockContext ifBlock() {
			return getRuleContext(IfBlockContext.class,0);
		}
		public ElseifBlockContext elseifBlock() {
			return getRuleContext(ElseifBlockContext.class,0);
		}
		public BlockContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_block; }
	}

	public final BlockContext block() throws RecognitionException {
		BlockContext _localctx = new BlockContext(_ctx, getState());
		enterRule(_localctx, 60, RULE_block);
		try {
			setState(326);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__25:
				enterOuterAlt(_localctx, 1);
				{
				setState(323);
				whileBlock();
				}
				break;
			case T__24:
				enterOuterAlt(_localctx, 2);
				{
				setState(324);
				ifBlock();
				}
				break;
			case T__27:
				enterOuterAlt(_localctx, 3);
				{
				setState(325);
				elseifBlock();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class IfBlockContext extends ParserRuleContext {
		public ConditionContext condition() {
			return getRuleContext(ConditionContext.class,0);
		}
		public PackcontentContext packcontent() {
			return getRuleContext(PackcontentContext.class,0);
		}
		public ElseBlockContext elseBlock() {
			return getRuleContext(ElseBlockContext.class,0);
		}
		public IfBlockContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_ifBlock; }
	}

	public final IfBlockContext ifBlock() throws RecognitionException {
		IfBlockContext _localctx = new IfBlockContext(_ctx, getState());
		enterRule(_localctx, 62, RULE_ifBlock);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(328);
			match(T__24);
			setState(329);
			match(T__8);
			setState(330);
			condition(0);
			setState(331);
			match(T__9);
			setState(332);
			packcontent();
			setState(334);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,26,_ctx) ) {
			case 1:
				{
				setState(333);
				elseBlock();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class WhileBlockContext extends ParserRuleContext {
		public ConditionContext condition() {
			return getRuleContext(ConditionContext.class,0);
		}
		public PackcontentContext packcontent() {
			return getRuleContext(PackcontentContext.class,0);
		}
		public WhileBlockContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_whileBlock; }
	}

	public final WhileBlockContext whileBlock() throws RecognitionException {
		WhileBlockContext _localctx = new WhileBlockContext(_ctx, getState());
		enterRule(_localctx, 64, RULE_whileBlock);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(336);
			match(T__25);
			setState(337);
			match(T__8);
			setState(338);
			condition(0);
			setState(339);
			match(T__9);
			setState(340);
			packcontent();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ElseBlockContext extends ParserRuleContext {
		public PackcontentContext packcontent() {
			return getRuleContext(PackcontentContext.class,0);
		}
		public ElseBlockContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_elseBlock; }
	}

	public final ElseBlockContext elseBlock() throws RecognitionException {
		ElseBlockContext _localctx = new ElseBlockContext(_ctx, getState());
		enterRule(_localctx, 66, RULE_elseBlock);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(342);
			match(T__26);
			setState(343);
			packcontent();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ElseifBlockContext extends ParserRuleContext {
		public ConditionContext condition() {
			return getRuleContext(ConditionContext.class,0);
		}
		public PackcontentContext packcontent() {
			return getRuleContext(PackcontentContext.class,0);
		}
		public ElseBlockContext elseBlock() {
			return getRuleContext(ElseBlockContext.class,0);
		}
		public ElseifBlockContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_elseifBlock; }
	}

	public final ElseifBlockContext elseifBlock() throws RecognitionException {
		ElseifBlockContext _localctx = new ElseifBlockContext(_ctx, getState());
		enterRule(_localctx, 68, RULE_elseifBlock);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(345);
			match(T__27);
			setState(346);
			match(T__8);
			setState(347);
			condition(0);
			setState(348);
			match(T__9);
			setState(349);
			packcontent();
			setState(351);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,27,_ctx) ) {
			case 1:
				{
				setState(350);
				elseBlock();
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ConditionContext extends ParserRuleContext {
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public LogicContext logic() {
			return getRuleContext(LogicContext.class,0);
		}
		public List<ConditionContext> condition() {
			return getRuleContexts(ConditionContext.class);
		}
		public ConditionContext condition(int i) {
			return getRuleContext(ConditionContext.class,i);
		}
		public ConditionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_condition; }
	}

	public final ConditionContext condition() throws RecognitionException {
		return condition(0);
	}

	private ConditionContext condition(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		ConditionContext _localctx = new ConditionContext(_ctx, _parentState);
		ConditionContext _prevctx = _localctx;
		int _startState = 70;
		enterRecursionRule(_localctx, 70, RULE_condition, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(365);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,28,_ctx) ) {
			case 1:
				{
				setState(354);
				expr(0);
				}
				break;
			case 2:
				{
				setState(355);
				match(T__8);
				setState(356);
				expr(0);
				setState(357);
				match(T__9);
				setState(358);
				logic();
				setState(359);
				condition(3);
				}
				break;
			case 3:
				{
				setState(361);
				match(T__8);
				setState(362);
				condition(0);
				setState(363);
				match(T__9);
				}
				break;
			}
			_ctx.stop = _input.LT(-1);
			setState(373);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,29,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new ConditionContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_condition);
					setState(367);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(368);
					logic();
					setState(369);
					condition(3);
					}
					} 
				}
				setState(375);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,29,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class LogicContext extends ParserRuleContext {
		public LogicContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_logic; }
	}

	public final LogicContext logic() throws RecognitionException {
		LogicContext _localctx = new LogicContext(_ctx, getState());
		enterRule(_localctx, 72, RULE_logic);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(376);
			_la = _input.LA(1);
			if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__1) | (1L << T__3) | (1L << T__28) | (1L << T__29) | (1L << T__30) | (1L << T__31) | (1L << T__32) | (1L << T__33))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VarTypeContext extends ParserRuleContext {
		public VarTypeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_varType; }
	}

	public final VarTypeContext varType() throws RecognitionException {
		VarTypeContext _localctx = new VarTypeContext(_ctx, getState());
		enterRule(_localctx, 74, RULE_varType);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(378);
			_la = _input.LA(1);
			if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__4) | (1L << T__34) | (1L << T__35))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class OperatorContext extends ParserRuleContext {
		public OperatorContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_operator; }
	}

	public final OperatorContext operator() throws RecognitionException {
		OperatorContext _localctx = new OperatorContext(_ctx, getState());
		enterRule(_localctx, 76, RULE_operator);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(380);
			_la = _input.LA(1);
			if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__11) | (1L << T__36) | (1L << T__37) | (1L << T__38) | (1L << T__39))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class NumberContext extends ParserRuleContext {
		public TerminalNode INT() { return getToken(C2LLVMParser.INT, 0); }
		public NumberContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_number; }
	}

	public final NumberContext number() throws RecognitionException {
		NumberContext _localctx = new NumberContext(_ctx, getState());
		enterRule(_localctx, 78, RULE_number);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(383);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__36 || _la==T__37) {
				{
				setState(382);
				_la = _input.LA(1);
				if ( !(_la==T__36 || _la==T__37) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				}
			}

			setState(385);
			match(INT);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 20:
			return expr_sempred((ExprContext)_localctx, predIndex);
		case 35:
			return condition_sempred((ConditionContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean expr_sempred(ExprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 2);
		}
		return true;
	}
	private boolean condition_sempred(ConditionContext _localctx, int predIndex) {
		switch (predIndex) {
		case 1:
			return precpred(_ctx, 2);
		}
		return true;
	}

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\61\u0186\4\2\t\2"+
		"\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13"+
		"\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31\t\31"+
		"\4\32\t\32\4\33\t\33\4\34\t\34\4\35\t\35\4\36\t\36\4\37\t\37\4 \t \4!"+
		"\t!\4\"\t\"\4#\t#\4$\t$\4%\t%\4&\t&\4\'\t\'\4(\t(\4)\t)\3\2\7\2T\n\2\f"+
		"\2\16\2W\13\2\3\3\3\3\3\3\5\3\\\n\3\3\4\3\4\3\4\3\4\3\4\3\4\3\4\3\5\3"+
		"\5\3\5\3\5\3\5\3\5\3\5\3\6\3\6\3\6\3\6\3\6\3\6\3\6\3\7\3\7\3\7\3\7\3\7"+
		"\3\7\5\7y\n\7\3\b\3\b\3\b\3\t\3\t\5\t\u0080\n\t\3\n\3\n\3\n\3\n\3\n\3"+
		"\n\3\n\3\n\5\n\u008a\n\n\3\13\3\13\3\13\5\13\u008f\n\13\3\13\3\13\3\13"+
		"\3\13\5\13\u0095\n\13\3\f\3\f\5\f\u0099\n\f\3\f\3\f\3\f\3\f\5\f\u009f"+
		"\n\f\3\f\5\f\u00a2\n\f\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\5\r"+
		"\u00af\n\r\3\16\3\16\3\16\3\16\3\16\3\16\5\16\u00b7\n\16\3\16\3\16\3\17"+
		"\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\5\17\u00c4\n\17\3\17\3\17\3\17"+
		"\3\17\3\20\3\20\3\20\3\21\3\21\3\21\3\21\3\22\3\22\3\22\3\22\3\22\3\22"+
		"\3\23\3\23\3\23\3\24\3\24\3\24\3\24\3\24\6\24\u00df\n\24\r\24\16\24\u00e0"+
		"\3\24\3\24\3\24\3\25\3\25\3\25\3\25\3\25\7\25\u00eb\n\25\f\25\16\25\u00ee"+
		"\13\25\3\25\3\25\3\25\3\26\3\26\3\26\3\26\3\26\3\26\3\26\5\26\u00fa\n"+
		"\26\3\26\3\26\3\26\5\26\u00ff\n\26\5\26\u0101\n\26\3\26\3\26\3\26\3\26"+
		"\3\26\3\26\3\26\5\26\u010a\n\26\7\26\u010c\n\26\f\26\16\26\u010f\13\26"+
		"\3\27\3\27\3\27\3\27\3\27\3\30\3\30\3\30\5\30\u0119\n\30\3\30\3\30\3\31"+
		"\3\31\3\31\3\31\5\31\u0121\n\31\3\32\3\32\3\32\3\32\5\32\u0127\n\32\3"+
		"\32\3\32\3\33\3\33\5\33\u012d\n\33\3\34\3\34\3\34\3\34\3\34\3\35\3\35"+
		"\3\35\3\35\3\35\3\35\5\35\u013a\n\35\3\36\3\36\3\37\3\37\3\37\3\37\3\37"+
		"\3\37\3\37\3\37\3 \3 \3 \5 \u0149\n \3!\3!\3!\3!\3!\3!\5!\u0151\n!\3\""+
		"\3\"\3\"\3\"\3\"\3\"\3#\3#\3#\3$\3$\3$\3$\3$\3$\5$\u0162\n$\3%\3%\3%\3"+
		"%\3%\3%\3%\3%\3%\3%\3%\3%\5%\u0170\n%\3%\3%\3%\3%\7%\u0176\n%\f%\16%\u0179"+
		"\13%\3&\3&\3\'\3\'\3(\3(\3)\5)\u0182\n)\3)\3)\3)\2\4*H*\2\4\6\b\n\f\16"+
		"\20\22\24\26\30\32\34\36 \"$&(*,.\60\62\64\668:<>@BDFHJLNP\2\6\5\2\4\4"+
		"\6\6\37$\4\2\7\7%&\4\2\16\16\'*\3\2\'(\2\u0195\2U\3\2\2\2\4[\3\2\2\2\6"+
		"]\3\2\2\2\bd\3\2\2\2\nk\3\2\2\2\fx\3\2\2\2\16z\3\2\2\2\20\177\3\2\2\2"+
		"\22\u0089\3\2\2\2\24\u0094\3\2\2\2\26\u00a1\3\2\2\2\30\u00ae\3\2\2\2\32"+
		"\u00b6\3\2\2\2\34\u00c3\3\2\2\2\36\u00c9\3\2\2\2 \u00cc\3\2\2\2\"\u00d0"+
		"\3\2\2\2$\u00d6\3\2\2\2&\u00d9\3\2\2\2(\u00e5\3\2\2\2*\u0100\3\2\2\2,"+
		"\u0110\3\2\2\2.\u0115\3\2\2\2\60\u0120\3\2\2\2\62\u0122\3\2\2\2\64\u012c"+
		"\3\2\2\2\66\u012e\3\2\2\28\u0139\3\2\2\2:\u013b\3\2\2\2<\u013d\3\2\2\2"+
		">\u0148\3\2\2\2@\u014a\3\2\2\2B\u0152\3\2\2\2D\u0158\3\2\2\2F\u015b\3"+
		"\2\2\2H\u016f\3\2\2\2J\u017a\3\2\2\2L\u017c\3\2\2\2N\u017e\3\2\2\2P\u0181"+
		"\3\2\2\2RT\5\4\3\2SR\3\2\2\2TW\3\2\2\2US\3\2\2\2UV\3\2\2\2V\3\3\2\2\2"+
		"WU\3\2\2\2X\\\5\6\4\2Y\\\5\b\5\2Z\\\5\n\6\2[X\3\2\2\2[Y\3\2\2\2[Z\3\2"+
		"\2\2\\\5\3\2\2\2]^\7\3\2\2^_\7\4\2\2_`\7+\2\2`a\7\5\2\2ab\7+\2\2bc\7\6"+
		"\2\2c\7\3\2\2\2de\7\7\2\2ef\7+\2\2fg\7\b\2\2gh\5\26\f\2hi\7\t\2\2ij\7"+
		"\n\2\2j\t\3\2\2\2kl\5L\'\2lm\7+\2\2mn\7\13\2\2no\5\f\7\2op\7\f\2\2pq\5"+
		"\24\13\2q\13\3\2\2\2ry\5\16\b\2st\5\16\b\2tu\7\r\2\2uv\5\f\7\2vy\3\2\2"+
		"\2wy\3\2\2\2xr\3\2\2\2xs\3\2\2\2xw\3\2\2\2y\r\3\2\2\2z{\5\20\t\2{|\7+"+
		"\2\2|\17\3\2\2\2}\u0080\5L\'\2~\u0080\5\22\n\2\177}\3\2\2\2\177~\3\2\2"+
		"\2\u0080\21\3\2\2\2\u0081\u0082\5L\'\2\u0082\u0083\7\16\2\2\u0083\u008a"+
		"\3\2\2\2\u0084\u0085\7\7\2\2\u0085\u0086\7+\2\2\u0086\u008a\7\16\2\2\u0087"+
		"\u0088\7+\2\2\u0088\u008a\7\16\2\2\u0089\u0081\3\2\2\2\u0089\u0084\3\2"+
		"\2\2\u0089\u0087\3\2\2\2\u008a\23\3\2\2\2\u008b\u008f\5\30\r\2\u008c\u008f"+
		"\5> \2\u008d\u008f\3\2\2\2\u008e\u008b\3\2\2\2\u008e\u008c\3\2\2\2\u008e"+
		"\u008d\3\2\2\2\u008f\u0095\3\2\2\2\u0090\u0091\7\b\2\2\u0091\u0092\5\26"+
		"\f\2\u0092\u0093\7\t\2\2\u0093\u0095\3\2\2\2\u0094\u008e\3\2\2\2\u0094"+
		"\u0090\3\2\2\2\u0095\25\3\2\2\2\u0096\u0099\5\30\r\2\u0097\u0099\5> \2"+
		"\u0098\u0096\3\2\2\2\u0098\u0097\3\2\2\2\u0099\u009a\3\2\2\2\u009a\u009b"+
		"\5\26\f\2\u009b\u00a2\3\2\2\2\u009c\u009f\5\30\r\2\u009d\u009f\5> \2\u009e"+
		"\u009c\3\2\2\2\u009e\u009d\3\2\2\2\u009f\u00a2\3\2\2\2\u00a0\u00a2\3\2"+
		"\2\2\u00a1\u0098\3\2\2\2\u00a1\u009e\3\2\2\2\u00a1\u00a0\3\2\2\2\u00a2"+
		"\27\3\2\2\2\u00a3\u00af\5\32\16\2\u00a4\u00af\5\34\17\2\u00a5\u00af\5"+
		"\36\20\2\u00a6\u00af\5 \21\2\u00a7\u00af\5\"\22\2\u00a8\u00af\5$\23\2"+
		"\u00a9\u00aa\5\66\34\2\u00aa\u00ab\7\n\2\2\u00ab\u00af\3\2\2\2\u00ac\u00af"+
		"\5&\24\2\u00ad\u00af\5(\25\2\u00ae\u00a3\3\2\2\2\u00ae\u00a4\3\2\2\2\u00ae"+
		"\u00a5\3\2\2\2\u00ae\u00a6\3\2\2\2\u00ae\u00a7\3\2\2\2\u00ae\u00a8\3\2"+
		"\2\2\u00ae\u00a9\3\2\2\2\u00ae\u00ac\3\2\2\2\u00ae\u00ad\3\2\2\2\u00af"+
		"\31\3\2\2\2\u00b0\u00b1\5\20\t\2\u00b1\u00b2\7+\2\2\u00b2\u00b7\3\2\2"+
		"\2\u00b3\u00b4\5L\'\2\u00b4\u00b5\5.\30\2\u00b5\u00b7\3\2\2\2\u00b6\u00b0"+
		"\3\2\2\2\u00b6\u00b3\3\2\2\2\u00b7\u00b8\3\2\2\2\u00b8\u00b9\7\n\2\2\u00b9"+
		"\33\3\2\2\2\u00ba\u00bb\5\20\t\2\u00bb\u00bc\7+\2\2\u00bc\u00c4\3\2\2"+
		"\2\u00bd\u00c4\7+\2\2\u00be\u00c4\5,\27\2\u00bf\u00c4\5*\26\2\u00c0\u00c1"+
		"\5L\'\2\u00c1\u00c2\5.\30\2\u00c2\u00c4\3\2\2\2\u00c3\u00ba\3\2\2\2\u00c3"+
		"\u00bd\3\2\2\2\u00c3\u00be\3\2\2\2\u00c3\u00bf\3\2\2\2\u00c3\u00c0\3\2"+
		"\2\2\u00c4\u00c5\3\2\2\2\u00c5\u00c6\7\17\2\2\u00c6\u00c7\5*\26\2\u00c7"+
		"\u00c8\7\n\2\2\u00c8\35\3\2\2\2\u00c9\u00ca\7\20\2\2\u00ca\u00cb\7\n\2"+
		"\2\u00cb\37\3\2\2\2\u00cc\u00cd\7\21\2\2\u00cd\u00ce\5*\26\2\u00ce\u00cf"+
		"\7\n\2\2\u00cf!\3\2\2\2\u00d0\u00d1\7\22\2\2\u00d1\u00d2\7\13\2\2\u00d2"+
		"\u00d3\5*\26\2\u00d3\u00d4\7\f\2\2\u00d4\u00d5\7\n\2\2\u00d5#\3\2\2\2"+
		"\u00d6\u00d7\7\23\2\2\u00d7\u00d8\7\n\2\2\u00d8%\3\2\2\2\u00d9\u00da\7"+
		"\24\2\2\u00da\u00db\7\13\2\2\u00db\u00de\7.\2\2\u00dc\u00dd\7\r\2\2\u00dd"+
		"\u00df\5*\26\2\u00de\u00dc\3\2\2\2\u00df\u00e0\3\2\2\2\u00e0\u00de\3\2"+
		"\2\2\u00e0\u00e1\3\2\2\2\u00e1\u00e2\3\2\2\2\u00e2\u00e3\7\f\2\2\u00e3"+
		"\u00e4\7\n\2\2\u00e4\'\3\2\2\2\u00e5\u00e6\7\25\2\2\u00e6\u00e7\7\13\2"+
		"\2\u00e7\u00ec\7.\2\2\u00e8\u00e9\7\r\2\2\u00e9\u00eb\5*\26\2\u00ea\u00e8"+
		"\3\2\2\2\u00eb\u00ee\3\2\2\2\u00ec\u00ea\3\2\2\2\u00ec\u00ed\3\2\2\2\u00ed"+
		"\u00ef\3\2\2\2\u00ee\u00ec\3\2\2\2\u00ef\u00f0\7\f\2\2\u00f0\u00f1\7\n"+
		"\2\2\u00f1)\3\2\2\2\u00f2\u00f9\b\26\1\2\u00f3\u00fa\7+\2\2\u00f4\u00fa"+
		"\5P)\2\u00f5\u00fa\5,\27\2\u00f6\u00fa\5\60\31\2\u00f7\u00fa\7-\2\2\u00f8"+
		"\u00fa\7.\2\2\u00f9\u00f3\3\2\2\2\u00f9\u00f4\3\2\2\2\u00f9\u00f5\3\2"+
		"\2\2\u00f9\u00f6\3\2\2\2\u00f9\u00f7\3\2\2\2\u00f9\u00f8\3\2\2\2\u00fa"+
		"\u0101\3\2\2\2\u00fb\u00fe\7\26\2\2\u00fc\u00ff\7+\2\2\u00fd\u00ff\5,"+
		"\27\2\u00fe\u00fc\3\2\2\2\u00fe\u00fd\3\2\2\2\u00ff\u0101\3\2\2\2\u0100"+
		"\u00f2\3\2\2\2\u0100\u00fb\3\2\2\2\u0101\u010d\3\2\2\2\u0102\u0103\f\4"+
		"\2\2\u0103\u0109\5N(\2\u0104\u010a\7+\2\2\u0105\u010a\5P)\2\u0106\u010a"+
		"\5,\27\2\u0107\u010a\5\60\31\2\u0108\u010a\7-\2\2\u0109\u0104\3\2\2\2"+
		"\u0109\u0105\3\2\2\2\u0109\u0106\3\2\2\2\u0109\u0107\3\2\2\2\u0109\u0108"+
		"\3\2\2\2\u010a\u010c\3\2\2\2\u010b\u0102\3\2\2\2\u010c\u010f\3\2\2\2\u010d"+
		"\u010b\3\2\2\2\u010d\u010e\3\2\2\2\u010e+\3\2\2\2\u010f\u010d\3\2\2\2"+
		"\u0110\u0111\7+\2\2\u0111\u0112\7\27\2\2\u0112\u0113\5*\26\2\u0113\u0114"+
		"\7\30\2\2\u0114-\3\2\2\2\u0115\u0116\7+\2\2\u0116\u0118\7\27\2\2\u0117"+
		"\u0119\7,\2\2\u0118\u0117\3\2\2\2\u0118\u0119\3\2\2\2\u0119\u011a\3\2"+
		"\2\2\u011a\u011b\7\30\2\2\u011b/\3\2\2\2\u011c\u011d\5\62\32\2\u011d\u011e"+
		"\5\64\33\2\u011e\u0121\3\2\2\2\u011f\u0121\5\64\33\2\u0120\u011c\3\2\2"+
		"\2\u0120\u011f\3\2\2\2\u0121\61\3\2\2\2\u0122\u0126\7\13\2\2\u0123\u0127"+
		"\5L\'\2\u0124\u0125\7+\2\2\u0125\u0127\7\16\2\2\u0126\u0123\3\2\2\2\u0126"+
		"\u0124\3\2\2\2\u0127\u0128\3\2\2\2\u0128\u0129\7\f\2\2\u0129\63\3\2\2"+
		"\2\u012a\u012d\5\66\34\2\u012b\u012d\5<\37\2\u012c\u012a\3\2\2\2\u012c"+
		"\u012b\3\2\2\2\u012d\65\3\2\2\2\u012e\u012f\7+\2\2\u012f\u0130\7\13\2"+
		"\2\u0130\u0131\58\35\2\u0131\u0132\7\f\2\2\u0132\67\3\2\2\2\u0133\u013a"+
		"\5:\36\2\u0134\u0135\5:\36\2\u0135\u0136\7\r\2\2\u0136\u0137\58\35\2\u0137"+
		"\u013a\3\2\2\2\u0138\u013a\3\2\2\2\u0139\u0133\3\2\2\2\u0139\u0134\3\2"+
		"\2\2\u0139\u0138\3\2\2\2\u013a9\3\2\2\2\u013b\u013c\5*\26\2\u013c;\3\2"+
		"\2\2\u013d\u013e\7\31\2\2\u013e\u013f\7\13\2\2\u013f\u0140\7\32\2\2\u0140"+
		"\u0141\7\13\2\2\u0141\u0142\7+\2\2\u0142\u0143\7\f\2\2\u0143\u0144\7\f"+
		"\2\2\u0144=\3\2\2\2\u0145\u0149\5B\"\2\u0146\u0149\5@!\2\u0147\u0149\5"+
		"F$\2\u0148\u0145\3\2\2\2\u0148\u0146\3\2\2\2\u0148\u0147\3\2\2\2\u0149"+
		"?\3\2\2\2\u014a\u014b\7\33\2\2\u014b\u014c\7\13\2\2\u014c\u014d\5H%\2"+
		"\u014d\u014e\7\f\2\2\u014e\u0150\5\24\13\2\u014f\u0151\5D#\2\u0150\u014f"+
		"\3\2\2\2\u0150\u0151\3\2\2\2\u0151A\3\2\2\2\u0152\u0153\7\34\2\2\u0153"+
		"\u0154\7\13\2\2\u0154\u0155\5H%\2\u0155\u0156\7\f\2\2\u0156\u0157\5\24"+
		"\13\2\u0157C\3\2\2\2\u0158\u0159\7\35\2\2\u0159\u015a\5\24\13\2\u015a"+
		"E\3\2\2\2\u015b\u015c\7\36\2\2\u015c\u015d\7\13\2\2\u015d\u015e\5H%\2"+
		"\u015e\u015f\7\f\2\2\u015f\u0161\5\24\13\2\u0160\u0162\5D#\2\u0161\u0160"+
		"\3\2\2\2\u0161\u0162\3\2\2\2\u0162G\3\2\2\2\u0163\u0164\b%\1\2\u0164\u0170"+
		"\5*\26\2\u0165\u0166\7\13\2\2\u0166\u0167\5*\26\2\u0167\u0168\7\f\2\2"+
		"\u0168\u0169\5J&\2\u0169\u016a\5H%\5\u016a\u0170\3\2\2\2\u016b\u016c\7"+
		"\13\2\2\u016c\u016d\5H%\2\u016d\u016e\7\f\2\2\u016e\u0170\3\2\2\2\u016f"+
		"\u0163\3\2\2\2\u016f\u0165\3\2\2\2\u016f\u016b\3\2\2\2\u0170\u0177\3\2"+
		"\2\2\u0171\u0172\f\4\2\2\u0172\u0173\5J&\2\u0173\u0174\5H%\5\u0174\u0176"+
		"\3\2\2\2\u0175\u0171\3\2\2\2\u0176\u0179\3\2\2\2\u0177\u0175\3\2\2\2\u0177"+
		"\u0178\3\2\2\2\u0178I\3\2\2\2\u0179\u0177\3\2\2\2\u017a\u017b\t\2\2\2"+
		"\u017bK\3\2\2\2\u017c\u017d\t\3\2\2\u017dM\3\2\2\2\u017e\u017f\t\4\2\2"+
		"\u017fO\3\2\2\2\u0180\u0182\t\5\2\2\u0181\u0180\3\2\2\2\u0181\u0182\3"+
		"\2\2\2\u0182\u0183\3\2\2\2\u0183\u0184\7,\2\2\u0184Q\3\2\2\2!U[x\177\u0089"+
		"\u008e\u0094\u0098\u009e\u00a1\u00ae\u00b6\u00c3\u00e0\u00ec\u00f9\u00fe"+
		"\u0100\u0109\u010d\u0118\u0120\u0126\u012c\u0139\u0148\u0150\u0161\u016f"+
		"\u0177\u0181";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}