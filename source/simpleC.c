struct Node
{
	int data;
	struct Node* next;
};

struct LinkStack
{
	struct Node* top;
	int count;
};

int EmptyStack(LinkStack* S)
{
	if (S->count == 0) return 1;
	return 0;
}

int Push(LinkStack* S, int e)
{
	Node* p = (Node*)malloc(sizeof(Node));
	p->data = e;
	p->next = S->top;
	S->top = p;
	S->count = S->count + 1;

	return 1;
}

int GetTop(LinkStack* S)
{
	Node * temp = S->top;
	return temp->data;
}

int Priority(int ch)
{
    int retval = 0;
	if (ch == '(')retval = 3;
	if (ch == '*')retval = 2;
	if (ch == '/')retval = 2;
	if (ch == '+')retval = 1;
	if (ch == '-')retval = 1;
	return retval;
}

int Pop(LinkStack* S)
{
	int e;

	Node* p = S->top;
	e = p->data;
	S->top = p->next;
	free(p);
	S->count = S->count - 1;

	return e;
}

int cal(char* a) {
	LinkStack* num;
	LinkStack* opt;
	int i = 0;
	int tmp = 0;
	int j;
	int k;

	num = (LinkStack*)malloc(sizeof(LinkStack));
	num->count = 0;

	opt = (LinkStack*)malloc(sizeof(LinkStack));
	opt->count = 0;

	while ((a[i] != 0 )|| (EmptyStack(opt) != 1))
	{
		if ((a[i] >= '0') && (a[i] <= '9'))
		{
			tmp = tmp * 10 + a[i] - '0';
			i = i + 1;
			if ((a[i] < '0') || (a[i] > '9'))
			{
				Push(num, tmp);
				tmp = 0;
			}
		}
		else
		{
		    int top_num = 0;
			int character = a[i];
			if(EmptyStack(opt)!=1){
				top_num = GetTop(opt);
			}
			if ((EmptyStack(opt) == 1 ) || (top_num == '(' ) && (character != ')') ||
				(Priority(character) > Priority(top_num)))
			{
				Push(opt, character);
				i = i + 1;
				continue;
			}

			if ((top_num == '(') && (character == ')'))
			{
				Pop(opt);
				i = i + 1;
				continue;
			}

			if (((a[i] == ')') && (top_num != '(')) || ((character == 0) && (EmptyStack(opt) != 1)) ||
				(Priority(character) <= Priority(top_num)))
			{
				int optchar = Pop(opt);
				if (optchar == '+')Push(num, Pop(num) + Pop(num));
				if (optchar == '-') {
					j = Pop(num);
					k = Pop(num) - j;
					Push(num, k);
				}
				if (optchar == '*')Push(num, Pop(num) * Pop(num));
				if (optchar == '/') {
					j = Pop(num);
					k = Pop(num) / j;
					Push(num, k);
				}
				continue;
			}
		}
	}
	return Pop(num);
}

int main(){
    char a[100] = "15/3+2*(4-2)";
    int t = cal(a);
    return t;
}