// limpa variável
operation clear(A){
    1: if zero A then goto 0 else goto 2
    2: do dec A goto 1
}

   // A := A + B (soma destrutiva)
operation soma(A,B){
    1: if zero B then goto 0 else goto 2
    2: do dec B goto 3
    3: do inc A goto 1
}

   // A := A + B (soma não-destrutiva)
operation somaNdestrutiva(A,B,C){
    1: if zero B then goto 5 else goto 2
    2: do dec B goto 3
    3: do inc A goto 4
    4: do inc C goto 1
    5: if zero C then goto 0 else goto 6
    6: do dec C goto 7
    7: do inc B goto 5
}

   // A := B (cópia não-destrutiva)
operation load(A,B,C){
    1: do clear(A) goto 2
    2: do somaNdestrutiva(A,B,C) goto 0
}

   // C := A - B (sem negativos)
operation subtrai(A,B,C){
    1: do load(C,A,D) goto 2
    2: if zero B then goto 0 else goto 3
    3: do dec C goto 4
    4: do dec B goto 2
}

   // C := A * B
operation multiplica(A,B,C){
    1: do clear(C) goto 2
    2: if zero B then goto 0 else goto 3
    3: do dec B goto 4
    4: do soma(C,A) goto 2
}

   // B := A!
operation fatorial(A,B,C,D){
    1: do clear(B) goto 2
    2: do inc B goto 3
    3: do load(C,A,D) goto 4
    4: if zero C then goto 0 else goto 5
    5: do dec C goto 6
    6: do multiplica(B,C,B) goto 4
}

   // C := A / B (divisão inteira)
operation divide(A,B,C,D,E){
    1: do clear(C) goto 2
    2: do load(D,A,E) goto 3
    3: do subtrai(D,B,D) goto 4
    4: if zero D then goto 0 else goto 5
    5: do inc C goto 2
}

   // registrador X contém o valor de n
// resultado do somatório será armazenado em X ao final

main {
    // S := 0 (acumulador do somatório)
    1: do clear(S) goto 2
    // K := 0 (contador do somatório)
    2: do clear(K) goto 3

    // LOOP: se K > X, encerra
    3: do subtrai(K,X,AUX) goto 4
    4: if zero AUX then goto 5 else goto 20

    // N1 := X, K1 := K
    5: do load(N1,X,AUX) goto 6
    6: do load(K1,K,AUX) goto 7

    // NK := N1 - K1
    7: do subtrai(N1,K1,NK) goto 8

    // F1 := N1!
    8: do fatorial(N1,F1,AUX,AUX2) goto 9
    // F2 := K1!
    9: do fatorial(K1,F2,AUX,AUX2) goto 10
    // F3 := NK!
    10: do fatorial(NK,F3,AUX,AUX2) goto 11

    // D := F2 * F3 (denominador)
    11: do multiplica(F2,F3,D) goto 12

    // C := F1 / D
    12: do divide(F1,D,C,AUX,AUX2) goto 13

    // S := S + C
    13: do soma(S,C) goto 14

    // K := K + 1
    14: do inc K goto 3

    // Fim do loop, resultado no acumulador S → copia para X
    20: do load(X,S,AUX) goto 0
}
