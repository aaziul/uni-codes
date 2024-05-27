//OBJETIVO: calcular o logaritmo natural de um numero real com N numeros de termos, usando dois digitos após a virgula

#include <stdio.h>
#include <math.h>

//calcula o logaritmo natural de acordo com os valores recebidos
float calc_logaritmoNatural(float x, int N){
    int i = 0;
    float logaritmo = 0.0;

    //realiza somatorio de aproximação de logaritmo
    for (i = 1; i <= N; i++){
        logaritmo += (1.0 / i) * pow(((x - 1) / x), i);
    }

    return logaritmo;
}

int main(){
    int termos;
    float valorReal, log;

    //recebe valores x e N
    printf("Entre com o valor real x e o numero de termos N: ");
    scanf("%f %d", &valorReal, &termos);

    log = calc_logaritmoNatural(valorReal, termos); //aplica a função em uma variável

    //imprime o logaritmo natural
    printf("O logaritmo natural de %.2f eh %.2f", valorReal, log);

    return 0;
}
