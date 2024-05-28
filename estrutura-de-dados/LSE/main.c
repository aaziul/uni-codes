#include <stdio.h>
#include <stdlib.h>
#include "data.h"

int main(){
  PtProd* ptLista;
  Produto prod;

  ptLista = inicializa();

  for(int i = 0; i < 4; i++){
    printf("Codigo = ");
    scanf("%d", &prod.codigo);

    printf("Nome = ");
    scanf("%s", &prod.nome);

    print("Preco = ");
    scanf("%f", &prod.preco);

    ptLista = insere(ptLista, prod);
  }

  imprime(ptLista);

  return 0;
}
