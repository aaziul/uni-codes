/* Atividade desenvolvida em avaliação, pode conter erros e/ou estar incompleta, código realizado sem a possibilidade de testes */

/* Luiza Souto - 21/02/2024
OBJETIVO: desenvolver um programa que armazena as informacoes de aluguel de livros em uma biblioteca, incluir as tres funcoes: 
    1. Alugar um livro:
        a. Leia as informacoes de um novo aluguel;
        b. Caso ja exista uma reserva do mesmo cliente, o programa deve mostrar uma mensagem de erro e nao armazenar este aluguel;
        c. caso contrario, deve armazenar o aluguel e exibir o custo deste aluguel, que deve ser calculado baseado na data atual, data de entrega do livro e preço por diaria;
    2. Verificar livros em atraso:
        a. Compara a data de entrega com a data atual para todos os alugueis armazenados;
        b. Caso o aluguel esteja em atraso, imprima o ID do cliente, nome do livro e o valor da multa;
        c. O valor da multa deve ser calculado baseado no número de dias em atraso e no preço do livro por diária;
    3. Imprimir todos os algueis:
        a. Imprima o ID do cliente, nome do livro e data de entrega de todos os alugueis armazenados. */

#include <stdio.h>
#include <stdlib.h>
#define MAXALUGUEL 10

// definição da estrutura ALUGUEL
typedef struct {
    int idCliente; // inteiro - id do cliente
    char nomeLivro[50]; // string - nome do livro
    int diaEntrega; // inteiro - dia de entrega
    int mesEntrega; // inteiro - mes de entrega
    float precoDiaria; // real - preço por diária
} ALUGUEL;

// FUNÇÕES

// função para alugar um livro
void alugarLivro(ALUGUEL alugueis[], int *qtdAlugueis){
    int i = 0; // contador
    int idCliente; // id do cliente
    char nomeLivro[50]; // nome do livro
    int diaEntrega; // dia de entrega
    int mesEntrega; // mes de entrega
    float precoDiaria; // preço por diária
    int existe = 0; // variável para verificar se o cliente já possui um aluguel

    // recebe as informações do novo aluguel
    printf("Insira o ID do cliente: ");
    scanf("%d", &idCliente);
    printf("Insira o nome do livro: ");
    scanf(" %[^\n]", nomeLivro);
    printf("Insira o dia de entrega: ");
    scanf("%d", &diaEntrega);
    printf("Insira o mes de entrega: ");
    scanf("%d", &mesEntrega);
    printf("Insira o preco por diaria: ");
    scanf("%f", &precoDiaria);

    // verifica se o cliente já possui um aluguel
    for(i = 0; i < *qtdAlugueis; i++){
        if(alugueis[i].idCliente == idCliente){
            existe = 1;
            break;
        }
    }

    // caso o cliente não possua um aluguel, armazena o novo aluguel
    if(existe == 0){
        alugueis[*qtdAlugueis].idCliente = idCliente;
        strcpy(alugueis[*qtdAlugueis].nomeLivro, nomeLivro);
        alugueis[*qtdAlugueis].diaEntrega = diaEntrega;
        alugueis[*qtdAlugueis].mesEntrega = mesEntrega;
        alugueis[*qtdAlugueis].precoDiaria = precoDiaria;
        *qtdAlugueis += 1;
        printf("Aluguel realizado com sucesso!\n");
        printf("Custo do aluguel: %.2f\n", (diaEntrega * precoDiaria));
    } else {
        printf("Erro: Cliente ja possui um aluguel\n");
    }
}

// imprime as informações de um cliente
void imprimeCliente(ALUGUEL alugueis[], int qtdAlugueis){
    int i = 0; // contador

    // imprime todos os alugueis armazenados
    for(i = 0; i < qtdAlugueis; i++){
        printf("ID do cliente: %d\n", alugueis[i].idCliente);
        printf("Nome do livro: %s\n", alugueis[i].nomeLivro);
        printf("Data de entrega: %d/%d\n", alugueis[i].diaEntrega, alugueis[i].mesEntrega);
    }
}

// verificar livros em atraso
void verificarLivrosAtraso(ALUGUEL alugueis[], int qtdAlugueis){
    int i = 0; // contador
    int diaAtual, mesAtual; // dia e mes atuais
    int diasAtraso; // dias de atraso
    float multa; // valor da multa

    // recebe a data atual
    printf("Insira o dia atual: ");
    scanf("%d", &diaAtual);
    printf("Insira o mes atual: ");
    scanf("%d", &mesAtual);

    // compara a data de entrega com a data atual
    for(i = 0; i < qtdAlugueis; i++){
        if(alugueis[i].mesEntrega == mesAtual){
            diasAtraso = diaAtual - alugueis[i].diaEntrega;
            if(diasAtraso > 0){
                multa = diasAtraso * alugueis[i].precoDiaria;
                printf("ID do cliente: %d\n", alugueis[i].idCliente);
                printf("Nome do livro: %s\n", alugueis[i].nomeLivro);
                printf("Valor da multa: %.2f\n", multa);
            }
        }
    }
}

// FUNÇÃO PRINCIPAL

int main(){
    ALUGUEL alugueis[MAXALUGUEL]; // vetor de alugueis
    int qtdAlugueis = 0; // quantidade de alugueis armazenados
    int opcao; // opção do menu

    // menu
    do {
        printf("1. Alugar um livro\n");
        printf("2. Verificar livros em atraso\n");
        printf("3. Imprimir todos os alugueis\n");
        printf("4. Sair\n");
        printf("Escolha uma opcao: ");
        scanf("%d", &opcao);

        // escolha da opção
        switch(opcao){
            case 1:
                alugarLivro(alugueis, &qtdAlugueis);
                break;
            case 2:
                verificarLivrosAtraso(alugueis, qtdAlugueis);
                break;
            case 3:
                imprimeCliente(alugueis, qtdAlugueis);
                break;
            case 4:
                printf("Saindo...\n");
                break;
            default:
                printf("Opcao invalida.\n");
        }
    } while(opcao != 4);

    return 0;
}
