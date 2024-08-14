#include "data.c"
#include <stdio.h>
#include <stdlib.h>
#define MAXFILA 4

int main() {
  Fila filaUm = {0};
  Fila filaDois = {0};
  int aux = 0;
  int valoresFilaUm = 0;
  int valoresFilaDois = 0;

  printf("Informe os valores da fila Um: ");
  for (int i = 0; i < MAXFILA; i++) {
    scanf("%d", &valoresFilaUm);        // recebe os valores da fila Um
    enfileirar(&filaUm, valoresFilaUm); // enfileira os valores da fila
  }

  printf("Informe os valores da fila Dois: ");
  for (int j = 0; j < MAXFILA; j++) {
    scanf("%d", &valoresFilaDois);          // recebe os valores da fila Dois
    enfileirar(&filaDois, valoresFilaDois); // efileira os valores da fila
  }

  aux = comparaFilas(&filaUm, &filaDois); // compara as duas filas

  if (aux == 1) {
    printf("As filas sao iguais.\n");
  } else if (aux == 0) {
    printf("As filas sao diferentes.\n");
  } else {
    printf("Erro.");
  }

  return 0;
}
