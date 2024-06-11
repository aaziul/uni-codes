/* Atividade desenvolvida em avaliação, pode conter erros e/ou estar incompleta, código realizado sem a possibilidade de testes */

/*OBJETIVO: fazer um programa para ler os 2 arquivos acima e salvar em um arquivo mais-ouvidos.txt os nomes dos artistas e título das músicas (um por linha) que tiverem mais X ouvintes, onde X é um valor inteiro lido do usuário (nao interessa o maior)
Além disso, deve imprimir as seguintes informações:
        1. O titulo da musica mais tocada em novembro e dezembro (maior quantidade de ouvintes mensais);
        2. Qual o estilo de música mais tocado coinsiderando os dois meses, novembro e dezembro.*/

#include <stdio.h>
#include <string.h>

typedef struct
{
    char artista[50]; //nome do artista
    char titulo[30]; // titulo da musica
    int estilo; // 0 - pop, 1 - sertanejo, 2 - rap
    int ouvintes; // numero de ouvintes mensais
} song_t;

int main(){
    FILE *point_nov;
    FILE *point_dez;
    FILE *point_txt;
    song_t SONG_T;
    int ouvintes = 0;
    int maisTocadaNov = 0;
    int novPop = 0;
    int novSert = 0;
    int novRap = 0;
    int maisTocadaDez = 0;
    int dezPop = 0;
    int dezSert = 0;
    int dezRap = 0;
    int pop = 0;
    int sert = 0;
    int rap = 0;
    
    // abertura dos arquivos
    point_nov = fopen("novembro.bin", "rb");
    point_dez = fopen("dezembro.bin", "rb");
    point_txt = fopen("mais-ouvidos.txt", "a+");

    // solicita o valor minimo de ouvintes
    printf("Informe o numero de ouvintes: ");
    scanf("%d", &ouvintes);

    // em caso de não abertura do arquivo, retorna erro
    if(point_nov == NULL){
        printf("Erro na abertura do arquivo de novembro!");
    } else if (point_dez == NULL){
        printf("Erro na abertura de arquivo de dezembro!");
    } else if(point_txt == NULL){
        printf("Erro na abertura do arquivo para escrita!\n");
    } else{ // senão, realiza as seguintes operações
        // enquanto faz a leitura do arquivo de novembro
        while (fread(&SONG_T, sizeof(song_t), 1, point_nov) == 1){
            if(SONG_T.ouvintes > ouvintes){
                // escreve no arquivo mais-ouvidos.txt o artista e musica com mais ouvintes
                fprintf(point_txt, "%s %s\n", SONG_T.artista, SONG_T.titulo);
            }

            // informa a mais tocada em novembro por numero de ouvintes
            if(SONG_T.ouvintes > maisTocadaNov){
                maisTocadaNov = SONG_T.ouvintes;
                strcpy(maisTocadaNov, SONG_T.titulo);
            }

            //informa o estilo de musica mais tocado em novembro
            if(SONG_T.estilo == 0){
                novPop += 1;
            } else if (SONG_T.estilo == 1){
                novSert += 1;
            } else if (SONG_T.estilo == 2){
                novRap +=1;
            }
        }

        //enquanto reiza a leitura do arquivo de dezembro
        while (fread(&SONG_T, sizeof(song_t), 1, point_dez) == 1)
        {
            if(SONG_T.ouvintes > ouvintes){
                // escreve no arquivo mais-ouvidos.txt o artista e musica com mais ouvintes
                fprintf(point_txt, "%s %s\n", SONG_T.artista, SONG_T.titulo);
            }

            // informa a mais tocada em dezembro por numero de ouvintes
            if(SONG_T.ouvintes > maisTocadaNov){
                maisTocadaDez = SONG_T.ouvintes;
                strcpy(maisTocadaDez, SONG_T.titulo);
            }

            // informa o estilo de musica mais tocado em dezembro
            if(SONG_T.estilo == 0){
                dezPop += 1;
            } else if (SONG_T.estilo == 1){
                dezSert += 1;
            } else if (SONG_T.estilo == 2){
                dezRap +=1;
            }
        }

        // valor do estilo de música é igual a soma do estilo nos meses de dezembro e novembro
        pop = novPop + dezPop;
        sert = novSert + dezSert;
        rap = novRap + dezRap;

        // se pop maior que sertanejo e rap, devolve que a mais tocada foi pop
        if((pop > sert) && (pop > rap)){
            printf("Estilo de musica mais tocado foi Pop!\n");
        } else if((sert > pop) && (sert > rap)){ // se sertanejo maior que pop e rap, devolve que a mais tocada foi sertanejo
            printf("Estilo de musica mais tocado foi Sertanejo!\n");
        } else if((rap > pop) && (rap > sert)){ // se rap maior que sertanejo e pop, devolve que a mais tocada foi rap
            printf("Estilo de musica mais tocado foi Rap!\n");
        } else { // senão, se houver valores iguais, devolve que houve empate
            printf("Houve empate!\n");
        }

        //informa a musica mais tocada de novembro
        printf("Musica mais tocada em novembro: %s\n", maisTocadaNov);
        
        //informa mais tocada em dezembro
        printf("Musica mais tocada em dezembro: %s\n", maisTocadaDez);
    }

    //fechamento dos arquivos
    fclose(point_nov);
    fclose(point_dez);
    fclose(point_txt);

    return 0;
}
