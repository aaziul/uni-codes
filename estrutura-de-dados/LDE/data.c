#include <stdio.h>
#include <stdlib.h>
#include "data.h"

/* inicializa a lista */
PtProd* inicializa(){
    return NULL;
}

/* imprime os elementos da lista */
void imprime(PtProd* PtLista){
    PtProd* aux = PtLista; //ponteiro auxiliar = PtLista

    if(PtLista == NULL){
        printf("Lista Vazia!"); // se a lista estiver vazia, retorna string de lista vazia
    } else{
        do{
            printf("Codigo: %d | Nome: %s | Preco: %f\n", aux->prod.codigo, aux->prod.nome, aux->prod.preco); // se não, imprime os elementos 
            aux = aux->prox; // vai para o proximo elemento da lista
        } while(aux != NULL); // enquanto a lista nao for vazia
    }
}

/* imprime os elementos em ordem invertida */
void imprimeInvertida (PtProd *PtLista){
    PtProd *aux; //ponteiro auxiliar

    if(PtLista == NULL){
        printf("Lista Vazia!"); // se a lista estiver vazia, retorna string de lista vazia
    } else{
        aux = PtLista;
        while(aux->prox != NULL){ //enquanto o prox elemento for diferente de NULL
            aux = aux->prox; // auxiliar recebera o valor do proximo elemento
        }

        while(aux != NULL){
            printf("Codigo: %d | Nome: %s | Preco: %f\n", aux->prod.codigo, aux->prod.nome, aux->prod.preco); // se não, imprime os elementos 
            aux = aux->ant; // com auxiliar recebendo o valor do elemento anterior
        }
    }
}

/* função que destroi a lista */
PtProd* destroi(PtProd* PtLista){
    PtProd *aux; //ponteiro auxiliar
    while(PtLista != NULL){ // enquanto a lista for diferente de NULL
        aux = PtLista; // auxiliar recebe a lista
        PtLista = PtLista->prox; // lista vai para o proximo elemento
        free(aux); //libera e evita o vazamento de memoria de auxiliar
    }
    free(PtLista); //libera e evita o vazamento de memoria de ptlista

    return NULL; // retorna vazio
}

/* função para remover elemento da lista */
PtProd* remover(PtProd *PtLista, int codigo){
    PtProd* aux = PtLista; // auxiliar recebe PtLista
    while(aux){
        if (codigo == aux->prod.codigo){ // se o codigo recebido, for o mesmo que o codigo de um elemento na lista
            if(aux->ant){ // verifica o elementeo anterior de auxiliar
                aux->ant->prox = aux->prox; // auxiliar verifica o proximo elemento da lista
            } else{
                PtLista = aux->prox; //senão, ptlista recebe o valor do proximo elemento para verificar
            }

            if(aux->prox){ // se precisar verificar no proximo elemento
                aux->prox->ant = aux->ant; //auxiliar verifica primeiro o elemento anterior
            }

            free(aux); // libera memoria de auxiliar
        }
        PtLista = aux->prox; // pula para o proximo elemeno de ptLista
    }
    return PtLista; // retorna o valor de PtLista
}

/* insere elemento na lista em ordem crescente de codigo */
PtProd* insere(PtProd* PtLista, Produto dados){
    PtProd *novo; //ponteiro da variavel novo do tipo PtProd, recebe um novo produto
    PtProd *ant = NULL; // produto anterior
    PtProd *aux = PtLista; // ponteiro auxiliar

    novo = (PtProd*) malloc(sizeof(PtProd)); // novo recebe uma reserva de espaço de memória do tamanho de PtLista
    novo->prod = dados; //recebe os dados do novo produto

    /*procura elemento na lista*/
    while((aux != NULL) && (aux->prod.codigo < novo->prod.codigo)){
        ant = aux; // anterior recebe auxiliar
        aux = aux->prox; // auxilair movimenta para o proximo elemento
    }

    novo->prox = aux; // proximo elemento de novo recebe auxiliar
    novo->ant = ant; // elemento anterior de novo recebe ant

    if(aux){
        aux->ant = novo;
    }

    if(ant){
        ant->prox = novo;
    } else{
        PtLista = novo;
    }

    return PtLista;
}
