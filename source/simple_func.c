
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
	printf("res = %s\n", res);
	char* test = res;
	return get(test);
}