
/*#pragma warning(disable:4996)*/
int huiwen(char *str) {
	return str[2];
}

int main() {
	char str[100] = "62321";
	int res = huiwen(str);
	return res;
}