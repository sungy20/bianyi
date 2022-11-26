
/*#pragma warning(disable:4996)*/
int huiwen(char *str) {
	return str[4];
}

int main() {
	char str[100] = "12321";
	int res = huiwen(str);
	return res;
}