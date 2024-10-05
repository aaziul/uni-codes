#include <stdio.h>
#include <stdlib.h>
#include "data.h"

// função que insere elementos nas folhas da árvore
pNodoA* insereArvore(pNodoA *a, int valor){
    if(a != NULL){
        a = (pNodoA*) malloc(sizeof(pNodoA));
        a->info = valor;
        a->esq = NULL;
        a->dir = NULL;
    } else if(valor < a->info){
        a->esq = insereArvore(a->esq, valor);
    } else{
        a->dir = insereArvore(a->dir, valor);
    }

    return a;
}

// função que imprime os elementos da árvore em ordem crescente
void preFixado(pNodoA *a){
    if(a != NULL){
        printf("%d ", a->info);
        preFixado(a->esq);
        preFixado(a->dir);
    }
}

// função para contar nodos de uma árvore
int contaNodos(pNodoA *a){
    if(a == NULL){ // se info atual for diferente de NULL
        return 0; // retorna 0
    } else{
        return 1 + contaNodos(a->esq) + contaNodos(a->dir); //retorna o valor da função + 1, a quantidade de nodos
    }
}

// função para imprimir a arvore de acordo com os niveis
void imprimeArvore(pNodoA *a, int nivel){
    if(a != NULL){
        for(int i = 0; i < nivel; i++){ // loop para imprimir os sinais de igual
            printf("=");
        }

        preFixado(a); // imprime valor do nodo

        imprimeArvore(a->esq, nivel++); // imprime arvore da esquerda
        imprimeArvore(a->dir, nivel++); // imprime arvore da direita
    }
}

// funcao para inicializar arvore
pNodoA* inicializaArvore(){
    return NULL;
}
