#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define KEYSIZE 16

void main()
{
    int i;
    char key[KEYSIZE];

    printf("%lld\n", (long long) time(NULL));
    srand (time(NULL));

    for (i = 0)
}