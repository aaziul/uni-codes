#include "caminhamentos.h"
#include <string.h>
#include <locale.h>

int main(){
    setlocale(LC_ALL, "Portuguese");
    int i,j;
    int grafo[max+1][max+1];
    int vis[max+1];
    TipoFila *FV;


    //para inicializar o gráfo com 0
    for(i=1;i<=max;i++)
        for(j=1;j<=max;j++)
            grafo[i][j]=0;

    for (i=1;i<=max;i++)
        vis[i]=false; //inicializando vetor de vertices visitados

    //inicializando o grafo
    grafo[1][2] = 1;
    grafo[1][6] = 1;
    grafo[2][4] = 1;
    grafo[6][4] = 1;
    grafo[3][5] = 1;
    grafo[4][5] = 1;
    grafo[4][6] = 1;
    grafo[4][3] = 1;
    grafo[6][5] = 1;
    grafo[2][3] = 1;
    grafo[5][3] = 1;

    i = 1;
    puts("DFS");
    DFS(grafo,i, vis);

    //solicita a cor para os vertices do grafo 
    int cor[max+1];

    for (i=1;i<=max;i++)
        vis[i]=false; //inicializando vetor de vertices visitados
        
    for (i=1;i<=max;i++)
        cor[i]=0; //inicializando vetor de cores

    puts("\n\nColoração DFS");

    i = 1;
    coloracaoDFS(grafo,i, vis, cor);

    for (i=1;i<=max;i++)
        printf("cor[%d] = %d\n",i,cor[i]);
    

    puts("\n\nBFS");
    i = 1;
    BFS(grafo,i, vis);

    for (i=1;i<=max;i++)
        vis[i]=false; //inicializando vetor de vertices visitados

    puts("\n\nColoração BFS");

    i = 1;
    coloracaoBFS(grafo,i, vis, cor);

    for (i=1;i<=max;i++)
        printf("cor[%d] = %d\n",i,cor[i]);

    return 0;

}
