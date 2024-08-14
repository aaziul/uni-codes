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

// função para calcular a Altura de uma árvore
int alturaArvore(pNodoA *a){
    int altEsq, altDir;
    
    if (a == NULL){ // se a igual a NULL
        return 0; // retorna 0
    } else{
        altEsq = alturaArvore(a->esq); // calcula a altura da arvore a esquerda
        altDir = alturaArvore(a->dir); // calcula a altura da arvore a direita

        if (altEsq > altDir){ // se altura da arvore a esquerda for maior que a altura da arvore a direita
            return altEsq + 1; // retorna a altura da arvore a esquerda + 1
        } else { // senão
            return altDir + 1; // retorna a altura da arvore a direita + 1
        }
    }
}

// função para calcular o fator de balanceamento de uma árvore
int fatorBalanceamento(pNodoA *a){
    int altEsq, altDir;

    if (a == NULL){ // se info atual for igual a NULL
        return 0; // retorna 0
    } else{ // senão
        altEsq = alturaArvore(a->esq); // calcula a altura da arvore a esquerda
        altDir = alturaArvore(a->dir); // calcula a altura da arvore a direita

        return altEsq - altDir; // retorna a subtracao da altura da arvore a esquerda menos a altura da arvore a direita
    }
}
