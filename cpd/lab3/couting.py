from collections import Counter

# funcao para contar palavras
def contPalavras(arqEntrada, arqSaida):
    try:
        with open(arqEntrada, 'r', encoding='utf-8') as arq:
            texto = arq.read()

        # separa as palavras, remove pontuacao
        palavras = texto.split()
        palavras = [palavra.strip('.,!?;:"()[]') for palavra in palavras]

        # conta ocorrencias de cada palavra
        contaPalav = Counter(palavras)

        # ordena as palavras
        ordenaPalavContadas = sorted(contaPalav.items())

        with open(arqSaida, 'w', encoding='utf-8') as output:
            for palavra, count in ordenaPalavContadas:
                output.write(f"{palavra} {count}\n")

        print(f"Arquivo '{arqSaida}' foi gerado.")

    except FileNotFoundError:
        print(f"'{arqEntrada}' nao encontrado.")
    except Exception as e:
        print(f"Erro: {e}")


arquivosE = ['frankstein_sorted.txt', 'war_and_peace_sorted.txt']
arquivosS = ['frankstein_counted.txt', 'war_and_peace_counted.txt']

for arqEntrada, arqSaida in zip(arquivosE, arquivosS):
    contPalavras(arqEntrada, arqSaida)
