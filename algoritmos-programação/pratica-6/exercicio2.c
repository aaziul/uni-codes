//OBJETIVO: criar um programa que simule strcpy. O programa deve ler do teclado uma string s1, com tamanho máximo de TAMSTRING1 caracteres, e copiar este string para outra string s2, com tamanho máximo de TAMSTRING2 caracteres.

#include <stdio.h>
#include <string.h>
#define TAMSTRING1 20
#define TAMSTRING2 12

int main(){
    int i, contador = 0;
    char s1[TAMSTRING1 + 1];
    char s2[TAMSTRING2 + 1];

    printf("String a ser copiada (maximo de 20 caracteres): ");
    fgets(s1, TAMSTRING1 + 1, stdin);
    s1[strlen(s1) - 1] = '\0';

    for (i = 0; (i < TAMSTRING2) && (s1[i] != '\0'); i++){
        s2[i] = s1[i];
        contador++;
    }

    s2[i] = '\0';

    printf("\nString copiada: %s", s2);

    if (contador>=12){
        printf ("\nA string foi truncada!");
    }

    return 0;
}
