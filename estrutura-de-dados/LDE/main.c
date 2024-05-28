#include <stdio.h>
#include <stdlib.h>
#include "data.h"
#include "data.c"

int main(){
    PtProd* PtLista;
    Produto prod;

    PtLista = inicializa();

    for(int i = 0; i < 4; i++){
        printf("Codigo: ");
        scanf("%d", &prod.codigo);

        printf("Nome: ");
        scanf("%s", &prod.nome);

        printf("Preco: ");
        scanf("%f", &prod.preco);

        PtLista = insere(PtLista, prod);
    }

    imprime(PtLista);
    imprimeInvertida(PtLista);

    return 0;
}
