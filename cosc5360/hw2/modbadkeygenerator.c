#include <stdio.h>
#include <stdlib.h>

#define KEYSIZE 16

int main()
{
    int i;
    char key[KEYSIZE];

    // generate key for each second for the two hours prior to when the file
    // was saved and output the results into a key file
    for (unsigned long long t = 1523999329; t < 1524006529; t++)
    {
        srand(t);

        for (i = 0; i < KEYSIZE; i++)
        {
            key[i] = rand()%256;
            printf("%.2x", (unsigned char)key[i]);
        }
        printf("\n");
    }
}