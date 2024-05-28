#include <stdio.h>
#include <stdlib.h>

typedef struct Produto{
  int codigo;
  char nome[50];
  float preco;
} Produto;

typedef struct PtProd{
  Produto prod;
  struct PtProd* prox;
} PtProd;
