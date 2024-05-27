/*OBJETIVO: solicitar a leitura de um nome de um arquivo e chamar a função le_binario, que recebe um nome de um arquivo binario e faz a leitura de suas variáveis, imprimir na tela os valores dentro do arquivo binario e solicitar a leitura de um novo vor para a variável "dec_gap" e dar um novo nome ao arquivo binário recebido chamando a função escreve_binario, que recebe o nome de um arquivo e suas set variáveis inteiras do controle do jogo e escreve um arquivo binario contendo o conteúdo das variáveis.*/

#include <stdio.h>
#include <stdlib.h>
#define TAMMAX 30

// estrutura de dificuldade do jogo
typedef struct {
    int score_threshold;
    int gap;
    int dec_gap;
    int dif_max_altura;
    int inc_dif_max_altura;
    int vel_obstaculos;
    int inc_vel_obstaculos;
} DIFICULDADE;

// função le_binario: recebe um nome de um arquivo binario e faz a leitura de suas variáveis
int le_binario (char nomeArq[], DIFICULDADE *dif){
    FILE *difVal;

    //abre arquivo
    difVal = fopen(nomeArq, "rb");

    //se arquivo não for aberto, a função retornará -1
    if(!difVal){
        return -1;
    } else { // senão,
        // faz a leitura do arquivo e armazena os dados de acordo com a struct DIFICULDADE (por isso usamos o sizeof)
        fread(dif, sizeof(DIFICULDADE), 1, difVal);

        // fecha o arquivo
        fclose(difVal);

        //função retorna -1
        return 1;
    }
}

// função escreve_binario: recebe o nome de um arquivo e suas sete variáveis inteiras do controle do jogo e escreve um arquivo binario contendo o conteúdo das variáveis
void escreve_binario(char nomeArq[], DIFICULDADE *dif){
    FILE *difVal;

    //abertura dp arquivo
    difVal = fopen(nomeArq, "wb");

    // se arquivo não for aberto, devolve erro e retorna 0
    if(!difVal){
        printf("Erro na abertura do arquivo!");
        return 0;
    } else{ // senão,
        // escreve no arquivo, de acordo com o tamanho da struct DIFICULDADE
        fwrite(dif, sizeof(DIFICULDADE), 1, difVal);

        //fecha arquivo
        fclose(difVal);
    }
}

int main(){
    char nomeArq[TAMMAX];
    DIFICULDADE dif;

    // solicita o nome do arquivo binário
    printf("Entre com o nome do arquivo: ");
    scanf("%s", nomeArq);

    // se a função le_binario retornar -1, informa que houve erro na abertura do arquivo
    if(le_binario(nomeArq, &dif) == -1){
        printf("Problema na abertura do arquivo!");
        return 0;
    }

    // impressão da variáveis lidas no arquivo binário
    printf("Valor das variáveis lidas: \n");
    printf("score_threshold: %d \n", dif.score_threshold);
    printf("gap: %d\n", dif.gap);
    printf("dec_gap: %d\n", dif.dec_gap);
    printf("dif_max_altura: %d\n", dif.dif_max_altura);
    printf("inc_dif_max_altura: %d\n", dif.inc_dif_max_altura);
    printf("vel_obstaculos: %d\n", dif.vel_obstaculos);
    printf("inc_vel_obstaculos: %d\n", dif.inc_vel_obstaculos);

    // solicita um novo valor para a variávl "dec_gap"
    int novoDecGap;

    printf("\nEntre com um novo valor para a variavel dec_gap: ");
    scanf("%d", &novoDecGap);

    // solicita novo nome para o arquivo binário
    char novoNomeArq[TAMMAX];

    printf("\nEntre um novo nome para o arquivo binario: ");
    scanf("%s", novoNomeArq);

    // adiciona novo valor de DecGap na estrutura DIFICULDADE
    dif.dec_gap = novoDecGap;

    // aplica o novo nome do arquivo ao arquivo binário
    escreve_binario(novoNomeArq, &dif);

    return 0;
}
