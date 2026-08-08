# Luiza Souto
# 08/05/2026
T = int(input())

for t in range(1, T + 1):
    n, m = (int(x) for x in input().split())

renas = []

for i in range(n):
    nome, peso, idade, altura = (x for x in input().split())
    renas.append((nome, int(peso), int(idade), float(altura)))

# Dica:
# Para ordenar uma lista em python com base em um critério específico, basta usar a função sorted() com o parâmetro key.
# Exemplo:
# renas = sorted(renas, key=lambda x: x[1]) # Ordena pela posição 1 (peso) (crescente)
# renas = sorted(renas, key=lambda x: x[1], reverse=True) # Ordena pelo peso (decrescente)

# Imprima a resposta:
renas = sorted(renas, key=lambda x: x[0]) # Ordena por nome (crescente)
renas = sorted(renas, key=lambda x: x[3]) # Ordena por altura (crescente)
renas = sorted(renas, key=lambda x: x[2]) # Ordena por idade (crescente)
renas = sorted(renas, key=lambda x: x[1], reverse=True) # Ordena pelo peso (decrescente)

#for r in renas:
#print(r[0])

print("CENARIO {" + str(t) + "}")

for j in range(m):
    print(str(j+1) + " - " + renas[j][0])