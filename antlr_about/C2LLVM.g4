grammar C2LLVM;

start : codeBlock* ;

codeBlock: include | structPack | function ;

include : '#include' '<' StrVar '.' StrVar '>' ;

structPack: 'struct' StrVar '{' content '}' ';';

function : varType StrVar '(' params ')' packcontent;

params : param | param ',' params |;

// int a | int * a
param: usualType StrVar;

usualType: varType | pointerType ;

pointerType: varType '*' | 'struct' StrVar '*' | StrVar '*';

packcontent: content | ('{' content '}');

content : (stat|block) content | (stat|block) | ;

stat : declareStat | assignStat | breakStat | returnStat | freeStat | continueStat | (customFunc ';') | scanfStat | printfStat;

declareStat: (usualType StrVar |  varType arrayValue) ';';

assignStat: (usualType StrVar | StrVar | arrayValue | expr) '=' expr ';';

breakStat: 'break' ';';

returnStat: 'return' expr ';';

freeStat: 'free' '(' expr ')' ';';

continueStat: 'continue' ';';

scanfStat: 'scanf' '(' STRING (',' expr)+ ')' ';';

printfStat: 'printf' '(' STRING (',' expr)* ')' ';';

expr: (StrVar | INT | arrayValue | funcExpr | CHAR) |
 (StrVar | INT | arrayValue | funcExpr | CHAR) operator expr ;

arrayValue: StrVar '[' expr ']';

funcExpr:pre func| func;

pre: '(' (varType | StrVar '*') ')' ;

func: customFunc | mallocFunc ;

customFunc: StrVar '(' actualParams ')';

actualParams : actualParam | actualParam ',' actualParams |;

actualParam : expr ;

mallocFunc: 'malloc' '(' 'sizeof' '(' StrVar ')' ')';

block: whileBlock | ifBlock | elseBlock | elseifBlock;

ifBlock: 'if' '(' condition ')' packcontent;

whileBlock: 'while' '(' condition ')' packcontent;

elseBlock: 'else' packcontent;

elseifBlock: 'else if' '(' condition ')' packcontent;

condition: expr | '(' expr ')' logic condition | expr logic condition | condition logic condition | '(' condition ')';

logic: '&&' | '||';

StrVar : [a-zA-Z][a-zA-Z0-9_]*;

varType: 'int' | 'char' | 'struct';

INT: ('-')?[0-9]+;

operator: '+' | '-' | '*' | '/' | '==' | '!=' | '->' | '>' | '>=' | '<=' | '<' | '>';

CHAR : '\'' . '\'' ;

STRING : '"' .*? '"' ;

Comment
    :   '/*' .*? '*/'
        -> skip
    ;
//空白部分
WS
    :   [ \t\r\n]+
        -> skip
    ;
