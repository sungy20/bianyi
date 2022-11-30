
/*#pragma warning(disable:4996)*/
int main() {
	int n;
	scanf("%d", n);
	int i = 0;
	int asd[100];
	while (i < n-1) {
		scanf("%d,", asd[i]);
	}
	scanf("%d", asd[n - 1]);
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
	i = 0;
	while (i < n - 1) {
		printf("%d,", asd[i]);
	}
	printf("%d", asd[n - 1]);
	return asd[3];
}

/*int main() {
	char str[100] = "12321";
	int res = huiwen(str);
	return res;
}*/