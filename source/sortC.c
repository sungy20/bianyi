
/*#pragma warning(disable:4996)*/
int sort(int* asd,int n) {
	printf("%d\n", n);
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