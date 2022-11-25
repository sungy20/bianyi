
/*#pragma warning(disable:4996)*/
int main() {
	char str[100] = "12321";
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
			if (j == i / 2 - 1) {
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
				k = 0;
			}
			if (j == i / 2 - 1) {
				k = 1;
				return k;
			}
			j = j + 1;
		}
	}
	return 0;
}

/*int main() {
	char str[100] = "12321";
	int res = huiwen(str);
	return res;
}*/