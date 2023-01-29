# COSC 5360 Homework Assignment 2

---
### Author: Edward Ward III
### Submitted: Sunday, 29 January 2023

## Task 1

---

Compiled and executed the author's `badkeygenerator.c` file.

```C
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define KEYSIZE 16

int main()
{
    int i;
    char key[KEYSIZE];

    printf("%lld\n", (long long) time(NULL));
    srand(time(NULL));

    for (i = 0; i < KEYSIZE; i++)
    {
        key[i] = rand()%256;
        printf("%.2x", (unsigned char)key[i]);
    }
    printf("\n");
}
```

```Bash
gcc badkeygenerator.c -o badkeygenerator.bin
./badkeygenerator.bin
```

Executed multiple time and as suspected, the generated key is different with each execution because the seed is different.

![Code execution with srand enabled](task1srandenabled.png)

Commenting out `srand`, compiling, and executing, we should expect to see the same key multiple times since the `srand`seed is not changing:

```C
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define KEYSIZE 16

int main()
{
    int i;
    char key[KEYSIZE];

    printf("%lld\n", (long long) time(NULL));
    // srand(time(NULL));

    for (i = 0; i < KEYSIZE; i++)
    {
        key[i] = rand()%256;
        printf("%.2x", (unsigned char)key[i]);
    }
    printf("\n");
}
```

```Bash
gcc badkeygenerator.c -o badkeygenerator.bin
./badkeygenerator.bin
```

![Code execution with srand commented out](task1sranddisabled.png)

## Task 2

---
The saved file's epoch `2018-04-17 23:08:49` is `1524006529`. Since we assume the key was generated within the previous two hours of the file being saved, we need keys for every second between `2018-04-17 21:08:49` and the saved file's epoch.

File saved:
```Bash
date -d "2018-04-17 23:08:49" +%s
1524006529
```

Start search:
```Bash
date -d "2018-04-17 21:08:49" +%s
1523999329
```

I modified the author's key generation file to generate keys for every second between when we should start our search and when the file was saved.

```C
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
```

Compiling new bad key generator `modbadkeygenerator.c`, executing, and exporting to key file:

```Bash
gcc modbadkeygenerator.c -o modbadkeygenerator.bin
./modbadkeygenerator.bin > keys.txt
```

Checking `keys.txt` to verify the keys were exported properly:
```Bash
head -10 keys.txt
8dfa318cb2fbcaf11635475163586d90
678e3799dbdda8d33a9546e2f251b537
4dd733c6bc3d355ca2f90c4811d2960c
da2e54915f7a4b09b0b72efd41eb51c5
d2d785ab9fd5aa891c3e354e66ef73d8
7c447867b364d68193447f63c89ff69a
cb2f5a825bce6c2a30c02f935abefbe0
c9f823aa903991a6767c1b8d28923881
fb7cea57e9285240d7fa98431aef9896
0a298a7495904df832004cc934bd8bff
```

Brute force to crack the key:

```Python

```
## Task 3

## Task 4
