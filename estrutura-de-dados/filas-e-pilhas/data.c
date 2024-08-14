#include "data.h"
#include <stdio.h>
#include <stdlib.h>

// função para criar um novo nó
Nodo *criaNodo(int valor) {
  Nodo *novoNodo = (Nodo *)malloc(sizeof(Nodo));

  novoNodo->dado = valor; // atribui o valor ao novo nó
  novoNodo->prox = NULL;  // o novo nó é o último da fila

  return novoNodo; // retorna o novo nó
}

// função para enfileirar (insere no final da fila)
void enfileirar(Fila *fila, int valor) {
  Nodo *novoNodo = criaNodo(valor); // cria um novo nó

  if (fila->tras == NULL) {
    fila->frente =
        novoNodo; // se a fila estiver vazia, o novo nó é o primeiro e o último
    fila->tras = novoNodo;
  } else {
    fila->tras->prox = novoNodo; // o último nó aponta para o novo nó
    fila->tras = novoNodo;       // o novo nó é o último da fila
  }
  // return 0;
}

// função para desenfileirar (remove do inicio da fila)
int desenfileirar(Fila *fila) {
  if (fila->frente == NULL) {       // se a fila estiver vazia
    printf("A fila esta vazia.\n"); // imprime que a fila está vazia
    return -1;
  }

  Nodo *temp = fila->frente; // cria um ponteiro para o primeiro nó
  int valor = temp->dado;    // armazena o valor do primeiro nó

  fila->frente = fila->frente->prox; // o segundo nó passa a ser o primeiro

  free(temp); // libera o primeiro nó

  return valor; // retorna o valor do primeiro nó
}

// função para verificar se a lista está vazia
int filaVazia(struct s_Fila *fila) {
  return fila->frente ==
         NULL; // retorna 1 se a fila estiver vazia e 0 se não estiver
}

// função para comparar duas filas
int comparaFilas(Fila *filaUm, Fila *filaDois) {
  Nodo *nodoUm =
      filaUm->frente; // cria um ponteiro para o primeiro nó da primeira fila
  Nodo *nodoDois =
      filaDois->frente; // cria um ponteiro para o primeiro nó da segunda fila

  // percorre as duas filas
  while (nodoUm && nodoDois) {
    if (nodoUm->dado !=
        nodoDois->dado) { // se os valores dos nós forem diferentes
      return 0;           // retorna 0
    }

    nodoUm = nodoUm->prox;     // passa para o próximo nó da primeira fila
    nodoDois = nodoDois->prox; // passa para o próximo nó da segunda fila
  }

  // se uma das filas tiver mais elementos que a outra
  if (nodoUm || nodoDois) {
    return 0; // retorna 0
  }

  return 1; // se as filas forem iguais, retorna 1
}
