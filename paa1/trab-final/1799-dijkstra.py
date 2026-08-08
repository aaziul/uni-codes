# Luiza Souto
# 31/05/2026
# python3 1799-dijkstra.py < 1799-test.txt || python3 1799-dijkstra.py < 1799-test2.txt -> testes

import heapq
from collections import defaultdict

n, e = map(int, input().split()) # n -> nodes | e -> edges

graph = defaultdict(list)

for _ in range(e):
    u, v = input().split()
    
    graph[u].append((v, 1))
    graph[v].append((u, 1))
    
def dijkstra(start):
    dist = {node: float('inf') for node in graph} # distancias inicializadas como inf
    dist[start] = 0
    
    pq = [(0, start)] # fila de prioridade
    
    while pq:
        custo, n = heapq.heappop(pq)
        
        # ignora se ja encontramos caminho menor
        if custo > dist.get(n, float('inf')):
            continue
        
        for vizinho, weight in graph[n]:
            if dist.get(vizinho, float('inf')) > custo + weight:
                dist[vizinho] = custo + weight
                heapq.heappush(pq, (dist[vizinho], vizinho))
    
    return dist

# distancia da entrada ate o queijo ('*')
dist_entrada = dijkstra("Entrada")
dist_to_queijo = dist_entrada.get("*", float('inf'))

# distancia do queijo ate a saida
dist_from_queijo = dijkstra("*")
dist_saida = dist_from_queijo.get("Saida", float('inf'))

answer = dist_to_queijo + dist_saida

if answer == float('inf'):
    print(-1)
else:
    print(int(answer))