#include<stdio.h>
#include<string.h>
#include<stdlib.h>
/*#pragma warning(disable:4996)*/

struct Node
{
	int data;
	struct Node* next;
};

struct LinkStack
{
	Node* top;
	int count;
};

int huiwen(char* str) {
	int i = 0;  /*length of str*/
	int k = 0;  /* 0 no 1 yes */
	while (1) {
		if (str[i] == 0) break;
		i = i + 1;
	}
	if (i / 2 * 2 == i) {
		int j = 0;
		while (1) {
			if (str[j] != str[i - j - 1]) {
				return k;
			}
			if (j == i / 2 - 1) {
				k = 1;
				return k;
			}
			j = j + 1;
		}
	}
	else {
		int j = 0;
		while (1) {
			if (str[j] != str[i - j - 1]) {
				return k;
			}
			if (j == i / 2 - 1) {
				k = 1;
				return k;
			}
			j = j + 1;
		}
	}
}

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
	return S->top->data;
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

	num = (LinkStack*)malloc(sizeof(LinkStack));
	if (num == 0)
	{
		return -1;
	}

	num->top = 0;
	num->count = 0;

	opt = (LinkStack*)malloc(sizeof(LinkStack));
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
/*https://blog.csdn.net/xiaopengX6/article/details/104710787*/

int main() {
	char str[100];
	char mode[10]; /*huiwen or cal*/
	scanf("%s%s", str, mode);
	if (mode[0] == 'h') {
		int result = huiwen(str);
		if (result == 0)printf("False");
		else printf("True");
	}
	else {
		int result = cal(str);
		printf("%d", result);
	}
	return 0;
}