#include <stdio.h>
#include <stdlib.h>
#include "data.h"
#include "data.c"

int main(){
    pNodoA *a = NULL;
    int valor = 0;

    a = insereArvore(a, 8);
    a = insereArvore(a, 4);
    a = insereArvore(a, 9);
    a = insereArvore(a, 2);
    a = insereArvore(a, 6);
    a = insereArvore(a, 1);
    
    printf("Quantidade de nodos: %d\n", contaNodos(a));

    imprimeArvore(a, 1);

    return 0;
}
