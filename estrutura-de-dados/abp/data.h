#include <stdio.h>
#include <stdlib.h>

typedef struct TNodoA{
    int info;
    struct TNodoA *esq;
    struct TNodoA *dir;
} pNodoA;
