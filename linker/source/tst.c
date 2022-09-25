int main() {
    int a=10;
    int b=2;
    int c=0x8C000000;
   int* ptr_c = (int*)(c);
    *ptr_c = a+b;
    return 0;
}