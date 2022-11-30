
/*#pragma warning(disable:4996)*/
int huiwen(char* str) {
	printf("%s\n",str);
	int i = 0;  /*length of str*/
	int k = 0;  /* 0 no 1 yes */
	while (1) {
		if (str[i] == 0) break;
		i = i + 1;
	}
	if (i / 2 * 2 == i) {
		int j = 0;
		while (1) {
			if (str[j] != str[i - j - 1]) {
				return k;
			}
			if (j == i / 2) {
				k = 1;
				return k;
			}
			j = j + 1;
		}
	}
	else {
		int j = 0;
		while (1) {
			if (str[j] != str[i - j - 1]) {
				return k;
			}
			if (j == i / 2 - 1) {
				k = 1;
				return k;
			}
			j = j + 1;
		}
	}
	return k;
}

int main() {
	char str[100];
	scanf("%s", str);
	printf("%s\n", str);
	int res = huiwen(str);
	if (res == 1) {
		printf("True\n");
	}
	else {
		printf("False\n");
	}
	return res;
}