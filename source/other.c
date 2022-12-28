#include <stdio.h>
#include <stdlib.h>

struct Node{
    int c;
    int* n;
};

int read_num(Node* y)
{
    int* middle_pointer = y->n;
    int middle_number = middle_pointer[0];
    y->c = middle_number;
    return 1;
}

int main(){
	int j;
    printf("please key in a number\n");
    scanf("%d", &j);

    /* tests for reference */
	printf("address that this number is stored in: %d\n", &j);
	int * i = &j;
	int k = i[0];
	printf("value in this address: %d\n", k);

	/* tests for structs */
	Node* tmp = (Node*)malloc(sizeof(Node));
	tmp->n = i;
	read_num(tmp);
	int answer = tmp->c;
    printf("after it's stored in a struct it's: %d\n", answer);

    return 0;
}