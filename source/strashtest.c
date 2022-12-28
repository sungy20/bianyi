int add_one(int * a)
{
    a[0] = a[0] + 1;
    int t = a[0];
    return t;
}

int main()
{
    int aa[100];
    aa[0] = 1;
    add_one(aa);
    int tt = aa[0];
    return tt;
}