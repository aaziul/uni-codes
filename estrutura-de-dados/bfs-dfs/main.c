#include <stdio.h>
#include <stdlib.h>
#include "data.h"
#include "data.c"

int main(){
    int grafo[8][8] = { 0, 1, 1, 0, 0, 0, 0, 0,
                        0, 0, 0, 1, 0, 0, 0, 0,
                        0, 0, 0, 1, 1, 0, 0, 0,
                        0, 0, 0, 0, 1, 1, 0, 1,
                        0, 0, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 1, 0, 0, 0,
                        0, 1, 0, 0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0, 0, 1, 0 };
    int visitado[8] = {0};

    DFS(grafo, 0, visitado);

    printf("\n");

    BFS(grafo, 0);

    return 0;
}
