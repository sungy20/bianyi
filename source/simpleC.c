
/*#pragma warning(disable:4996)*/


int main() {
    int k = 1;
    char i[333] = "1234";
    if (1) {
        if (1) {
            k = i[2];
        }
        k = i[3];
    }
    k = i[0];
	return k;
}