//OBJETIVO: solicitar a leitura dos dados do paralelogramo e se algum dos valores informados or um número negativo, a função devolve -1, senão, a fução devolve o valor do perimetro e da área do paralelogramo

#include <stdio.h>
#include <math.h>
//#define PI 3.141592

//função para calcular a área e o perimetro do parlelogramo
float paralelogramo (float a, float b, float ang, float *area){
    float perimetro;

    //se valor recebido for negativo, devolve -1
    if ((a < 0) || (b < 0) || (ang < 0)){
        return -1;
    } else { //senão, devolve o calculo da area e do perimetro
        *area = a * b * sin(((ang * M_PI)/180));
        perimetro = (2 * a) + (2 * b);
        return perimetro;
    }
}

int main(){
    float a, b, angulo, area, resultado;

    //leitura dos dados
    printf("Entre os lados do paralelogramo e o angulo (em graus): ");
    scanf("%f%f%f", &a, &b, &angulo);

    //atribui a função paralelogramo à variavel resultado
    resultado = paralelogramo(a, b, angulo, &area);

    //imprime na tela os resultados
    printf("Area: %f", area);
    printf("\nPerimetro: %f", resultado);

    return 0;
}
