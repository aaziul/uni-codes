// OBJETIVO: receber um valor real x e um caractere (S ou P), se o caractere for S realiza a soma de raízes até o número recebido . Se caratere for P realiza a soma de potências até o valor informado

#include <stdio.h>
#include <math.h>
#define p 2

//realiza a soma das raízes
float somaDeRaizes(float x){
    int i = 0;
    float somaRaizes = 0, T = 0;

    while (T + pow(i, (1.0 / p)) <= fabs(x)){
        somaRaizes += pow(i, (1.0 / p));
        T = somaRaizes;
        i++;
    }

    return somaRaizes;
}

//realiza a soma das potencias
float somaDePotencias(float x){
    int i = 0;
    float somaPotencias = 0, T = 0;

    while(T + pow(i, p) <= fabs(x)){
        somaPotencias += pow(i, p);
        T = somaPotencias;
        i++
    }

    return somaPotencias;
}

//função para verificar caractere recebido e informar o resultado das operações de soma de potencias e raizes
char verificaCaractere(char caract, float valorReal){

    if((caract == 'P') || (caract == 'p')){
        printf("O valor retornado eh %f", somaDePotencias(valorReal));
    } else if ((caract == 'S') || (caract == 's')){
        printf("O valor retornado eh %f", somaDeRaizes(valorReal));
    } else {
        printf("Caractere invalido!");
    }

}

int main(){
    float valorReal;
    char caractere;

    //recebe o valor de x
    printf("Entre com o valor x: \n");
    scanf("%f", &valorReal);

    //recebe o caractere
    printf("Entre com P para funcao potencia ou S para funcao raiz: ");
    scanf(" %c", &caractere);

    verificaCaractere(caractere, valorReal);

    return 0;
}
