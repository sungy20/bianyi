#include <stdio.h>
#include <stdlib.h>

struct Node{
    int c;
    char* n;
};

int read_num(Node* y)
{
    char* middle_pointer = y->n;
    int middle_number = middle_pointer[0];
    y->c = middle_number;
    return 1;
}

int main(){
	char j[5];
    printf("please key in a character:\n");
    scanf("%s", &j);

    /* tests for reference */
    printf("address that this character is stored in: %d\n", j);
	printf("its reference address: %d\n", &j);

    /* tests for structs */
	Node* tmp = (Node*)malloc(sizeof(Node));
	tmp->n = &j;
	read_num(tmp);
	int answer = tmp->c;
    printf("after it's stored in a struct, we calculated the ASCII for this character: %d\n", answer);

    return 0;
}