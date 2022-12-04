struct OPRTstack{
	char *base;
	char *top;
	int stacksize;
};
struct NUMstack{
	int *base;
	int *top;
	int stacksize;
};
int createStack(struct OPRTstack*s)
{
	s->base=(char*)malloc(sizeof(char)*10);
	if(s->base == 0)return 0;
	s->top=s->base;
	s->stacksize=10;
	return 1;
}
int pop(struct OPRTstack *s,char *e)
{
	if(s->top==s->base)return 0;
	s->top--;
	*e=*(s->top);
	return 1;
}
int push(struct OPRTstack*s,char e)
{
	if(s->top-s->base>=s->stacksize)
	{
		s->base=(char*)realloc(s->base,sizeof(char)*(s->stacksize+5));
		if(s->base == 0)return 0;
		s->top=s->base+s->stacksize;
		s->stacksize+=5;

	}
	*(s->top)=e;
	s->top++;
}
int isEmpty(struct OPRTstack *s)
{
	if(s->top==s->base)return 1;
	else return 0;
}
char GetTop(struct OPRTstack *s)
{
	if(isEmpty(s) == 0)
	{
		char*temp=s->top;
		temp--;
		return *(temp);
	}
	else return '!'; 
}
void showStack(struct OPRTstack*s)
{
	if(isEmpty(s))return ;
	for(int i=0;i<s->top-s->base;i++)
	{
		printf("%c ",s->base[i]);
	}
	printf("  ");
}
int createStack(struct NUMstack*s)
{
	s->base=(int*)malloc(sizeof(int)*10);
	if(s->base == 0)return 0;
	s->top=s->base;
	s->stacksize=10;
	return 1;
}
int pop(struct NUMstack *s,int *e)
{
	if(s->top==s->base)return 0;
	s->top--;
	*e=*(s->top);
	return 1;
}
int push(struct NUMstack*s,int e)
{
	if(s->top-s->base>=s->stacksize)
	{
		s->base=(int*)realloc(s->base,sizeof(int)*(s->stacksize+5));
		if(s->base == 0)return 0;
		s->top=s->base+s->stacksize;
		s->stacksize+=5;

	}
	*(s->top)=e;
	s->top++;
}
int isEmpty(struct NUMstack *s)
{
	if(s->top==s->base)return 1;
	else return 0;
}
int GetTop(struct NUMstack *s)
{
	if(isEmpty(s) == 0)
	{
		int *temp=s->top;
		temp--;
		return *(temp);
	}
	else return -1; 
}
void showStack(struct NUMstack*s)
{
	if(isEmpty(s))return ;
	for(int i=0;i<s->top-s->base;i++)
	{
		printf("%f ",s->base[i]);
	}
	printf("  ");
}
int isOPRT(char c) 
{
	if(c=='+'||c=='-'||c=='*'||c=='/'||c=='('||c==')'||c=='#')return 1;
	else return 0;
}
char compare(char a,char b)
{
	if(a=='+')
	{
		if(b=='*'||b=='/'||b=='(') return '<';
		else return '>';
	}
	else if(a=='-')
	{
		if(b=='*'||b=='/'||b=='(') return '<';
		else return '>';
	}
	else if(a=='*')
	{
		if(b=='(')return '<';
		else return '>';
	}
	else if(a=='/')
	{
		if(b=='(')return '<';
		else return '>';
	}
	else if(a=='(')
	{
		if(b==')')return '=';
		else if(b=='#') return '!';
		else return '<';
	}
	else if(a==')')
	{
		if(b=='(')return '!';
		else return '>';

	}
	else if(a=='#')
	{
		if(b==')')return '!';
		if(b=='#')return '=';
		else return '<';
	}
}
int calculate(int left,int right, char operators)
{
	switch(operators)
	{
		case '+':
			return left+right;

		case '-':
			return 1.0*left-right;

		case '*':
			return left*right;

		case '/':
			return 1.0*left/right;
	}
}
int main()
{
	struct OPRTstack oprt;
	struct NUMstack  num;
	struct NUMstack temp;
	int build=0; 
	int index; 
	int complex=1; 
	char operators; 
	int left,right; 
	createStack(&num);
	createStack(&oprt);
	createStack(&temp);
	printf("键入运算表达式，以#结束\n");
	push(&oprt,'#');
	char c=getchar();
	int error=0; 
	while(c!='#'||GetTop(&oprt)!='#')
	{
		while(isOPRT(c) == 0)
		{
			push(&temp,c-'0');
			c=getchar();
		}
		while(isEmpty(&temp) == 0)
		{
			pop(&temp,&index);
			build+=(index*complex);
			complex*=10 ;

		}
		complex=1;
		if(build)push(&num,int(build)); 
		printf("\n运算符栈：");
		showStack(&oprt);
		printf("运算数栈：");
		showStack(&num); 
		build=0;

		if(isOPRT(c)) 
		{
			switch(compare(GetTop(&oprt),c)){
				case '<':
					push(&oprt,c);
					c=getchar();
					printf("\n运算符栈：");
					showStack(&oprt);
					printf("运算数栈：");
					showStack(&num);
					break;

				case '=':
					pop(&oprt,&operators);
					c=getchar();
					printf("\n运算符栈：");
					showStack(&oprt);
					printf("运算数栈：");
					showStack(&num);
					break;

				case '>':
					pop(&oprt,&operators);
					pop(&num,&right);
					pop(&num,&left);
					push(&num,calculate(left,right,operators)); 
					printf("\n运算符栈：");
					showStack(&oprt);
					printf("运算数栈：");
					showStack(&num);
					break;

				case '!':
					printf("Syntax Error!");
					error=1;
					break;
			}
		}
		if(error)break;
	}
	if(error == 0)printf("结果为：%f",GetTop(&num));
	return 0;
}
