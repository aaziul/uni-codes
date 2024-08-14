#include <stdio.h>
#include <stdlib.h>
#include "data.c"
#define MAXPILHA 4

int main(){
    TipoPilha *pilhaUm;
    TipoPilha *pilhaDois;
    int aux = 0;
    int valorPilhaUm = 0;
    int valorPilhaDois = 0;

    pilhaUm = inicializaPilha(); // inicializa a pilha Um
    pilhaDois = inicializaPilha(); // inicializa a pilha Dois

    printf("Informe os valores da pilha Um: ");
    for(int i = 0; i < MAXPILHA; i++){
        scanf("%d", &valorPilhaUm); // recebe os valores da fila Um
        pushPilha(pilhaUm, valorPilhaUm); // empilha os valores da pilha
    }
    
    printf("Informe os valores da pilha Dois: ");
    for(int j = 0; j < MAXPILHA; j++){
        scanf("%d", &valorPilhaDois); // recebe os valores da fila Dois
        pushPilha(pilhaDois, valorPilhaDois); // empilha os valores da pilha
    }

    aux = comparaPilhas(pilhaUm, pilhaDois); // compara as pilhas

    if(aux == 1){
        printf("As filas sao iguais.\n");
    } else if (aux == 0){
        printf("As filas sao diferentes.\n");
    } else{
        printf("Erro.");
    }

    return 0;
}
