# Trabalho Final - Classificação e Pesquisa de Dados

## OBJETIVO
Com uma interface gráfica e em menos de 1 minuto (apresentando o tempo), deverá ordenar os conjuntos de dados disponibilizados para este trabalho, extraídos do site [SOFIFA](https://sofifa.co), e do modo carreira do FIFA 15 ao FIFA 21. 

### 1. Descrição dos Dados
Os dados são compostos de três arquivos: `players.csv`, `rating.csv` e `tags.csv` contendo, respectivamente, informações sobre jogadores, avaliações de usuários e anotações em texto-livre (tags). O arquivo `players.csv` contém informações de 18.944 jogadores, composto de um sofifa_id, short_name, long_name, player_positions, e nationality.

O arquivo `ratings.csv` contém 24.188.078 de avaliações (notas entre 1 e 5) de usuários para jogadores. Há um arquivo chamado `minirating.csv` com 10.000 avaliações para ajudar nos testes.  A leitura os dados em CSV pode demorar, em especial o arquivo `rating.csv` que possui mais de 400MB de dados. É permitido usar código externo para leitura eficiente de arquivos CSV. Em Python, pode-se usar Pandas para a leitura do arquivo. 

O arquivo `tags.csv` contém 362.700 anotações de texto livre (tags) (ex.: Brazil, FK Specialist, Speedster, Playmaker, Paris Saint-Germain) para 18.944 jogadores.

### 2. Criando Estruturas de Dados de Pesquisa
Descrevendo estruturas que devem ser construídas em pré-processamento para suportar as consultas interativas.

*	**2.1 Estrutura 1: Armazenando Dados Sobre Jogadores**

Uma Tabela Hash deve ser construída para armazenar as informações associadas aos jogadores. A chave de acesso desta Tabela Hash é o id do jogador (sofifa_id), e os dados satélites correspondem aos dados adicionais presentes no arquivo `players.csv` descrito anteriormente somada às informações de revisões de usuários sobre jogadores do arquivo. Estas informações adicionais precisam ser calculadas. Por exemplo, o jogador 15023 (L. Messi) recebeu várias revisões no arquivo `rating.csv`. Para saber a média global das avaliações (de todos os usuários), é necessário ler e calcular a média de todas as avaliações para cada jogador. Uma forma de fazer isso é adicionar nos dados satélites do jogador um contador que armazena o número de revisões e um campo que contém a soma das notas de todas as revisões. Após processar o arquivo de revisões, basta dividir, para cada jogador, esta soma pelo total de revisões atribuídas a esse jogador. Por exemplo, a média global do L. Messi é 4.256382.

*	**2.2 Estrutura 2: Estrutura para buscas por strings de nomes**

Uma das consultas solicitadas refere-se a uma busca por prefixos de nomes de jogadores. Para suportar esta consulta, é solicitada a construção de uma árvore que suporta consultas de prefixos em strings (TRIE, RADIX TREE ou TST). A estrutura escolhida deve ser construída para armazenar os nomes curtos de todos os jogadores. Ao incluir um nome nessa estrutura, o identificador que sinaliza o final do string deve ser o id do jogador (sofifa_id). A s consultas por prefixos devem, portanto, saber percorrer a estrutura implementada e retornar a lista de ID's de jogadores que satisfazem a consulta. Todos os nomes longos presentes no arquivo `players.csv` devem ser incluídos nessa estrutura.

*	**2.3 Estrutura 3: Estrutura para guardar revisões de usuários**

As avaliações descrevem as notas atribuídas para jogadores por cada usuário. Para poder responder perguntas sobre quais jogadores um usuário avaliou é preciso criar uma estrutura de dados que retorne, para um dado usuário, quais jogadores foram avaliados por este usuário e qual notas que este atribuiu. A escolha de qual estrutura utilizar para guardar dados de usuários é livre.

*	**2.4 Estrutura 4: Estrutura para guardar tags**

Os usuários também atribuem comentários em texto livre sobre jogadores no arquivo `tags.csv`. A estrutura que precisa ser construída deve suportar consultas por uma string contendo uma tag, e retornar a lista de jogadores que foram atribuídos esta tag. A escolha de qual estrutura utilizar para guardar dados de tags é livre.

### 3. Pesquisas
Implementando estruturas de dados e algoritmos que suportam pesquisas sobre os dados.

*	**3.1 Pesquisa 1: prefixos de nomes de jogadores**

Esta pesquisa tem como objetivo retornar a lista de jogadores cujo *short_name* do jogador começa com uma string passada como parâmetro. Todos os jogadores que satisfizerem a string de consulta devem ser retornados, um por linha, contendo o id do jogador, o nome curto, o nome longo, a lista de posições dos jogadores, avaliação média global e número de avaliações. O resultado da consulta deve ser ordenado em ordem decrescente da nota global do jogador, e a nota global de avaliação deve usar 6 casas decimais. Além disso, o resultado da consulta deve ser impresso compacto e organizado em colunas tabuladas.

A consulta deve ser feita diretamente pelo console (ou interface gráfica) e o resultado também deve ser impresso no console (ou interface). Para responder esta pesquisa, deve-se consultar a árvore de pesquisa em strings para buscar todos os identificadores de jogadores que correspondem ao string da consulta. Com essa lista de identificadores, pode-se buscar na tabela hash as informações complementares dos jogadores.
	
*	**3.2 Pesquisa 2: jogadores revisados por usuários**

Esta pesquisa deve retornar a lista com no máximo 30 jogadores revisados pelo usuário e para cada jogador mostrar a nota dada pelo usuário e para cada jogador mostrar a nota dada pelo usuário, a média global e a contagem de avaliações. O reultado da consulta deve ser ordenado em ordem decrescente da nota atribuída pelo usuário (ordenação primária) e pela nota global do jogador (ordenação secundária). Além disso, o resultado da consulta deve ser impresso compacto e organizado em colunas tabuladas.

*	**3.3 Pesquisa 3: melhores jogadores de uma determinada posição**

Esta pesquisa tem por objetivo retornar a lista de jogadores com melhores notas de uma dada posição. Para evitar que um jogador seja retornado com uma boa média mas com poucas avaliações, sta consulta deve retornar os melhores jogadores com no mínimo 1000 avaliações. Para gerenciar o número de jogadores a serem retornados, a consulta deve receber como parâmetro um número N que corresponde ao número máximo de jogadores a serem retornados. O resultado da consulta deve ser ordenado em ordem decrescente da nota global de jogador e a nota global de avaliação deve usar 6 casas decimais. Além disso, o resultado da consulta deve ser impresso compacto e organizado em colunas tabuladas.

*	**3.4 Pesquisa 4: prefixo de tags de jogadores**

Esta pesquisa tem por objetivo explorar a lista de tags adicionadas por cada usuário em cada revisão. Para uma lista de tags dada como entrada, a pesquisa deve retornar a lista dejogadores que estão associados a interseção de um conjunto de tags. O resultado da consulta deve ser ordenado em ordem decrescente da nota global do jogador e a nota global de avaliação deve usar 6 casas decimais. Além disso, o resultado da consulta deve ser impresso compacto e organizado em colunas tabuladas.

### 4. Implementação 
Os usuários devem construir uma aplicação que funciona em duas fases. A primeira fase corresponde a construção e inicialização das estruturas de dados necessárias para suportar as consultas. Ao executar a fase de construção, esta não deve demorar mais de 3 minutos (deve-se cronometrar o tempo, tentar em menos de 1 minuto). Após as estruturas serem construídas, a aplicação entra na segunda fase, que corresponde ao modo console. Nesta fase sera possível fazer as pesquisas listadas na seção 3.

## ARQUIVOS ENVIADOS
* **`final.py`:** arquivo com o código do trabalho final;
* **`rating.csv`:** arquivo de avaliações de usuários para jogadores;
* **`players.csv`:** arquivo de informações de jogadores;
* **`tags.csv`:** arquivo de anotações de texto livre (tags) para os jogadores.

## EXECUÇÃO
Os arquivos foram compilados na IDE _Visual Studio Code_ e na versão **3.11.9** da linguagem Python. Para execução, é necessário ter intalado a versão correta da linguagem (para verificar é necessário executar o comando `python --version`), instalar o Pandas (`pip install pandas`) e em seguida, no terminal integrado da pasta do arquivo, compilar `python final.py` para a execução do arquivo.
