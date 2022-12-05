/*#pragma warning(disable:4996)*/
int print(int * p_asd,int p_n){
	int pi = 0;
	while (pi < p_n - 1) {
		printf("%d,", p_asd[pi]);
		pi = pi + 1;
	}
	printf("%d\n", p_asd[p_n - 1]);
	return 0;
}
int change(int* casd,int cs_n) {
	
	print(casd,cs_n);
	casd[2] = 101;
	printf("--------change change asd[2]:%x;n:%d\n", casd,cs_n);
	print(casd,cs_n);
	
	return 0;
}


int sort(int* asd,int s_n) {
	printf("=================in sort asd:%x;n:%d\n", asd,s_n);
	print(asd,s_n);
	asd[1] = 10;
	printf("=================sort change asd[1]:%x;n:%d\n", asd,s_n);
	print(asd,s_n);
	change(asd,s_n);
	
	printf("=================out change int sort asd:%x;n:%d\n", asd,s_n);
	print(asd,s_n);
	return 0;
}

int main() {
	int n;
	scanf("%d", &n);
	printf("n:%xd\n", n);
	int i = 0;
	int asd[100];
	int* ptr = &asd[0];
	printf("&asd[0]:%x\n", ptr);

	while (i < n - 1) {
		scanf("%d,", asd[i]);
		i = i + 1;
	}
	scanf("%d", asd[n - 1]);
	print(asd,n);
	sort(asd, n);
	print(asd,n);
	printf("&asd[0]:%x\n", ptr);
	return 0;
}