import csv
import time
from collections import defaultdict

class TabelaHash:
    def __init__(self, tamanho):
        self.tamanho = tamanho
        self.tabela = [[] for _ in range(tamanho)]
        self.entradas = 0

    def hash(self, chave):
        return chave % self.tamanho

    def inserir(self, chave, dado):
        indice = self.hash(chave)
        self.tabela[indice].append((chave, dado))
        self.entradas += 1

    def buscar(self, chave):
        indice = self.hash(chave)
        for i, (k, v) in enumerate(self.tabela[indice]):
            if k == chave:
                return v, i + 1
        return None, len(self.tabela[indice])

    def calcular_estatisticas(self):
        ocupacao = sum(1 for lista in self.tabela if lista) / self.tamanho
        tamanho_maximo = max(len(lista) for lista in self.tabela)
        tamanhos_nao_vazios = [len(lista) for lista in self.tabela if lista]
        media_tamanhos = sum(tamanhos_nao_vazios) / len(tamanhos_nao_vazios) if tamanhos_nao_vazios else 0
        return ocupacao, tamanho_maximo, media_tamanhos


def carregar_dados(arquivo_csv):
    with open(arquivo_csv, newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        dados = [(int(row['sofifa_id']), (row['name'], row['player_positions'])) for row in reader]
    return dados


def carregar_consultas(arquivo_csv):
    with open(arquivo_csv, newline='', encoding='utf-8') as csvfile:
        consultas = [int(row.strip()) for row in csvfile]
    return consultas


def realizar_experimentos(tamanhos, dados, consultas):
    estatisticas_construcao = []
    estatisticas_consultas = []
    resultados_consultas = defaultdict(list)

    for tamanho in tamanhos:
        tabela = TabelaHash(tamanho)

        inicio = time.time()
        for sofifa_id, info in dados:
            tabela.inserir(sofifa_id, info)
        tempo_construcao = (time.time() - inicio) * 1000

        ocupacao, tamanho_max, media_tam = tabela.calcular_estatisticas()
        estatisticas_construcao.append((tempo_construcao, ocupacao, tamanho_max, media_tam))

        inicio = time.time()
        for consulta in consultas:
            resultado, testes = tabela.buscar(consulta)
            if resultado:
                nome, posicoes = resultado
                resultados_consultas[consulta].append((consulta, nome, testes))
            else:
                resultados_consultas[consulta].append((99999, "NAO_ENCONTRADO", testes))
        tempo_consultas = (time.time() - inicio) * 1000
        estatisticas_consultas.append(tempo_consultas)

    return estatisticas_construcao, estatisticas_consultas, resultados_consultas


def salvar_estatisticas_construcao(arquivo, estatisticas_construcao, tamanhos):
    with open(arquivo, 'w') as f:
        f.write(','.join(f"t{t}" for t in tamanhos) + '\n')
        f.write(','.join(f"{estat[0]:.2f}" for estat in estatisticas_construcao) + '\n')

        f.write(','.join(f"o{t}" for t in tamanhos) + '\n')
        f.write(','.join(f"{estat[1]:.6f}" for estat in estatisticas_construcao) + '\n')

        f.write(','.join(f"M{t}" for t in tamanhos) + '\n')
        f.write(','.join(f"{estat[2]}" for estat in estatisticas_construcao) + '\n')

        f.write(','.join(f"m{t}" for t in tamanhos) + '\n')
        f.write(','.join(f"{estat[3]:.6f}" for estat in estatisticas_construcao) + '\n')


def salvar_estatisticas_consultas(arquivo, estatisticas_consultas, resultados_consultas, tamanhos):
    with open(arquivo, 'w') as f:
        f.write(','.join(f"a{t}" for t in tamanhos) + '\n')
        f.write(','.join(f"{tempo:.2f}" for tempo in estatisticas_consultas) + '\n')

        for consulta, resultados in resultados_consultas.items():
            id_jogador = resultados[0][0]
            nome_jogador = resultados[0][1]
            testes_por_tabela = [resultado[2] for resultado in resultados]

            linha = f"{id_jogador},{nome_jogador}," + ','.join(map(str, testes_por_tabela)) + '\n'
            f.write(linha)


if __name__ == "__main__":
    arquivo_dados = "players.csv"
    arquivo_consultas = "consultas.csv"
    arquivo_estatisticas_construcao = "estatisticas_construcao.txt"
    arquivo_estatisticas_consultas = "estatisticas_consultas.txt"

    tamanhos_tabelas = [3793, 6637, 9473, 12323, 15149]

    dados = carregar_dados(arquivo_dados)
    consultas = carregar_consultas(arquivo_consultas)

    estatisticas_construcao, estatisticas_consultas, resultados_consultas = realizar_experimentos(
        tamanhos_tabelas, dados, consultas
    )

    salvar_estatisticas_construcao(arquivo_estatisticas_construcao, estatisticas_construcao, tamanhos_tabelas)
    salvar_estatisticas_consultas(arquivo_estatisticas_consultas, estatisticas_consultas, resultados_consultas, tamanhos_tabelas)
