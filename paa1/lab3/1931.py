# Luiza Souto
# 08/05/2026
import heapq

# No Linux, execute "python3 1931.py < 1931-test2.txt" para testar o código com o arquivo de teste.

# Você precisa modificar o algoritmo de dijkstra abaixo para resolver o problema!
def dijkstra(graph, source):
    """
    Dijkstra O((|E| + |V|) log |V|) com heap binário.

    Parâmetros:
      graph: dicionário (lista de adjacência) representando grafo valorado com arestas não-negativas.
      source: nó de origem.

    Retorna:
      dist: dicionário com a menor distância da origem para cada nó.
            Para nós inalcançáveis, distância = float('inf').
      parent: dicionário com o predecessor imediato no caminho mínimo
              (None para a origem e para nós inalcançáveis).
    """

    # Inicialização
    processado = {v : [False, False] for v in graph.keys()}  # para marcar nós processados, impares e pares
    dist = {v : [float('inf'), float('inf')] for v in graph.keys()}
    parent = {v : [None, None] for v in graph.keys()}

    dist[source][0] = 0  # Origem começa com distância zero, em par 
    dist[source][1] = 0 # em impar

    fila = [(0.0, source, 0)]

    while fila:  # enquanto fila não for vazia
        du, u, state = heapq.heappop(fila)  # extrai nodo com menor distância na fila e seu estado
    
        if processado[u][state]:
            continue
        processado[u][state] = True

        for v, wv in graph[u]:    # para cada vizinho v de u
            novo_state = 1 - state # inverte 0 pra 1 ou 1 pra 0
            novo_dv = du + wv     # distância até u mais peso da aresta u-v
            if novo_dv < dist[v][novo_state]: # se distância no novo estado menor que a atual
                dist[v][novo_state] = novo_dv
                parent[v][novo_state] = u
                heapq.heappush(fila, (novo_dv, v, novo_state))  # coloca v na fila com sua distância atual da origem e novo estado

    return dist


n, m = (int(x) for x in input().split())
graph = {i : [] for i in range(1, n + 1)}
for _ in range(m):
    a, b, w = (int(x) for x in input().split())
    
    # Preencha o grafo
    graph[a].append((b, w))
    graph[b].append((a, w))

dist = dijkstra(graph, 1)

# Imprima a resposta
res = dist[n][0]

if res == float('inf'):
    print(-1)
else:
    print(int(res))