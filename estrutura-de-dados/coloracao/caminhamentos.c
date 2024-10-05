#include <stdio.h>
#include <stdlib.h>
#include "caminhamentos.h"


void DFS (int grafo[max+1][max+1], int v, int vis[max+1]){
    int w;
    printf("%d\n",v);
    vis[v]= true;
    for(w = 1; w<=max ; w++)    //percorre os vértices adjacentes a v
      if ((grafo[v][w]== 1) && (vis[w]==false))  //encontra um vértice adjacente a v que ainda nao tenha sido visitado
         DFS(grafo, w, vis); //chamada recursiva para o vértice adjacente a v
}

void BFS (int grafo[max+1][max+1], int v, int vis[max+1]){
    int w;
    TipoFila *FV;

    FV = cria_fila();
    FV = insere(FV,v);
    vis[v]= true;
    while (!vazia(FV)){
        v = removeFila(&FV);
        printf("%d\n",v);
        for(w = 1; w<=max ; w++)    //percorre os vértices adjacentes a v
            if ((grafo[v][w]== 1) && (vis[w]==false)){  //encontra um vértice adjacente a v que ainda nao tenha sido visitado
                FV = insere(FV,w);
                vis[w]= true;
            }

    }
}

//utilizando o DFS para realizar a coloração de um grafo
void coloracaoDFS(int grafo[max+1][max+1], int v, int vis[max+1], int cor[max+1]){
    int w;
    int i;
    int corAtual = 1;
    TipoFila *FV;

    FV = cria_fila();
    FV = insere(FV,v);
    vis[v]= true;
    cor[v] = corAtual;
    while (!vazia(FV)){
        v = removeFila(&FV);
        for(w = 1; w<=max ; w++) //percorre os vértices adjacentes a v
            if ((grafo[v][w] == 1) && (vis[w] == false)){  //encontra um vértice adjacente a v que ainda nao tenha sido visitado
                FV = insere(FV,w);
                vis[w] = true;
                for (i = 1; i <= max; i++){
                    if (cor[i] == corAtual){
                        corAtual++;
                        break;
                    }
                }
                cor[w] = corAtual;
            }
    }
}

//utilizando o BFS para realizar a coloração de um grafo
void coloracaoBFS(int grafo[max+1][max+1], int v, int vis[max+1], int cor[max+1]){
    int w;
    int i;
    int corAtual = 1;
    TipoFila *FV;

    FV = cria_fila();
    FV = insere(FV,v);
    vis[v]= true;
    cor[v] = corAtual;
    while (!vazia(FV)){
        v = removeFila(&FV);
        for(w = 1; w<=max ; w++) //percorre os vértices adjacentes a v
            if ((grafo[v][w] == 1) && (vis[w] == false)){  //encontra um vértice adjacente a v que ainda nao tenha sido visitado
                FV = insere(FV,w);
                vis[w] = true;
                for (i = 1; i <= max; i++){
                    if (cor[i] == corAtual){
                        corAtual++;
                        break;
                    }
                }
                cor[w] = corAtual;
            }
    }
}
