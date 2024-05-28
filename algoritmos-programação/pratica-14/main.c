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

// le os nomes e os scores dos jogadores
int le_highscores (char nomeAr[], TIPOSCORE *scr){
  int i = 0;
  FILE *scrVal;
  char aux[40];

  //abre arquivo
  scrVal = fopen(nomeArq, "r");

  //se o documento não abrir, retorna -1
  if(!scrVal){
    return -1;
  } else {
    //enquanto contador for menor que TAMARRANJO
    for(i = 0; i < TAMARRANJO; i++){
      //le a string nome ate encontrar o \n e adiciona na struct
      fgets(scr[i].nome, sizeof(scr[i].nome), scrVal);
      //nao conta '\n'
      if(scr[i].nome[strlen(scr[i].nome) - 1] == '\n'){
        scr[i].nome[strlen(scr[i].nome) - 1] = '\0';
      }

      fgets(aux, sizeof(aux), scrVal);
      // transforma o numero de score em string
      scr[i].score = atoi(aux);
    }
    fclose(scrVal); // fecha o arquivo
    return 1;
  }
}

//escreve novo valor no arquivo texto
int escreve_highscore (char nomeArq[], TIPOSCORE *scr){
   int i = 0;
    FILE *scrVal;

    //abertura de arquivo
    scrVal = fopen(nomeArq, "w");

    //se arquivo nao for aberto informa erro
    if(!scrVal){
        printf("\nERRO!"); 
        return -1;
    } else{
        //senao, para contador menor que TAMARRANJO
        for(i = 0; i < TAMARRANJO; i++){
            //escreve a string e o numero no arquivo de acordo com o que recebe na struct SCORE
            fprintf(scrVal, "%s\n%d\n", scr[i].nome, scr[i].score);
        }
        fclose(scrVal);
        return 1;
    }
}

// funcao principal
int main(){
  char nomeArq[TAMMAX];
  TIPOSCORE scr[TAMARRANJO];
  int i = 0; 

  // solicita nome do arquivo para realizar a leitura
    printf("Entre o nome do arquivo: ");
    scanf("%s", nomeArq);

    // impressão das variáveis lidas no arquivo binário
    if(le_highscores(nomeArq, scr) == 1){
        for(i = 0; i < TAMARRANJO; i++){
            printf("Jogador: %s\n", scr[i].nome);
            printf("Score: %d\n", scr[i].score);
        }
    } else{ // senão, retorna erro
        printf ("\nErro na abertura do arquivo!");
        return 0;
    }

    //solicita o nome de um novo jogador
    char novoNome[TAMMAX];

    printf("\nInforme o nome do novo jogador: ");
    scanf("%s", novoNome);

    // altera o primeiro nome do arquivo texto, para o nome do novo jogador
    strcpy(scr[0].nome, novoNome);

    // solicita o score do novo jogador
    int novoScore;

    printf("\nInforme o score deste jogador: ");
    scanf("%d", &novoScore);

    // coloca o score do novo jogador na primeira posição do arquivo texto
    scr[0].score = novoScore;

    //solicita novo nome para o arquivo
    char novoNomeArq[TAMMAX];

    printf("\nInforme o nome do arquivo de saida: ");
    scanf("%s", novoNomeArq);

    // aplica função escreve_highscore para alterar o nome do arquivo e fazer uma "cópia"
    escreve_highscore(novoNomeArq, scr);

    return 0;
}
