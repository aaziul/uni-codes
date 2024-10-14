# DESAFIO BEECROWD 1088 - Problema Bubbles and Buckets
class ArvoreFenwick:
    def __init__(self, tamanho):
        self.tamanho = tamanho
        self.arvore = [0] * (tamanho + 1)

    def atualizar(self, indice, delta):
        while indice <= self.tamanho:
            self.arvore[indice] += delta
            indice += indice & -indice

    def consulta(self, indice):
        soma = 0
        while indice > 0:
            soma += self.arvore[indice]
            indice -= indice & -indice
        return soma

def contar_inversoes(arr):
    max_valor = len(arr)
    arvore_fenwick = ArvoreFenwick(max_valor)
    contador_inversoes = 0

    for i in range(max_valor - 1, -1, -1):
        contador_inversoes += arvore_fenwick.consulta(arr[i] - 1)  
        arvore_fenwick.atualizar(arr[i], 1) 

    return contador_inversoes

def principal():
    import sys

    entrada = sys.stdin.read
    dados = entrada().strip().splitlines()

    resultados = []
    for linha in dados:
        if linha == "0":
            break

        numeros = list(map(int, linha.split()))
        N = numeros[0]
        P = numeros[1:]  

        inversoes = contar_inversoes(P)

        if inversoes % 2 == 1:
            resultados.append("Marcelo") 
        else:
            resultados.append("Carlos")   


    print("\n".join(resultados))

if __name__ == "__main__":
    principal()
