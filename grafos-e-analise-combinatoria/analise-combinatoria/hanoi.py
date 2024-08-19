def hanoiTempo(n):
    if n == 0:
        return "00:00:00"
    else:
        segundos = pow(2, n, 86400) - 1
        horas = segundos // 3600
        segundos %= 3600
        minutos = segundos // 60
        segundos %= 60
        horas %= 24

        return f"{int(horas):02d}:{int(minutos):02d}:{int(segundos):02d}"
    
n = int(input())
res = hanoiTempo(n)
print(f"{res}")
