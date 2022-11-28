
/*#pragma warning(disable:4996)*/
int main() {
	int asd[10];
	asd[0] = 5;
	asd[1] = 8;
	asd[2] = 4;
	asd[3] = 9;
	int n = 4;
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
	return asd[3];
}

/*int main() {
	char str[100] = "12321";
	int res = huiwen(str);
	return res;
}*/