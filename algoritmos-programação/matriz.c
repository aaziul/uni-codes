/* CONTEÚDO DE AVALIAÇÃO */
/*OBJETIVO: ler do usuário o número de linhas e de colunas da imagem que será lida e a imagem em si, em seguida as coordenadas X e Y e a largura e a altura que serão consideradas no filtro. Por fim, aplicar a função filtra utilizando as informações lidas e imprimir a imagem resultante. O código solicita também as seguintes funções:
                    1. leImagem: lê do usuário os valores da imagem inicial;
                    2. imprimeImagem: imprime os valores da matriz na tela;
                    3. aplicaFiltro: aplicar o filtro na imagem, deve calcular a média dos valores de pixel em uma dada região retangular da imagem e atribuir o valor ao pixel central.
Numero maximo de linhas e colunas da matriz é 10.*/

#include <stdio.h>
#define N 10

//faz a leitura da imagem
void leImagem(int imagem[][N], int linhas, int colunas){
  int i = 0, j = 0;

  //faz a leitura dos valores de acordo com as linhas e colunas
  for (i = 0; i < linhas; i++){
    for (j = 0; j < colunas; j++){
      printf("Insira o valor da posicao %d, %d: ", i, j);
      scanf("%d", &imagem[i][j]);
    }
  }
}

//imprime a imagem
void imprimeImagem(int imagem[][N], int linhas, int colunas){
  int i = 0, j = 0;

  //faz a impressão da matriz
  for(i = 0; i < linhas; i++){
    for(j = 0; j < colunas; j++){
      printf("%d  ", imagem[i][j]);
    }
    printf("\n"); //quebra de linha
  }
}

//função aplicaFiltro calcula a média dos valores de pixel em uma dada região retangular da imagem e atribui o valor ao pixel central
void aplicaFiltro(int imagem[][N], int linhas, int colunas, int coordX, int coordY, int altura, int largura){
  int i = 0, j = 0, soma = 0, contador = 0;
  int difY = (altura - 1) / 2; //diferenca de Y
  int difX = (largura - 1) / 2; //diferenca de X

  //se movimenta dentro da matriz (coordenada Y - altura)
  for(i = coordY - difY; i <= coordY + difY; i++){
        // se movimenta dentro da matriz (coordenada X - largura)
        for(j = coordX - difX; j <= coordX + difX; j++){
            //verifica se a posição esta dentro a matriz ou fora da matriz
            if((i < linhas) && (i >= 0) && (j < colunas) && (j >= 0)){
                soma += imagem[i][j];
                contador++;
            }
        }
    } 
  //calcula a média
  imagem[coordY][coordX] = soma / contador;
}

int main(){
  int imagem[N][N];
  int linhas = 0, colunas = 0, coordX = 0, coordY = 0, altura = 0, largura = 0;

  // leitura de linhas e colunas
  printf("Entre com o numero de linhas: ");
  scanf("%d", &linhas);

  printf("Entre com o numero de colunas: ");
  scanf("%d", &colunas);

  // aplicação da função leImagem com os valores recebidos
  leImagem(imagem, linhas, colunas);

  //leitura das coordenadas x e y
  printf("Entre com a coord X: ");
  scanf("%d", &coordX);

  printf("Entre com a coord Y: ");
  scanf("%d", &coordY);

  // leitura da largura e altura
  printf("Entre com a altura: ");
  scanf("%d", &altura);

  printf("Entre com a largura: ");
  scanf("%d", &largura);

  // aplicação da função aplicaFiltro com os valores recebidos
  aplicaFiltro(imagem, linhas, colunas, coordX, coordY, altura, largura);

  // aplicação da função imprimeImagem com os valores recebidos
  imprimeImagem(imagem, linhas, colunas);

  return 0;
}
