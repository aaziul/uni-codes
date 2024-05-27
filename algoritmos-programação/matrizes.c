//OBJETIVO: receber o tamanho do arranjo e apos ler os elementos do arranjo. Depois chamar a funcao e imprimir na tela o arranjo (com duas casas decimais) e a quantidade de elementos modificados

#include <stdio.h>
#include <math.h>
#define TAMMAX 50

int GeraVetorPositivo(float *vet1, float *vet2, int tam){
    int cont = 0, trocados = 0;

    for (cont = 0; cont < tam; cont++){
        if (vet1[cont] < 0){
            trocados++;
        }
        vet2[cont] = fabs(vet1[cont]);
    }

    return trocados;
}

int main(){
    float arranjo[TAMMAX], arranjo2[TAMMAX];
    int tam, i = 0, trocados;

    //recebe o tamanho do arranjo
    printf("Entre com o tamanho do arranjo (no maximo %d): ", TAMMAX);
    scanf("%d", &tam);

    //se t menor que TAMMAX, realiza a leitura dos valores
    if(tam < TAMMAX){
        printf("Entre os elementos do arranjo: ");
        for(i = 0; i < tam; i++){
            scanf("%f", &arranjo[i]);
        }
    } else { //senao, avisa que o valor informado ultrapassou o valor maximo
        printf("Valor informado maior que o tamamnho maximo!");
    }

    //atribui a variavel trocados a funcao GeraValorPositivo
    trocados = GeraVetorPositivo(arranjo, arranjo2, tam);

    //imprime os elementos processados
    printf("Elementos do arranjo processado: ");
    for(i = 0; i < tam; i++){
        printf("%.2f", arranjo2[i]);
    }

    //imprime a quantidade de elementos trocados
    printf("\nNumero de elementos trocados: %d", trocados);

    return 0;
}
