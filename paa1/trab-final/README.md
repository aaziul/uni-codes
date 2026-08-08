# Problema 1 – O Rato no Labirinto (beecrowd 1799)

## Descrição do Problema

Recebendo de entrada o desenho do labirinto e a posição do queijo, precisamos determinar a quantidade mínima de pontos marcados por letras do alfabeto que o rato IBO deve passar para pegar o queijo e sair, partindo sempre do ponto "Entrada" e terminando em "Saida".

## Estratégia da Solução

O problema consiste em encontrar o menor caminho partindo de um ponto inicial ("Entrada"), passando por um ponto intermediário obrigatório (queijo "*") e chegar em um ponto final ("Saida"). Como as arestas deste labirinto tem sempre o mesmo custo (custo 1), o problema se torna encontrar o menor caminho de um grafo não ponderado. Para isso, utilizamos um BFS partindo do ponto inicial, "Entrada", para calcular a menor distância até o queijo, "*". Em seguida, outra busca em largura calculando a menor distância partindo do queijo, "*", até o ponto final, "Saida". A resposta final é a soma destas duas distâncias mínimas.

Inicialmente foi considerado utilizar o algoritmo de Dijkstra para caminhos mínimos, porém como o grafo possui arestas de peso 1, o uso de Fila de Prioridade adicionaria custo no código, então utilizamos a Busca em Largura pois sempre que um nodo é alcançado, o algoritmo sempre retorna o menor caminho possível, reduzindo a complexidade de tempo do código. Foi utilizado `deque` em vez de lista padrão pois no algoritmo de busca precisamos remover constantemente o primeiro elemento da fila; utilizando uma lista, em Python, a complexidade seria maior (O(n)), utilizando `deque`, a complexidade diminui para tempo constante (O(1)).

## Argumento de Correção

### Por que o algoritmo sempre produz uma solução válida

Considerando que o labirinto do problema é representado por um grafo não direcionado G = (V, E), onde V são os vértices e E o conjunto de arestas, o custo para atravessar qualquer aresta é o mesmo, então podemos definir uma função de peso w(e) = 1 para todo e pertencente ao conjunto E.

A Busca em Largura (BFS) é comprovada como o algoritmo exato para encontrar o caminho mínimo nestas condições. A demonstração de sua corretude é feita através da exploração de camadas: o vértice de origem *s* é visitado na camada L0 com distância d = 0; todos os vértices adjacentes a *s* são inseridos na fila e visitados na camada L1 com distância d = 1; indutivamente, um vértice *v* descoberto a partir de um vértice *u* na camada Lk será atribuído à camada Lk+1, registrando a distância k+1.

Como a estrutura de dados `deque` garante que todos os vértices na camada Lk sejam processados antes de qualquer vértice da camada Lk+1, é impossível que um vértice seja alcançado por um caminho mais longo antes de ser alcançado pelo seu caminho mais curto. O dicionário de distâncias atua como um conjunto de visitados, garantindo que o algoritmo não reavalie vértices e, em um grafo finito, sempre termine.

### Por que a solução atende às exigências do problema

O problema restringe de "Entrada" até "Saida" obrigatoriamente passando pelo ponto "*", que no contexto do problema, é o queijo. Se o menor caminho de A até C passa por um ponto intermediário B, então esse caminho é a concatenação do menor caminho de A até B com o menor caminho de B até C, de acordo com o Princípio da Otimalidade (Bellman).

O algoritmo cumpre a exigência ao separar o problema em duas execuções da Busca em Largura: primeiro encontramos a distância mínima do ponto A ("Entrada") até o ponto B ("*", ou queijo) e em seguida encontramos a distância mínima do ponto B ("*") até o ponto C ("Saida").

## Análise de Complexidade

### Complexidade de Tempo: O(V+E)

A complexidade é dominada pela construção do grafo e pelas duas execuções da BFS.

- `for _ in range(e)` itera exatamente E vezes. Em cada iteração, verificamos a existência dos vértices no dicionário e adicionamos os vizinhos nas listas de adjacência, com custo O(1). Então, o tempo total para construir o grafo é O(E).
- Na função `bfs(start)`, cada vértice alcançável entra e sai da fila (`deque`) no máximo uma vez. As operações `popleft()` e `append()` da estrutura `deque` custam O(1).
- O laço `for vizinho in graph.get(atual, [])` itera sobre a lista de adjacência do vértice atual; ao longo de toda execução de uma BFS, esse laço examinará cada aresta direcionada no máximo uma vez. Como o grafo é bidirecional, o número total de iterações do laço interno é de 2E. A verificação `if vizinho not in dict` ocorre em tempo médio O(1).

A complexidade de uma única BFS é O(V+E). Como o algoritmo executa a BFS exatamente duas vezes, o custo dobra, mas a complexidade assintótica permanece constante em O(V+E).

### Complexidade de Memória: O(V+E)

- O dicionário que representa a lista de adjacência armazena até V chaves. Como cada aresta conecta dois vértices e o grafo é bidirecional, a soma de todos os elementos dentro de todas as listas de adjacência será de 2E. Então a estrutura do grafo consome O(V+E) de espaço.
- No pior caso possível (grafo estrela) a fila `deque` armazena até V-1 elementos simultaneamente. O espaço utilizado pela fila é O(V).
- O dicionário `dist` mapeia as distâncias de cada vértice. No pior cenário, todos os vértices são visitados, então consumirá O(V) de memória.

## Discussão

Inicialmente, foi pensado em utilizar Dijkstra pois seria um grafo de caminhos mínimos, porém a solução foi refeita utilizando BFS, visto que é mais eficiente. A mudança fez com que a complexidade do código de resolução fosse reduzida de O((V+E) log V) para O(V+E).