#include <stdio.h>
#include <stdlib.h>
#include "data.h"

/*inicializa lista*/
PtProd* inicializa(){
    return NULL;
}

/*imprime lista*/
void imprime(PtProd* ptLista){
    PtProd* ptaux;
    if(ptLista == NULL){
        puts("Lista vazia!");
    } else{
        for(ptaux = ptLista; ptaux != NULL; ptaux = ptaux->prox){
            printf("Codigo = %d | Nome = %s | Preco = %f\n", ptaux->prod.codigo, ptaux->prod.nome, ptaux->prod.preco);
        }
    }
}

/*insere produto e ordena a lista*/
PtProd* insere (PtProd* ptLista, Produto dados){
    PtProd *novo;
    PtProd *ant = NULL; //ponteiro auxiliar para a posição anterior
    PtProd *ptaux = ptLista; //ponteiro auxiliar para percorrer a lista

    novo = (PtProd*) malloc(sizeof(PtProd));
    novo->prod = dados;

    /*procura o elemento na lista*/
    while (ptaux != NULL && ptaux->prod.codigo < novo->prod.codigo){
        ant = ptaux;
        ptaux = ptaux->prox;
    }

    novo->prox = ptaux;

    if (ant){
        ant->prox = novo;
    } else {
        ptLista = novo;
    }

    return ptLista;
}
