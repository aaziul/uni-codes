#include <stdio.h>

typedef struct Produto{
  int codigo;
  char ome[50];
  float preco;
} Produto;

typedef struct PtProd{
  Produto prod;
  struct PtProd* ant;
  struct PtProd* prox;
} PtProd;
