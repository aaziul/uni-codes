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
    TipoFila *ant; //ponteiro auxiliar para a posição anterior 
    TipoFila *ptaux; //ponteiro auxiliar para percorrer a lista 

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
    if (ant == NULL){ /*o anterior n o existe, logo o elemento ser  inserido na primeira posi  o*/
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
    } else return -1;
}

void imprimeFila(TipoFila* l){
    TipoFila* ptaux;
    for (ptaux=l; ptaux!=NULL; ptaux=ptaux->prox)
        printf(" %d \n",ptaux->info);
}

// funcao que faz a busca em profundidade - Depth FFirst Search
void DFS(int matrizAdj[8][8], int vertice, int visitado[]){
    visitado[vertice] = 1; // inicializa o vertice como visitado

    printf("%d ", vertice); // imprime o vertice

    for(int i = 0; i < 8; i++){ // para cada vertice adjacente faca
        if((matrizAdj[vertice][i] == 1)&&(visitado[i] == 0)){ // se vertice for adjacente e nao visitado
            DFS(matrizAdj, i, visitado); // entao faca a busca em profundidade
        }
    }
}

// funcao que faz a busca em largura - Breadth First Search
void BFS(int grafo[8][8], int vertice){
    int visitado[8] = {0}; // inicializa o vetor de visitados
    TipoFila* fila = criaFila(); // cria uma fila

    visitado[vertice] = 1; // marca o vertice visitado de inicio
    fila = insereFila(fila, vertice); // insere o vertice na fila

    while(fila != NULL){ // enquanto fila nao estiver vazia
        vertice = removeFila(&fila); // retira o primeiro elemento da fila

        printf("%d ", vertice); // imprime o vertice

        for(int i = 0; i < 8; i++){ // para cada vertice adjacente faca
            if((grafo[vertice][i] == 1)&&(visitado[i] == 0)){ // se vertice for adjacente e nao visitado
                fila = insereFila(fila, i); // entao insere o vertice na fila
                visitado[i] = 1; // marca o vertice como visitado
            }
        }
    }
}

