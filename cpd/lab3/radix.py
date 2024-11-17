from collections import deque

# funcao radix sort msd
def radixSortMSD(strings):
    if len(strings) <= 1:
        return strings

    # tamanho da maior string, tamanho maximo de profundidade
    profMax = max(len(s) for s in strings)

    # funcao que ordena baseado no caractere da posicao de profundidade
    def ordenaPorProf(strings, prof):
        if prof >= profMax:
            return strings

        # 256 caracteres ascii + 1 para strings curtas
        caracAscii = [[] for _ in range(257)] 

        for string in strings:
            if prof < len(string):
                caracAscii[ord(string[prof])].append(string)
            else:
                caracAscii[256].append(string)

        # concatena as listas de caracteres
        concCaract = []
        for caract in range(257):
            if caracAscii[caract]:
                concCaract.extend(ordenaPorProf(caracAscii[caract], prof + 1))

        return concCaract

    return ordenaPorProf(strings, 0)


# funcao para leitura do arquivo
def leituraArq(arqEntrada):
    with open(arqEntrada, 'r', encoding='utf-8') as arq:
        strings = []
        for linha in arq:
            strings.extend(linha.strip().split())
    return strings

# funcao para escrever no arquivo
def escreveArq(arqSaida, strings):
    with open(arqSaida, 'w', encoding='utf-8') as arq:
        for string in strings:
            arq.write(string + '\n')

#-------------------------------------------

if __name__ == "__main__":
    arquivosE = ['entradas/frankstein.txt', 'entradas/war_and_peace.txt']
    arquivosS = ['frankstein_sorted.txt', 'war_and_peace_sorted.txt']

    for arqEntrada, arqSaida in zip(arquivosE, arquivosS):
        strEntrada = leituraArq(arqEntrada)
        strOrdenada = radixSortMSD(strEntrada)

        escreveArq(arqSaida, strOrdenada)

        print(f"Arquivo '{arqSaida}' foi gerado.")
