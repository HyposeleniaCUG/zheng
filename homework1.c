//题目：输入一个整数，表示分钟数，输出对应的小时和分钟数。例如输入130，输出2小时10分钟。
#include <stdio.h>
void main()
{
    int a, b, c;
    scanf("%d", &a);
    b=a/60;
    c= a%60;
    printf("%d(m)= %d(h):%d(m)",a, b, c);
}