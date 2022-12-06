int main() {
	int n;
	scanf("%d", &n);
	printf("n:%d\n", n);
	int i = 0;
	int array[100];
	printf("array:%d\n", array);
	while (i < n - 1) {
		scanf("%d,", &array[i]);
		i = i + 1;
	}
	scanf("%d", &array[n - 1]);
	int* arrayheadptr = array;


    printf("&array:%d\n", &array);
    printf("array:%d\n",array);
	printf("&arrayheadptr:%d\n", &arrayheadptr);
    printf("arrayheadptr:%d\n",arrayheadptr);
	printf("&arrayheadptr[n - 1]:%d\n", &arrayheadptr[n - 1]);
    printf("arrayheadptr[n - 1]:%d\n", arrayheadptr[n - 1]);
	return 0;
}
