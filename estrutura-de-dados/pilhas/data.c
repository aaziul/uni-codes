#include <stdio.h>
#include <stdlib.h>
#include "data.h"

// criação de pilha encadeada
TipoPilha* InicializaPilha(){
  return NULL;
}

//testa se a pilha está vazia
int pilhaVazia(TipoPilha *Topo){
    if (Topo == NULL){ // testa se o topo é nulo
        return 1; // retorna 1 se a pilha estiver vazia
    } else {
        return 0; // retorna 0 se a pilha não estiver vazia
    }
}

//imprime a pilha 
void imprimePilha(TipoPilha *Topo){
    TipoPilha *ptaux;

    if(Topo != NULL){ // testa se a pilha está vazia
        puts("---Imprimindo pilha---");
        for(ptaux = Topo; ptaux != NULL; ptaux = ptaux->elo){ // percorre a pilha
            printf("%d\n", ptaux->dado); // imprime o dado
        }
        puts("-------Fim pilha------");
    } else {
        puts("Pilha vazia"); // imprime que a pilha está vazia
    }
}

//insere um elemento na pilha
TipoPilha* pushPilha(TipoPilha *Topo, TipoInfo Dado){
    TipoPilha *novo;
    TipoPilha *ptaux = Topo;

    novo = (TipoPilha*) malloc(sizeof(TipoPilha)); // aloca um novo nodo
    novo->elo = NULL; // inicializa o elo

    novo->dado = Dado; // insere o dado

    novo->elo = Topo; // encaeia o elemento
    Topo = novo; // atualiza o topo

    return Topo; // retorna o topo
}

// remove um elemento da pilha
int popPilha(TipoPilha **Topo, TipoInfo *Dado){ 
    TipoPilha *ptaux;

    if(pilhaVazia(*Topo)){
        return 0; // retorna 0 se a pilha estiver vazia
    } else { // se a pilha não estiver vazia
        *Dado = (*Topo)->dado; // guarda o dado
        ptaux = *Topo; // guarda o topo
        *Topo = (*Topo)->elo; // atualiza o topo
        free(ptaux); // libera o topo
        ptaux = NULL; // atualiza o ptaux
        return 1; // retorna 1
    }
}

TipoInfo consultaPilha(TipoPilha *Topo){
    if(Topo == NULL){ // testa se a pilha está vazia
        return 0; // retorna 0 se a pilha estiver vazia
    } else {
        return Topo->dado; // retorna o dado do topo
    }
}

TipoPilha* destroiPilha(TipoPilha *Topo){
    TipoPilha *ptaux;

    while(Topo != NULL){ // enquanto a pilha não estiver vazia
        ptaux = Topo; // guarda o topo
        Topo = Topo->elo; // atualiza o topo
        free(ptaux); // libera o topo
    }

    return NULL; // retorna nulo
}   

//compara duas pilhas, retorna 1 se forem iguais e -1 se forem diferentes
int comparaPilhas(TipoPilha *TopoUm, TipoPilha *TopoDois){
    TipoPilha *ptauxUm = TopoUm;
    TipoPilha *ptauxDois = TopoDois;

    if(pilhaVazia(TopoUm) && pilhaVazia(TopoDois)){ // testa se as duas pilhas estão vazias
        return 1; // retorna 1 se as duas pilhas estiverem vazias
    } else if(pilhaVazia(TopoUm) || pilhaVazia(TopoDois)){ // testa se uma das pilhas está vazia
        return 0; // retorna 0 se uma das pilhas estiver vazia
    } else { // se as duas pilhas não estiverem vazias
        while(pilhaVazia(ptauxUm) && pilhaVazia(ptauxDois)){ // enquanto as duas pilhas não estiverem vazias
            if(ptauxUm->dado != ptauxDois->dado){ // testa se os dados são diferentes
                return 0; // retorna 0 se os dados forem diferentes
            }
        }
        if(ptauxUm == NULL && ptauxDois == NULL){ // testa se as duas pilhas estão vazias
            return 1; // retorna 1 se as duas pilhas estiverem vazias
        } else { // se as duas pilhas não estiverem vazias
            return 0; // retorna 0
        }
    }
}
