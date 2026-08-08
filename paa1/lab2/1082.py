# not finished !!!
# Luiza Souto
# 09/04/2026

N = int(input())

alpha = "abcdefghijklmnopqrstuvwxyz"

def componentes(g):
    """Componentes conexos em grafos simples via DFS."""
    def dfs(g, node, visited, comp, c):
        visited[node] = True
        comp[node] = c
        for v in g[node]:
            if not visited[v]:
                dfs(g, v, visited, comp, c)

    comp = {}
    c = 0
    visited = {i : False for i in g.keys()}
    for n in g.keys():
        if not visited[n]:
            dfs(g, n, visited, comp, c)
            c += 1

    return comp

for i in range(1, N + 1):
    n, m = (int(x) for x in input().split())
    graph = {i : [] for i in alpha[:n]}  # grafo contendo n nodos (a partir da letra "a")
    for _ in range(m):
        a, b = (x for x in input().split())

        # TODO: preencha o grafo
        graph[a].append(b)
        graph[b].append(a)

    components = componentes(graph)
    c = len(components)

    print(f"Case #{i}:")
    for nc in range(c):  
        nodes = [] # nodos do componente c
        nodes = sorted(nodes)  # ordena em ordem alfabética
        for a in nodes:
            print(f"{a},", end="")
        print()
    print(f"{c} connected components")
    print()