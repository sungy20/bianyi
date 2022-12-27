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

int Push(LinkStack* SS, int e)
{
	Node* p = (Node*)malloc(sizeof(Node));
	p->data = e;
	p->next = SS->top;
	SS->top = p;
	SS->count = SS->count + 1;

	return 1;
}

int GetTop(LinkStack* SSS)
{
	Node * temp = SSS->top;
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

int Pop(LinkStack* SSSS)
{
	int ee;

	Node* pp = SSSS->top;
	ee = pp->data;
	SSSS->top = pp->next;
	free(pp);
	SSSS->count = SSSS->count - 1;

	return ee;
}

int main(){
    char a[100] = "1+1";
    int t;
	LinkStack* num = (LinkStack*)malloc(sizeof(LinkStack));
	LinkStack* opt = (LinkStack*)malloc(sizeof(LinkStack));
	Node* middle;
	int i = 0;
	int tmp = 0;
	int j;
	int k;
	int top_num = 0;
	int character = a[i];
	int optchar = 0;
	int calnum;

	num->count = 0;
	opt->count = 0;

	while ((a[i] != 0 ) || (opt->count != 0))
	{
		if ((a[i] >= '0') && (a[i] <= '9'))
		{
			tmp = tmp * 10 + a[i] - '0';
			i = i + 1;
			if ((a[i] < '0') || (a[i] > '9'))
			{
				Node* p = (Node*)malloc(sizeof(Node));
	            p->data = tmp;
	            p->next = num->top;
	            num->top = p;
	            num->count = num->count + 1;
				tmp = 0;
			}
		}
		else
		{
		    top_num = 0;
			character = a[i];
			if(opt->count != 0){
			    middle = opt->top;
				top_num = middle->data;
			}
			if ((opt->count == 0) || ((top_num == '(' ) && (character != ')')) ||
				(Priority(character) > Priority(top_num)))
			{
			    Node* p = (Node*)malloc(sizeof(Node));
	            p->data = character;
	            p->next = opt->top;
	            opt->top = p;
	            opt->count = opt->count + 1;

				i = i + 1;
				continue;
			}

			if ((top_num == '(') && (character == ')'))
			{
			    Node* pp = opt->top;
	            opt->top = pp->next;
	            free(pp);
	            opt->count = opt->count - 1;

				i = i + 1;
				continue;
			}

			if (((character == ')') && (top_num != '(')) || ((character == 0) && (opt->count != 0)) ||
				(Priority(character) <= Priority(top_num)))
			{
			    Node* pp = opt->top;
	            opt->top = pp->next;
	            free(pp);
	            opt->count = opt->count - 1;
				optchar = pp->data;

                pp = opt->top;
	            opt->top = pp->next;
	            free(pp);
	            opt->count = opt->count - 1;
				j = pp->data;

				pp = opt->top;
	            opt->top = pp->next;
	            free(pp);
	            opt->count = opt->count - 1;
				k = pp->data;

				if (optchar == '+'){
				    calnum = j+k;
				}
				if (optchar == '-'){
				    calnum = k-j;
				}
				if (optchar == '*'){
				    calnum = k*j;
				}
				if (optchar == '/'){
				    calnum = k/j;
				}

                Node* p = (Node*)malloc(sizeof(Node));
	            p->data = calnum;
	            p->next = num->top;
	            num->top = p;
	            num->count = num->count + 1;

				continue;
			}
		}
	}
	Node* ppp = num->top;
	num->top = ppp->next;
	free(ppp);
	num->count = num->count - 1;
    return ppp->data;
}