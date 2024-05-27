/* OBJETIVO: imprimir o nome dos jogadores e o valor de seus scores de um arquivo texto, após solicitar um novo jogador (nome e score) e colocá-los na posição correta no arquivo texto. */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define TAMMAX 50
#define TAMARRANJO 5

//estrutura de score do jogo
typedef struct tipoScore{
  char nome[TAMMAX];
  int score;
} TIPOSCORE;
