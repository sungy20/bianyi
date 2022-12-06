int ptest(int* ptr1,int* ptr2){
    printf("ptr1:%x\n",ptr1);
    printf("ptr2:%x\n",ptr2);
    return 0;
}

int main(){

    int array[100];
    array[0] = 10;
    array[1] = 11;
    int* mptr = &array[0];
    printf("&asd[0]:%x\n", mptr);
    ptest(array,mptr);
    return 0;
}