# Luiza Souto
# 20/04/2026

from typing import Dict, List, Set
import heapq

def codifica_prufer(arvore: Dict[int, Set[int]]) -> List[int]:
    """Codifica uma árvore usando a sequência de Prüfer.
    O(n log n)
    """
    if not arvore:
        return []
    
    ultimo_nodo = max(arvore.keys()) if arvore else 1
    
    if len(arvore) <= 1:
        return []
    
    n = len(arvore)
    
    grau = {v: len(adj) for v, adj in arvore.items()}
    folhas = [v for v, g in grau.items() if g == 1]
    heapq.heapify(folhas)  # Usamos um heap para obter a folha de menor rótulo rapidamente

    prufer = []
    while folhas:
        folha = heapq.heappop(folhas)  # Encontra a folha (grau 1) de menor rótulo
        
        if grau[folha] == 0:
            continue
        
        if arvore[folha]:
            vizinho = list(arvore[folha])[0]
            prufer.append(vizinho)
    
            arvore[vizinho].discard(folha)
            arvore[folha].discard(vizinho)
            
            grau[folha] = 0
            grau[vizinho] -= 1

            if grau[vizinho] == 1:
                heapq.heappush(folhas, vizinho)  # Se o vizinho se tornou uma folha, adiciona ao heap
        
    if len(prufer) < (n - 1):
        prufer.append(ultimo_nodo)

    return prufer


def leitura(expressao: str) -> Dict[int, Set[int]]:
    arvore = {}
    pilha = []
    i = 0
    n = len(expressao)
    
    while i < n:
        char = expressao[i]
        
        if char == '(':
            i += 1
            num_str = ""
            while i < n and expressao[i].isdigit():
                num_str += expressao[i]
                i += 1
            
            if num_str:
                vertice = int(num_str)
                if vertice not in arvore:
                    arvore[vertice] = set()
                
                if pilha:
                    pai = pilha[-1]
                    arvore[pai].add(vertice)
                    arvore[vertice].add(pai)
                
                pilha.append(vertice)
            continue
            
        elif char == ')':
            if pilha:
                pilha.pop()
        
        i += 1
        
    return arvore

while True:
    try:
        linha = input().strip()
        if not linha:
            continue
                   
        arvore = leitura(linha)          
        resultado = codifica_prufer(arvore)       

        print(" ".join(map(str, resultado)))
    except EOFError:
        break