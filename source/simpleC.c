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

	Node* p = (Node*)malloc(sizeof(Node));
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
	Node * temp = S->top;
	return temp->data;
}

int Priority(char ch)
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
			if ((EmptyStack(opt) == 1 ) || (GetTop(opt) == '(' ) && (a[i] != ')') ||
				(Priority(a[i]) > Priority(GetTop(opt))))
			{
				Push(opt, a[i]);
				i = i + 1;
				continue;
			}

			if ((GetTop(opt) == '(') && (a[i] == ')'))
			{
				Pop(opt);
				i = i + 1;
				continue;
			}

			if (((a[i] == ')') && (GetTop(opt) != '(')) || ((a[i] == 0) && (EmptyStack(opt) != 1)) ||
				(Priority(a[i]) <= Priority(GetTop(opt))))
			{
				char optchar = Pop(opt);
				if (optchar == '+')Push(num, Pop(num) + Pop(num));
				if (optchar == '-') {
					j = Pop(num);
					Push(num, Pop(num) - j);
				}
				if (optchar == '*')Push(num, Pop(num) * Pop(num));
				if (optchar == '/') {
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