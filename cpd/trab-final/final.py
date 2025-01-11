import pandas as pd
import time

tabelaHashJog = {}
trieNomes = {}

def carregarDados():
    global trieNomes, tabelaHashJog

    inicio = time.time()

    # carrega as informacoes dos jogadores
    players = pd.read_csv('players.csv', dtype={
        'sofifa_id': int, 'short_name': str, 'long_name': str,
        'player_positions': str, 'nationality': str
    })

    # carrega as avaliacoes
    ratings = pd.read_csv('rating.csv', dtype={
        'sofifa_id': int, 'user_id': int, 'rating': float
    })

    # carrega as tags
    tags = pd.read_csv('tags.csv', dtype={'sofifa_id': int, 'tag': str})
    tags['tag'] = tags['tag'].astype(str)

    # calculo das medias
    ratings_agg = ratings.groupby('sofifa_id')['rating'].agg(['sum', 'count']).reset_index()
    ratings_agg['avg_rating'] = ratings_agg['sum'] / ratings_agg['count']

    players = players.merge(ratings_agg, how='left', on='sofifa_id').fillna({'avg_rating': 0, 'count': 0})

    # adiciona tags dos jogadores
    tags_agg = tags.groupby('sofifa_id')['tag'].apply(lambda x: ', '.join(sorted(x.unique()))).reset_index()
    players = players.merge(tags_agg, how='left', on='sofifa_id').fillna({'tag': ''})

    # adiciona usuarios que avaliaram os jogadores
    user_ids_agg = ratings.groupby('sofifa_id')['user_id'].apply(
        lambda x: ', '.join(map(str, sorted(x.unique())))
    ).reset_index()
    user_ids_agg.rename(columns={'user_id': 'user_ids'}, inplace=True)

    # adiciona user_ids aos jogadores
    players = players.merge(user_ids_agg, how='left', on='sofifa_id').fillna({'user_ids': ''})

    # cria a tabela hash
    tabelaHashJog.clear()
    trieNomes.clear()

    for _, row in players.iterrows():
        jogador = {
            'sofifa_id': row['sofifa_id'],
            'short_name': row['short_name'],
            'long_name': row['long_name'],
            'player_positions': row['player_positions'],
            'nationality': row['nationality'],
            'avg_rating': row['avg_rating'],
            'count': row['count'],
            'tag': row['tag'],
            'user_ids': row['user_ids'],
        }
        tabelaHashJog[row['sofifa_id']] = jogador
        insereTrie(row['short_name'], row['sofifa_id'])

    fim = time.time()
    print(f"Carregamento concluido em {fim - inicio:.2f} segundos.")

# funcao para inserir na trie
def insereTrie(nome, sofifa_id):
    node = trieNomes
    for char in nome:
        if char not in node:
            node[char] = {}
        node = node[char]
    if '_end' not in node:
        node['_end'] = []
    node['_end'].append(sofifa_id)

# funcao para buscar na trie
def buscaTrie(prefixo):
    node = trieNomes
    for char in prefixo:
        if char not in node:
            return []
        node = node[char]
    return buscaID(node)

def buscaID(node):
    ids = []
    if '_end' in node:
        ids.extend(node['_end'])
    for key in node:
        if key != '_end':
            ids.extend(buscaID(node[key]))
    return ids

# funcao de ordenacao por insercao
def insertionSort(lista, chave, reverso=False):
    for i in range(1, len(lista)):
        item = lista[i]
        j = i - 1
        while j >= 0 and ((item[chave] > lista[j][chave]) if reverso else (item[chave] < lista[j][chave])):
            lista[j + 1] = lista[j]
            j -= 1
        lista[j + 1] = item
    return lista

# consulta pelo nome do jogador
def consultaNome(prefixo):
    ids = buscaTrie(prefixo)
    resultados = [tabelaHashJog[sofifa_id] for sofifa_id in ids]
    resultados = insertionSort(resultados, 'avg_rating', True)
    return formatacao(resultados)

# consulta pelos jogadores revisados por um usuario
def consultaUserID(user_id):
    resultados = [
        jogador for jogador in tabelaHashJog.values()
        if str(user_id) in jogador['user_ids'].split(', ')
    ]
    if not resultados:
        return f"nenhum jogador revisado pelo usuario com id: {user_id}"

    resultados = insertionSort(resultados, 'avg_rating', True)
    resultados = insertionSort(resultados, 'count', True)

    return formatacao(resultados)

# consulta pelos melhores jogadores de uma posicao
def consultaBestJog(posicao, max_resultados):
    resultados = [
        jogador for jogador in tabelaHashJog.values()
        if posicao in jogador['player_positions']
    ]

    resultados = insertionSort(resultados, 'avg_rating', True)

    return formatacao(resultados[:max_resultados])

# consulta por tags dos jogadores
def consultaTags(tags):
    resultados = [
        jogador for jogador in tabelaHashJog.values()
        if all(tag in jogador['tag'] for tag in tags)
    ]
    
    resultados = insertionSort(resultados, 'avg_rating', True)
    
    return formatacao(resultados)

# formatacao dos resultados
def formatacao(resultados):
    if not resultados:
        return "Nenhum resultado encontrado"
    return "\n".join(
        f"{jogador['sofifa_id']} | {jogador['short_name']} | {jogador['long_name']} | "
        f"{jogador['player_positions']} | {jogador['nationality']} | {jogador['avg_rating']:.6f} | "
        f"{jogador['count']} | {jogador['tag']}"
        for jogador in resultados
    )

# principal
if __name__ == "__main__":
    print("Carregando dados...")
    carregarDados()

    # testes
    nomeTeste = "Neymar"
    print(f"\nConsulta por prefixo de nome ({nomeTeste}):")
    print(consultaNome(nomeTeste))

    print("\n##################################")

    IDTeste = 54766
    print(f"\nJogadores revisados por usuario (id: {IDTeste}):")
    print(consultaUserID(IDTeste))

    print("\n##################################")

    posTeste = "ST"
    resTeste = 5
    print(f"\nMelhores jogadores por posicao ({posTeste}, {resTeste} resultados):")
    print(consultaBestJog(posTeste, resTeste))

    print("\n##################################")

    tagTeste1 = 'Brazil'
    tagTeste2 = 'Team Player'
    print(f"\nconsulta por tags ({tagTeste1} e {tagTeste2}):")
    print(consultaTags([tagTeste1, tagTeste2]))
