# Luiza Souto
# 09/04/2026

from collections import deque

def bipartite(g):
  """Teste de Bipartição usando BFS"""
  cor = {}  # vetor de cores (1 e 0)
  visited = {i: False for i in g.keys()}

  for x in g.keys(): # escolhe um nodo x por componente
    if not visited[x]:                   
      queue = deque([x]) # inicia a BFS em x
      cor[x] = 1         # atribui cor 1 a x
      visited[x] = True  # marca x como visitado
      while len(queue) > 0:
        i = queue.popleft()
        for j in g[i]:
          if visited[j] and cor[i] == cor[j]:
            return False  # achou ciclo ímpar
          elif not visited[j]:
            queue.append(j)
            visited[j] = True
            cor[j] = 1 - cor[i]  # atribui cor inversa

  return True  # não há ciclo ímpar

####

n = int(input())
while n != 0:

    graph = {i : [] for i in range(1, n+1)}
    for _ in range(n):
        id = int(input())
        vizinhos = [int(x) for x in input().split()]
        # preenche o grafo
        for nodo in vizinhos:
            graph[id].append(nodo)
            graph[nodo].append(id)

    if bipartite(graph):
      resposta = "SIM"
    else:
      resposta = "NAO"
    
    print(resposta)

    n = int(input())