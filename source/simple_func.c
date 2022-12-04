
/*#pragma warning(disable:4996)*/
/**/
int repeat(char* i,int kj){
	return i[kj];
}

int get(char* j){
	printf("%s\n",j);
	return repeat(j,2);
}

int main(){
    
	char res[100] = "048250";
	int p_i = 0;
	while (p_i < 5)
	{
		printf("res[%d] = %c\n", p_i, res[p_i]);
        p_i = p_i + 1;
	}
	printf("res = %s\n", res);
	char* test = res;
	return get(test);
}