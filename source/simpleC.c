
/*#pragma warning(disable:4996)*/

int huiwen(char *str) {
	return str[2];
}

int main() {
    char i[100] = "asdasd";
    int asd = 111415;
    int res = huiwen(i);
    printf("i[100]:%s;\nasd:%d;\nres:%d;\n",i,asd,res);
    return res;
}