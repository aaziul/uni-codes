//OBJETIVO: receber uma quantidade indefinida de numeros reais no intervalo [-10, 10], um valor fora deste intervalo indica encerramento do programa, e armazenar em um arranjo. Após calular (a) média µ dos valores informados (com 4 casas decimais); (b) desvio padrão σ dos valores informados (com 4 casas decimais); (c)quantidade de valores situados a uma distância menor do que um desvio padrão da média, ou seja, valores x tais que |x − µ| < σ

#include <stdio.h>
#include <math.h>
#define MAXLIDOS 50


int main(){

    int i = 0, j = 0, k = 0, contador = 0;
    float valores[MAXLIDOS];
    float soma = 0, media = 0, somatorio = 0, desvioPadrao = 0;

    //recebe os valores
    printf("Entre os valores: ");
    scanf("%f", &valores[0]);

    //enquanto os valores estiverem no intervalo indicado, é realizado a soma dos valores
    while ((10 >= valores[i]) && (valores[i] >= -10)){
        scanf("%f", &valores[i+1]);
        soma += valores[i];
        i++;
    }

    //realiza a media dos valores e imprime
    media = soma / i;

    printf("Media dos valores: %.4f", media);

    //realiza o somatorio
    for(j = 0; j < i; j++){
        somatorio = somatorio + pow((valores[j] - media), 2);
    }

    //calcula o desvio padrao e imprime
    desvioPadrao = sqrt (somatorio/i);

    printf("\n Desvio Padrao: %.4f", desvioPadrao);

    //calcula quantos valores estao perto da media e imprime
    for (k = 0; k < i; k++){
        if (fabs(valores[k] - media) < desvioPadrao){
            contador++;
        }
    }

    printf("\nQuantidade de valores perto da media: %d", contador);

    return 0;

}
