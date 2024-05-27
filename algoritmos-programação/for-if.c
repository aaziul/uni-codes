#include <stdio.h>
#include <math.h>

int main(){
   /* Exercício 1: Escreva um programa que leia do teclado dois valores inteiros positivos. Seu programa deve, como resultado, exibir todos os numeros primos entre os valores informados (incluindo os extremos do intervalo), alem da soma desses valores. A ordem dos numeros de entrada pode ser tanto crescente quanto decrescente. Se nao houver numeros primos no intervalo solicitado, informar o usuario. */

  int valor1 = 0, valor2 = 0, aux = 0, soma = 0;

  printf("Entre com dois valores: \n");
  scanf("%d 5d", &valor1, &valor2);

  if(valor1>valor2){
        aux = valor1;
        valor1 = valor2;
        valor2 = aux;
    }

  printf("\nNumeros primos entre %d e %d: ", valor1, valor2);

    for(int i = valor1+1; i < valor2; i++){
        aux = 0;
        for(int j = 1; j <= i; j++){
            if(i % j == 0){
                aux++;
            }
        }

        if(aux<3){
            printf("%d ", i);
            soma += i;
        }
    }

    printf("\n");
    printf("Soma dos numeros primos: %d\n", soma);

//#################################################################################################################################################
  
 /* EXERCICIO 2: Queremos analisar o resultado de uma entrevista onde foram coletados os seguintes dados de
diversas pessoas: idade, sexo (M ou F), e salario mensal. Escreva um programa que inicialmente
leia do teclado o numero de pessoas entrevistadas, e a seguir leia os dados (idade, sexo e salario)
da cada uma. Ao final, o programa deve informar:
- A media de idade das pessoas entrevistadas (com uma casa decimal)
- A quantidade de pessoas que recebe menos do que R$ 2.000,00
- O numero total de mulheres entrevistadas */

    int idade, numPessoas, salario, i, n = 1, quantF, quantS, somaIdades;
    float mediaIdade;
    char genero;
    somaIdades = 0;
    quantF = 0;

    printf("Entre o numero de pessoas entrevistadas: ");
    scanf("%d", &numPessoas);

    for (i = numPessoas; n <= i; n++){
        printf("Idade da pessoa %d: ", n);
        scanf("%d", &idade);

        printf("Sexo da pessoa %d: ", n);
        scanf(" %c", &genero);

        printf("Salario da pessoa %d: ", n);
        scanf("%d", &salario);

        if (genero == 'f'){
            quantF++; // acumula genero F
        }

        somaIdades = somaIdades + idade; // acumula idades lidas
        quantS = salario < 2000; // calcula salarios menores de 2000
    }

    mediaIdade = (float) somaIdades/numPessoas;

    printf("\nA media das idades foi de %.1f anos.", mediaIdade);

    printf("\nA quantidade de pessoas que recebe menos do que 2000 reais eh: %d", quantS);

    printf("\nO total de mulheres entrevistadas foi: %d", quantF);


    return 0;
}
