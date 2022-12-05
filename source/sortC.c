
/*#pragma warning(disable:4996)*/
int sort(int* asd,int s_n) {
	printf("asd:%d\n", asd);
	int ii = 0;
	while (ii < s_n - 1) {
		printf("%d,", asd[ii]);
		ii = ii + 1;
	}
	printf("%d\n", asd[s_n - 1]);
	int i = 0;
	while (i < s_n - 1) {
		int j = i + 1;
		while (j < s_n) {
			if (asd[i] > asd[j]) {
				int temp = asd[i];
				asd[i] = asd[j];
				asd[j] = temp;
			}
			j = j + 1;
		}
		i = i + 1;
	}
	i = 0;
	while (i < s_n - 1) {
		printf("%d,", asd[i]);
		i = i + 1;
	}
	printf("%d\n", asd[s_n - 1]);
	return 0;
}

int all_sort(int* asd,int n){

	sort(asd, n);
	int i = 0;
	while (i < n - 1) {
		printf("%d,", asd[i]);
		i = i + 1;
	}
	printf("%d\n", asd[n - 1]);
	printf("asd:%d\n", asd);
	return 0;
}
int main() {
	int n;
	scanf("%d", &n);
	printf("n:%d\n", n);
	int i = 0;
	int asd[100];
	printf("asd:%d\n", asd);
	while (i < n - 1) {
		scanf("%d,", asd[i]);
		i = i + 1;
	}
	scanf("%d", asd[n - 1]);
	all_sort(asd,n);
	printf("asd:%d\n", asd);
	int* asdhead = asd;
	printf("asdhead:%d\n", asd);
	i = 0;
	while (i < n - 1) {
		printf("%d,", asdhead[i]);
		i = i + 1;
	}
	printf("%d\n", asdhead[n - 1]);
	return 0;
}


/*
int main() {
	int n;
	scanf("%d", &n);
	printf("%d\n", n);
	int i = 0;
	int asd[100];
	while (i < n - 1) {
		scanf("%d,", &asd[i]);
		i = i + 1;
	}
	scanf("%d", &asd[n - 1]);
	sort(asd, n);
	i = 0;
	while (i < n - 1) {
		printf("%d,", asd[i]);
		i = i + 1;
	}
	printf("%d", asd[n - 1]);
	int i = 0;
	while (i < n - 1) {
		int j = i + 1;
		while (j < n) {
			if (asd[i] > asd[j]) {
				int temp = asd[i];
				asd[i] = asd[j];
				asd[j] = temp;
			}
			j = j + 1;
		}
		i = i + 1;
	}
	return 0;
}


*/