# Luiza Souto
# 31/05/2026
# python3 1799-bfs.py < 1799-test.txt || python3 1799-bfs.py < 1799-test2.txt -> testes

from collections import deque

n, e = map(int, input().split()) # n -> nodes | e -> edges

graph = {}

for _ in range(e):
    u, v = input().split()
    
    if u not in graph:
        graph[u] = []
    if v not in graph:
        graph[v] = []
    
    # preenche o grafo
    graph[u].append(v)
    graph[v].append(u)
    
def bfs(s):
    dist = {s: 0} # guarda distancias e se nodo ja foi visitado
    
    queue = deque([s])
    
    while queue:
        n = queue.popleft()
        
        for vizinho in graph.get(n, []):
            if vizinho not in dist:
                dist[vizinho] = dist[n] + 1
                queue.append(vizinho)
    
    return dist

# distancia da entrada ate o queijo ('*')
dist_entrada = bfs("Entrada")
dist_to_queijo = dist_entrada.get("*", float('inf'))

# distancia do queijo ate a saida
dist_from_queijo = bfs("*")
dist_saida = dist_from_queijo.get("Saida", float('inf'))

answer = dist_to_queijo + dist_saida

if answer == float('inf'):
    print(-1)
else:
    print(answer)