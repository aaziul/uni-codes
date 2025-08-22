#include <stdio.h>
#include <stdlib.h>
#include <string.h> 
#include <locale.h>
#include <time.h>
#include "func.h"

/*
OBJETIVO:
    O programa lê um arquivo texto como entrada e gera um arquivo como saída com o conteúdo do arquivo de entrada convertido para letras minusculas

INSTRUÇÕES:
    - Para chamar, digite "exemplo entrada.txt saida.txt"
*/

// variáveis globais para armazenar as estatísticas
extern int compABP;
extern int compAVL;
extern int heightABP;
extern int heightAVL;
extern int numNodosABP;
extern int numNodosAVL;
extern int rotationsABP;
extern int rotationsAVL;

int main(int argc, char *argv[]) { // argc conta o número de parâmetros e argv armazena as strings correspondentes aos parametros digitados
    setlocale(LC_ALL,""); // para imprimir corretamente na tela os caracteres acentuados

    FILE *dict; // arquivo dicionário
    FILE *entrada; // arquivo de entrada
    FILE *saida; // arquivo de saida 
    FILE *stats; // arquivo de estatísticas

    char *palavra, linha[1000], linhaDict[1000], wordKey[1000], wordSub[1000]; // linhas a serem lidas do arquivo
    char separador[] = {" ,.&*%\?!;/-'@\"$#=><()]}{:\n\t"}; // caracteres que serão considerados como separadores de palavras

    Node* rootABP = initializeTree(); // inicializa abp
    NodeAVL* rootAVL = initializeTreeAVL(); // inicializa avl

    if(argc != 4){ // o número de parametros esperado é 3: nome do programa (argv[0]), nome do arq de entrada (argv[1]), nome arq de saida (argv[2])
        printf("Numero incorreto de parametros. \n Para chamar o programa digite: 'exemplo <arq_dict> <arq_entrada> <arq_saida>'\n");
        return 1;
    } else {
        dict = fopen(argv[1], "r"); // abre o arquivo para leitura -- argv[1] é o primeiro parâmetro após o nome do arquivo
        
        if(dict == NULL){ // se nao conseguiu abrir o arquivo
            printf("Erro ao abrir o arquivo %s",argv[1]);
            return 1;
        } else {
            // lê o dicionário e insere as palavras na árvore
            while(fgets(linhaDict,1000,dict)){ // enquanto nao chegar no final do arquivo
                linhaDict[strcspn(linhaDict, "\n")] = '\0'; // remove o \n do final da linha
                splitStringOnTab(linhaDict, wordKey, wordSub); // separa a linha em duas palavras

                rootABP = insertNode(rootABP, wordKey,wordSub); // insere a palavra na abp
                rootAVL = insertNodeAVL(rootAVL, wordKey, wordSub); // insere a palavra na avl
            }
        }

        fclose(dict); // fecha o arquivo de dicionário

        entrada = fopen(argv[2], "r");  // abre o arquivo para leitura

        if (entrada == NULL){
            printf("Erro ao abrir o arquivo %s",argv[2]);
            return 1;
        } else{
            saida = fopen (argv[3], "w"); // abre o arquivo para saida

            while(fgets(linha,1000,entrada)){
                palavra = strtok(linha, separador); //considera qualquer caractere não alfabético como separador

                while (palavra != NULL){ // enquanto nao chegar ao final da linha
                    palavra = searchAVL(rootAVL, palavra); // busca a palavra na arvore avl
                    fprintf(saida,"%s ", palavra); //strlwr eh a funcao que converte palavras para minusculo
                    palavra = strtok (NULL, separador); // pega a proxima palavra
                }
                fprintf(saida,"%s ","\n");
            }

            fseek(entrada,0,SEEK_SET); // volta para o inicio do arquivo

            // percorre todo o arquivo lendo linha por linha
            while (fgets(linha,1000,entrada)){
                palavra = strtok(linha, separador); //considera qquer caractere n o alfab tico como separador
                while (palavra != NULL){
                    palavra = searchTree(rootABP, palavra);
                    fprintf(saida,"%s ", palavra); //strlwr   a fun  o que converte palavras para min sculo
                    palavra = strtok (NULL, separador);
                }
                fprintf(saida,"%s", "\n");
            }

            heightAVL = height(rootAVL); // calcula a altura da avl
            heightABP = 1 + alturaArvore(rootABP); // calcula a altura da abp

            numNodosAVL = countNodesAVL(rootAVL); // numero de nodos da avl
            numNodosABP = countNodos(rootABP); // numero de nodos da abp

            stats = fopen ("Statistics.txt", "w");

            // Verifica se o arquivo foi aberto com sucesso
            if (stats == NULL) {
                printf("Erro ao abrir o arquivo!\n");
                return 1;
            }

            fprintf(stats, "========  ESTATÍSTICAS ABP ============\n"); // imprime o numero de nodos da abp

            fprintf(stats, "Numero de Nodos: %d \n", numNodosABP); // imprime o numero de nodos da abp
            fprintf(stats, "Altura: %d \n", heightABP); // imprime a altura da abp
            fprintf(stats, "Rotações: %d \n", rotationsABP); // imprime o numero de rotacoes da abp
            fprintf(stats, "Comparações: %d \n\n\n", compABP); // imprime o numero de comparacoes da abp

            fprintf(stats, "========  ESTATÍSTICAS AVL ============\n"); // imprime o numero de nodos da abp
            fprintf(stats, "Numero de Nodos: %d \n", numNodosAVL); // imprime o numero de nodos da avl
            fprintf(stats, "Altura: %d \n", heightAVL); // imprime a altura da avl
            fprintf(stats, "Rotações: %d \n", rotationsAVL); // imprime o numero de rotacoes da avl
            fprintf(stats, "Comparações: %d \n\n", compAVL); // imprime o numero de comparacoes da avl
        }

        fclose (entrada); // fecha arquivo de entrada
        fclose (saida); // fecha arquivo de saida
        fclose(stats);
        
        puts("Processo finalizado");

        return 0;
    }
}