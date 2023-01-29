#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define KEYSIZE 16

int main()
{
    int i;
    char key[KEYSIZE];

    // generate key for each second for the two hours prior to when the file
    // was saved and output the results into a key file
    for (time_t t = 1524020929 - 60 * 60 * 2; t < 1524020929; t++)
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