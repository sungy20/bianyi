struct node{
    char c;
    int n;
};
int main(){
    struct node a;
    struct node * b = &a;
    b->n = 2;
    return 1;
}