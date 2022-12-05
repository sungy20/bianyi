int main(){
    int t = 1;
    int * k = &t;
    t = t + 1;
    return *k;
}