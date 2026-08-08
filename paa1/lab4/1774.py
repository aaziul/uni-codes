# Luiza Souto
# 20/05/2026

from typing import Dict, List, Tuple

class UnionFind:
    """Estrutura de dados Union-Find (Disjoint Set Union) para auxiliar o algoritmo de Kruskal."""

    def __init__(self, num_rot: int):
        """Inicializa a estrutura Union-Find com os elementos fornecidos.
            O(n), onde n é o número de elementos.
        """
        self.parent = list(range(num_rot))  # Cada elemento é inicialmente seu próprio pai (representante do conjunto)
        self.rank = [0] * num_rot    # Rank para otimizar a união dos conjuntos

    def find(self, v: int) -> int:
        """Encontra o representante do conjunto ao qual o elemento v pertence, aplicando compressão de caminho.
            Amortizado O(α(n)), onde α é a função inversa de Ackermann, que cresce muito lentamente e é praticamente constante para todos os valores de n encontrados na prática.
        """
        if self.parent[v] != v:
            self.parent[v] = self.find(self.parent[v])  # Path compression
        return self.parent[v]
    
    def union(self, u, v):
        """Une os conjuntos aos quais os elementos u e v pertencem, utilizando a técnica de união por rank.
            Amortizado O(α(n)), onde α é a função inversa de Ackermann, que cresce muito lentamente e é praticamente constante para todos os valores de n encontrados na prática.
        """
        root_u = self.find(u)
        root_v = self.find(v)
        if root_u != root_v:
            if self.rank[root_u] > self.rank[root_v]:
                self.parent[root_v] = root_u
            elif self.rank[root_u] < self.rank[root_v]:
                self.parent[root_u] = root_v
            else:
                self.parent[root_v] = root_u
                self.rank[root_u] += 1

def kruskal(num_rot: int, edges: List[Tuple[int, int, int]]) -> int:
    """Algoritmo de Kruskal para encontrar o custo da árvore geradora mínima de um grafo valorado.

    Complexidade: O(|E| log |E|) devido à ordenação das arestas, onde E é o conjunto de arestas no grafo.
    
    Returns:
        O custo total da árvore geradora mínima.
    """
    # Criar uma lista de todas as arestas do grafo
    # edges = []
    # for node, neighbors in graph.items():
    #     for neighbor, weight in neighbors:
    #         if (neighbor, node, weight) not in edges:  # Evitar duplicatas
    #             edges.append((node, neighbor, weight))
    
    disjoint_set = UnionFind(num_rot)
    
    # Ordenar as arestas pelo peso
    edges.sort(key=lambda x: x[2])
    
    mst_edges = 0 
    custo = 0  # Variável para acumular o custo total da árvore geradora mínima

    for u, v, weight in edges:
        if disjoint_set.find(u) != disjoint_set.find(v):  # Verificar se os nodos u e v estão em conjuntos disjuntos
            disjoint_set.union(u, v)
            
            custo += weight
            mst_edges += 1

            if mst_edges == num_rot - 1:  # A árvore geradora mínima terá exatamente |V| - 1 arestas
                break

    return custo


start = input().split()

num_roteadores = int(start[0])
num_arestas = int(start[1])
arestas = []

for _ in range(num_arestas):
    u, v, peso = map(int, input().split())
    arestas.append((u - 1, v - 1, peso))

# custo total
resultado = kruskal(num_roteadores, arestas)
print(resultado)