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
	if (S == 0)
	{
		return -1;
	}
	if (S->count == 0) return 1;
	else return -1;
}

int Push(LinkStack* S, int e)
{
	if (S == 0)
	{
		return -1;
	}

	Node* p = (Node*)malloc(8);
	if (p == 0)
	{
		return -1;
	}

	p->data = e;
	p->next = S->top;
	S->top = p;
	S->count = S->count + 1;

	return 1;
}

int GetTop(LinkStack* S)
{
	if (S->top == 0)
	{
		return -1;
	}
	return S->top->data;
}

int Priority(char ch)
{
	if (ch == '(')return 3;
	else if (ch == '*')return 2;
	else if (ch == '/')return 2;
	else if (ch == '+')return 1;
	else if (ch == '-')return 1;
	else return 0;
}

int Pop(LinkStack* S)
{
	int e;

	if (S->top == 0)
	{
		return -1;
	}

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

	num = (LinkStack*)malloc(8);
	if (num == 0)
	{
		return -1;
	}

	num->top = 0;
	num->count = 0;

	opt = (LinkStack*)malloc(8);
	if (opt == 0)
	{
		return -1;
	}

	opt->top = 0;
	opt->count = 0;

	while (a[i] != 0 || EmptyStack(opt) != 1)
	{
		if (a[i] >= '0' && a[i] <= '9')
		{
			tmp = tmp * 10 + a[i] - '0';
			i = i + 1;
			if (a[i] < '0' || a[i] > '9')
			{
				Push(num, tmp);
				tmp = 0;
			}
		}
		else
		{
			if (EmptyStack(opt) == 1 || GetTop(opt) == '(' && a[i] != ')' ||
				Priority(a[i]) > Priority(GetTop(opt)))
			{
				Push(opt, a[i]);
				i = i + 1;
				continue;
			}

			if (GetTop(opt) == '(' && a[i] == ')')
			{
				Pop(opt);
				i = i + 1;
				continue;
			}

			if ((a[i] == ')' && GetTop(opt) != '(') || (a[i] == 0 && EmptyStack(opt) != 1) ||
				Priority(a[i]) <= Priority(GetTop(opt)))
			{
				char optchar = Pop(opt);
				if (optchar == '+')Push(num, Pop(num) + Pop(num));
				else if (optchar == '-') {
					j = Pop(num);
					Push(num, Pop(num) - j);
				}
				else if (optchar == '*')Push(num, Pop(num) * Pop(num));
				else if (optchar == '/') {
					j = Pop(num);
					Push(num, Pop(num) / j);
				}
				continue;
			}
		}
	}
	return Pop(num);
}

int main(){
    char a[100] = "15/3+2*(4-2)";
    return cal(a);
}