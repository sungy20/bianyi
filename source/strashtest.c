struct Node
{
	int data;
	Node* next;
};

struct LinkStack
{
	Node* top;
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
    LinkStack* num = (LinkStack*)malloc(sizeof(LinkStack));
    Push(num, 1213);
    Push(num, 1213);
    return 0;
}