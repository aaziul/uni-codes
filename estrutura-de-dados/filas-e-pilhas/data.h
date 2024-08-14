#include <stdio.h>
#include <stdlib.h>
// definição da estrutura de nó para fila, pilha e deque
typedef struct s_Nodo {
  int dado;            // informação do nó atual
  struct s_Nodo *prox; // pontero para o proximo nó
} Nodo;

// definição de estrutura da fila
typedef struct s_Fila {
  Nodo *frente; // primeiro elemento da fila
  Nodo *tras;   // ultimo elemento da fila
} Fila;

Nodo *criaNodo(int valor);              // cria um novo nó
void enfileirar(Fila *fila, int valor); // enfileira um novo nó
int desenfileirar(Fila *fila);          // desenfileira um nó
int filaVazia(struct s_Fila *fila);     // verifica se a fila está vazia
int comparaFilas(Fila *filaUm, Fila *filaDois); // compara duas filas
