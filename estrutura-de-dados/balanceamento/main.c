/*Objetivo: Implementar algoritmos para calcular o fator balanceamento de uma árvore binária*/

#include <stdio.h>
#include <stdlib.h>
#include "data.c"

int main(){
    pNodoA *a = NULL;

    a = insereArvore(a, 12);
    a = insereArvore(a, 20);
    a = insereArvore(a, 18);
    a = insereArvore(a, 14);
    a = insereArvore(a, 19);

    imprimeArvore(a, 1);

    printf("Fator balanceamento: %d\n", fatorBalanceamento(a));

    return 0;
}
