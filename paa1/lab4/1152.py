# No Linux, execute "python3 1152.py < test.txt" para testar o código com o arquivo de teste.
# Luiza Souto
# 21/05/2026
from typing import Dict, List, Tuple

class UnionFind:
    """Estrutura de dados Union-Find (Disjoint Set Union) para auxiliar o algoritmo de Kruskal."""

    def __init__(self, elements: List[str]):
        """Inicializa a estrutura Union-Find com os elementos fornecidos.
            O(n), onde n é o número de elementos.
        """
        self.parent = {v: v for v in elements}  # Cada elemento é inicialmente seu próprio pai (representante do conjunto)
        self.rank = {v: 0 for v in elements}    # Rank para otimizar a união dos conjuntos

    def find(self, v):
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

############################

def kruskal(graph: Dict[str, List[Tuple[str, int]]]) -> List[Tuple[str, str, int]]:
    """Algoritmo de Kruskal para encontrar a árvore geradora mínima de um grafo valorado.

    Complexidade: O(|E| log |E|) devido à ordenação das arestas, onde E é o conjunto de arestas no grafo.
    
    Args:
        graph: Grafo valorado representado como um dicionário de adjacências.
    
    Returns:
        O custo total da árvore geradora mínima e uma lista de arestas (u, v, peso) que compõem a árvore geradora mínima.
    """
    # Criar uma lista de todas as arestas do grafo
    edges = []
    custo_total = 0

    for node, neighbors in graph.items():
        for neighbor, weight in neighbors:
            #if (neighbor, node, weight) not in edges:  # Evitar duplicatas
            edges.append((node, neighbor, weight))
    
    for i in edges:
        custo_total += i[2]

    # Ordenar as arestas pelo peso
    edges.sort(key=lambda x: x[2])
    
    disjoint_set = UnionFind(list(graph.keys()))
    #mst_edges = []  # Lista para armazenar as arestas da árvore geradora mínima
    custo = 0  # Variável para acumular o custo total da árvore geradora mínima
    num_edges = 0  # Contador para o número de arestas adicionadas à árvore geradora mínima

    for u, v, weight in edges:
        if disjoint_set.find(u) != disjoint_set.find(v):  # Verificar se os nodos u e v estão em conjuntos disjuntos
            disjoint_set.union(u, v)
            #mst_edges.append((u, v, weight))

            custo += weight
            num_edges += 1

            if num_edges == len(graph.keys()) - 1:  # A árvore geradora mínima terá exatamente |V| - 1 arestas
                break

    return custo, custo_total

############################

while True:
    m, n = map(int, input().split()) # m -> número de junções de Byteland | n -> úmero de estradas em Byteland
    graph = {i : [] for i in range(0, m)}

    if m == 0 and n == 0:
        break

    for _ in range(n):
        x, y, z = map(int, input().split())
        graph[x].append((y, z))
        # graph[y].append((x, z))

    # Complete com o seu código
    # ...

    agm, custo_total = kruskal(graph)

    answer = custo_total - agm

    print(answer)
