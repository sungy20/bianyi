#include <stdio.h>
#include <stdlib.h>
int EmptyStack(int* c)
{
	if (c[0] == 0) return 1;
	return 0;
}

int Push(int* SS, int* cc, int e)
{
	int indexone = cc[0];
	SS[indexone] = e;
	cc[0] = cc[0] + 1;

	return 1;
}

int GetTop(int* SSS, int* ccc)
{
	int indextwo = ccc[0];
	indextwo = indextwo - 1;
	int retval = SSS[indextwo];

	return retval;
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

int Pop(int* SSSS, int* cccc)
{
	int ee;
	cccc[0] = cccc[0] - 1;
	int indexthree = cccc[0];
	ee = SSSS[indexthree];

	return ee;
}

int cal(char* aa) {
	int num[200];
	int opt[100];
	int count[1];
	int counts[1];
	int i = 0;
	int tmp = 0;
	int j;
	int k;
	int top_num = 0;
	int character = aa[i];
	int optchar = 0;
	int middle = 0;
	count[0] = 0;
	counts[0] = 0;

	while ((aa[i] != 0 )|| (EmptyStack(counts) != 1))
	{
		if ((aa[i] >= '0') && (aa[i] <= '9'))
		{
			tmp = tmp * 10 + aa[i] - '0';
			i = i + 1;
			if ((aa[i] < '0') || (aa[i] > '9'))
			{
				Push(num, count, tmp);
				tmp = 0;
			}
		}
		else
		{
		    top_num = 0;
			character = aa[i];
			if(EmptyStack(counts)!=1){
				top_num = GetTop(opt, counts);
			}
			if ((EmptyStack(counts) == 1 ) || ((top_num == '(' ) && (character != ')')) ||
				(Priority(character) > Priority(top_num)))
			{
				Push(opt, counts, character);
				i = i + 1;
				continue;
			}

			if ((top_num == '(') && (character == ')'))
			{
				Pop(opt, counts);
				i = i + 1;
				continue;
			}

			if (((character == ')') && (top_num != '(')) || ((character == 0) && (EmptyStack(counts) != 1)) ||
				(Priority(character) <= Priority(top_num)))
			{
				optchar = Pop(opt, counts);
				if (optchar == '+'){
				    j = Pop(num, count);
					k = Pop(num, count);
					middle = j+k;
				    Push(num, count, middle);
				}
				if (optchar == '-') {
					j = Pop(num, count);
					k = Pop(num, count);
					middle = k-j;
					Push(num, count, middle);
				}
				if (optchar == '*'){
				    j = Pop(num, count);
					k = Pop(num, count);
					middle = j*k;
				    Push(num, count, middle);
				}
				if (optchar == '/') {
					j = Pop(num, count);
					k = Pop(num, count);
					middle = k/j;
					Push(num, count, middle);
				}
				continue;
			}
		}
	}
	int answer = Pop(num, count);
	return answer;
}

int main(){
    char a[100] = "15/3+2*(4-2)";
    printf("please key in string to be calculated:\n");
    printf("(make sure it's valid and there's no space in it)\n");
    scanf("%s", a);
    int t = cal(a);
    printf("answer: %d\n", t);
    return t;
}