def raizCatala(n):
    if n ==0:
        return 1
    else:
        catalao = 1
        for i in range(1, n+2):
            catalao = ((4 * i - 2) * catalao) // (i + 1)
        return catalao

n = int(input())
res = raizCatala(n)
print(f"{res}")
