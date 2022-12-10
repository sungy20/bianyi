int get(int e,int f){
    return e;
}

int main(){
    int b = 1;
    int* a = &b;
    printf("&b:%x\n",&b);
    printf("a:%x\n",a);
    int* c = a;
    printf("c:%x\n",c);
    if(b > 0) {
        b = b - 1;
    }
    else{
        b = b + 1;
    }
    while( b > 0 ){
        b = b - 1;
    }
    char str[100];
    int d = str[0];
    get(b,d);
    return 0;
}