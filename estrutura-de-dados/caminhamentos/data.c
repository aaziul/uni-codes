#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <stdlib.h> //necessaria para o malloc
#include "data.h"

TipoFila* criaFila(void){
    return NULL;
}

TipoFila* insereFila(TipoFila *l, int dado){
    TipoFila *novo; //novo elemento
    TipoFila *ant = NULL; //ponteiro auxiliar para a posi��o anterior
    TipoFila *ptaux = l; //ponteiro auxiliar para percorrer a lista

    /*aloca um novo nodo */
    novo = (TipoFila*) malloc(sizeof(TipoFila));

    /*insere a informação no novo nodo*/
    novo->info = dado;
    novo->prox = NULL;

    /*achando o final da fila*/
    while (ptaux!=NULL){
        ant = ptaux;
        ptaux = ptaux->prox;
    }

    /*encaeia o elemento*/
    if (ant == NULL) {/*o anterior nao existe, logo o elemento sera inserido na primeira posicao*/
        novo->prox = l;
        l = novo;
    }else
        ant->prox = novo;

    return l;
}

int vazia(TipoFila* l){
    if (l == NULL) return 1;
    else return 0;
}


int removeFila(TipoFila **l){
    TipoFila *rem = *l;
    int aux;

    if (!vazia(*l)){
        aux = (*l)->info;
        *l = (*l)->prox;
        free(rem);
        return (aux);
    }
    else return -1;
}

void imprimeFila(TipoFila* l)
{
    TipoFila* ptaux;
    for (ptaux=l; ptaux!=NULL; ptaux=ptaux->prox)
        printf(" %d \n",ptaux->info);
}

void DFS(int matrizAdj[8][8], int vertice, int visitado[]){
    visitado[vertice] = 1;
    printf("%d ", vertice);
    for(int i = 0; i < 8; i++){
        if((matrizAdj[vertice][i] == 1)&&(visitado[i] == 0)){
                DFS(matrizAdj, i, visitado);
        }
    }
}

void BFS(int grafo[8][8], int vertice){
    int visitado[8] = {0};
    TipoFila* fila = criaFila();

    visitado[vertice] = 1;
    fila = insereFila(fila, vertice);

    while(fila != NULL){
        vertice = removeFila(&fila);
        printf("%d ", vertice);
        for(int i = 0; i < 8; i++){
            if((grafo[vertice][i] == 1)&&(visitado[i] == 0)){
                fila = insereFila(fila, i);
                visitado[i] = 1;
            }
        }
    }
}
