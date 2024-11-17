# funcao para comparar strings, retorna diferenca de tamanho
def comparaString(a, b):
    return len(b) - len(a)

# funcao de ordenacao por insertion sort
def insertionSort(vetor):
    for i in range(1, len(vetor)):
        k = i # k eh o indice do elemento atual que sera comparado
        j = k - 1 # j eh o indice do elemento anterior ao atual

        #enquanto o indice for valido e a comparacao indicar que precisa trocar
        while j > -1 and comparaString(vetor[k], vetor[j]) < 0:
            vetor[k], vetor[j] = vetor[j], vetor[k] # troca os elementos
            k -= 1 # decrementa k e
            j -= 1 # decrementa j, para continuar verifcando

N = int(input()) # numero de casos de teste

# loop para cada caso de teste
for _ in range(N):
    palavras = input().strip().split(' ') # divide a linha de entrada em palavras
    insertionSort(palavras) # ordena as palavras
    print(' '.join(palavras)) # imprime as palavras ordenadas
