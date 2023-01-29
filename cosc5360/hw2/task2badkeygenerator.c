//
// Created by Edward Ward on 1/28/23.
//
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define KEYSIZE 16

int main(int argc, char *argv[] )
{
    if (argc < 2)
    {
        exit(1); // need to provide a valid linux epoch time
    }

    int i;
    char key[KEYSIZE];
    unsigned long long seed = strtoll(argv[1], NULL, 10);
    srand(seed);

    for (i = 0; i < KEYSIZE; i++)
    {
        key[i] = rand()%256;
        printf("%.2x", (unsigned char)key[i]);
    }
}