# funcao para gerar o ranking
def ranking(arqEntrada, arqSaida, top=2000):
    try:
        with open(arqEntrada, 'r', encoding='utf-8') as arq:
            palCont = []
            for linha in arq:
                palavra, cont = linha.rsplit(maxsplit=1)
                palCont.append((palavra, int(cont)))

        # ordena por ocorrencias, se igual, ordena por ordem alfabetica
        palRankeadas = sorted(palCont, key=lambda x: (-x[1], x[0]))

        # top 2000 frequentes
        palFrequentes = palRankeadas[:top]

        with open(arqSaida, 'w', encoding='utf-8') as output:
            for palavra, cont in palFrequentes:
                output.write(f"{palavra} {cont}\n")

        print(f"Arquivo '{arqSaida}' foi gerado.")

    except FileNotFoundError:
        print(f"{arqEntrada} nao encontrado.")
    except Exception as e:
        print(f"Erro: {e}")


arquivosE = ['frankstein_counted.txt', 'war_and_peace_counted.txt']
arquivosS = ['frankstein_ranked.txt', 'war_and_peace_ranked.txt']

for arqEntrada, arqSaida in zip(arquivosE, arquivosS):
    ranking(arqEntrada, arqSaida)
