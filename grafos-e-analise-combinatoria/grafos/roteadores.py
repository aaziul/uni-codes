def kruskal(num_roteadores, arestas):
    # Estrutura Union-Find
    pai = list(range(num_roteadores))
    rank = [0] * num_roteadores
    
    def encontrar(x):
        if pai[x] != x:
            pai[x] = encontrar(pai[x])
        return pai[x]
    
    def unir(x, y):
        raizX = encontrar(x)
        raizY = encontrar(y)
        if raizX != raizY:
            if rank[raizX] > rank[raizY]:
                pai[raizY] = raizX
            elif rank[raizX] < rank[raizY]:
                pai[raizX] = raizY
            else:
                pai[raizY] = raizX
                rank[raizX] += 1
    
    # Ordena as arestas pelo custo
    arestas.sort(key=lambda x: x[2])
    
    custo_mst = 0
    arestas_usadas = 0
    
    for u, v, custo in arestas:
        if encontrar(u) != encontrar(v):
            unir(u, v)
            custo_mst += custo
            arestas_usadas += 1
            if arestas_usadas == num_roteadores - 1:
                break
    
    return custo_mst

# Leitura da entrada
import sys
entrada = sys.stdin.read
dados = entrada().split()

num_roteadores = int(dados[0])
num_arestas = int(dados[1])
arestas = []

indice = 2
for _ in range(num_arestas):
    roteador1 = int(dados[indice]) - 1
    roteador2 = int(dados[indice + 1]) - 1
    custo = int(dados[indice + 2])
    arestas.append((roteador1, roteador2, custo))
    indice += 3

# Calcula o custo total da MST
resultado = kruskal(num_roteadores, arestas)
print(resultado)
