/* Atividade desenvolvida em Avaliação */
/* Luiza Souto - 21/02/2024
    OBJETIVO: desenvolver um programa que recebe do usuário valores para uma imagem RGB e após, solicita qual método o usuário gostaria de utilizar, sendo estes os seguintes:
        1. Método do Máximo Canal: o valor de cada pixel na imagem em escala de cinza é determinado selecionando o canal de cor com o valor mais alto entre os canais RGB do pixel original;
        2. Método Clássico: os valore sdos canais RGB de cada pixel são combinados usando pesos específicos para calcular o pixel na imagem em escala de cinza. O valor do pixel em cinza é dado por: 0,3*R + 0,59*G + 0,11*B;
        3. Método por Média de Canal: o valor de cada pixel na imagem em tons de cinza é calculada como a média dos valores dos três canais de cor RGB (Vermelho, Verde e Azul) do pixel original. Após devolver a matriz em escala de cinza após as conversões. */

#include <stdio.h>
#include <math.h>
#define N 15
#define LARG 10
#define ALT 8

// definição da estrutura PIXEL
typedef struct {
  int red; // inteiro - vermelho
  int green; //inteiro - verde
  int blue; // inteiro - azul
} PIXEL;

// FUNÇÕES

// lê a imagem do pixel RGB do usuário
void leImagem(PIXEL px[][N]){
  int i = 0, j = 0; // variáveis contador

  // recebe os valores da matriz
  for(i=0; i < LARG; i++){
    for(j=0; j < ALT; j++){
      //recebe o valor de red (R) para a posição atual
      printf("Insira o valor de R da posição %d, %d: ", i, j);
      scanf("%d", &px[i][j].red);

      //recebe o valor de green (G) para a posição atual
      printf("Insira o valor de G da posição %d, %d: ", i, j);
      scanf("%d", &px[i][j].green);

      //recebe o valor de blue (B) para a posição atual
      printf("Insira o valor de B da posição %d, %d: ", i, j);
      scanf("%d", &px[i][j].blue);
    }
  } 
}

// imprime imagem de escala de cinza
void imprimeImagem(int imagem[][N]){
  int i = 0, j = 0; // contadores

  //faz a impressão da matriz 
  for(i = 0; i < LARG; i++){
    for(j = 0; j < ALT; j++){
      printf("%4d", imagem[i][j]);
    }
    printf("\n"); // quebra de linha
  }
}

// FUNÇÕES PARA CONVERSÕES

// Maximo Canal: o valor de cada pixel na imagem em escala de cinza é determinado selecionando o canal de cor com o valor mais alto entre os canais RGB do pixel original
void maximoCanal(int imagem[][N], PIXEL px[][N]){
  int i = 0, j = 0; // contadores

  // para se movimentar na matriz pixel enviado como parâmetro
  for(i = 0; i < LARG; i++){
    for(j = 0; j < ALT; j++){
      // se o valor de vermelho na estrutura PIXEL for maior que o valor de verde e azul, o valor daquele exato "quadrado" é o valor de red da estrutura PIXEL
      if((px[i][j].red > px[i][j].green) && (px[i][j].red > px[i][j].blue)){
        imagem[i][j] = px[i][j].red;
      } 
      // senão, se o valor de verde na estrutura PIXEL for maior que o valor de vermelho e azul, o valor daquele exato "quadrado" é o valor de green da estrutura PIXEL
      else if((px[i][j].green > px[i][j].red) && (px[i][j].green > px[i][j].blue)){
        imagem[i][j] = px[i][j].green;
      } 
      // senão, se o valor de azul na estrutura PIXEL for maior que o valor de vermelho e verde, o valor daquele exato "quadrado" é o valor de blue da estrutura PIXEL
      else if((px[i][j].blue > px[i][j].green) && (px[i][j].blue > px[i][j].red)){
        imagem[i][j] = px[i][j].blue;
      }
    }
  }
  imprimeImagem(imagem); // chama a função para retornar a matriz impressa
}

// Método Clássico: os valore sdos canais RGB de cada pixel são combinados usando pesos específicos para calcular o pixel na imagem em escala de cinza. O valor do pixel em cinza é dado por: 0,3*R + 0,59*G + 0,11*B
void metodoClassico(int imagem[][N], PIXEL px[][N]){
  int i = 0, j = 0; // contadores

  // para se movimentar na matriz pixel enviado como parâmetro
  for(i = 0; i < LARG; i++){
    for(j = 0; j < ALT; j++){
      // valor do "quadrado" atual da matriz é a operação efetuada no enunciado com os valores de red, green e blue da matriz PIXEL no mesmo "quadrado"
      imagem[i][j] = (0.3 * px[i][j].red) + (0.59 * px[i][j].green) + (0.11 * px[i][j].blue);
    }
  }
  imprimeImagem(imagem); // chama a função para retornar a matriz impressa
}

// Método por Média de Canal: o valor de cada pixel na imagem em tons de cinza é calculada como a média dos valores dos três canais de cor RGB (Vermelho, Verde e Azul) do pixel original. Após devolver a matriz em escala de cinza após as conversões
void mediaDeCanal(int imagem[][N], PIXEL px[][N]){
  int i = 0, j = 0; // contadores
  
// para se movimentar na matriz pixel enviado como parâmetro
  for(i = 0; i < LARG; i++){
    for(j = 0; j < ALT; j++){
      // valor do "quadrado" atual da matriz é a media dos valores RGB contidos na matriz de PIXEL
      imagem[i][j] = (px[i][j].red + px[i][j].green + px[i][j].blue) / 3;
    }
  }
  imprimeImagem(imagem);
}

// FUNÇÃO PRINCIPAL
int main(){
  int imagem[N][N]; // imagem em escala de cinza
  int metodo = 0; // inteiro para verificar o método de conversao escolhido
  PIXEL px[N][N]; // matriz do tipo PIXEL

  // aplica a função leImagem para realizar a leitura da imagem RGB
  leImagem(px);

  // solicita o metodo de conversao e informa as opcoes de metodos
  printf("\nInforme o metodo para conversao: ");
  printf("\nDigite 1 para Metodo do Maximo Canal;");
  printf("\nDigite 2 para Metodo Classico;");
  printf("\nDigite 3 para Metodo por Media de Canal.");
  scanf("%d", &metodo);

  // verifica o numero recebido para iniciar a funcao do metodo correto
  if(metodo == 1){
    maximoCanal(imagem, px);
  } else if (metodo == 2){
    metodoClassico(imagem, px);
  } else if (metodo == 3){
    mediaDeCanal(imagem, px);
  } else {
    printf("Numero invalido, tente novamente!");
  }

  return 0;
}
