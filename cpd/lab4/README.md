# LABORATÓRIO 4 - TABELAS HASH

## OBJETIVO
Implementar uma Tabela Hash, com diferentes tamanhos de tabelas (M), que deve armazenar registros compostos de uma chave identificadora e dados satélites associados. Para a implementação da Tabela Hash, devemos:
* escolher uma função de Hash para mapear a chave de cada registro para um inteiro entra 0 e M-1;
* impementar o método de resolução de conflitos de endereçamento fechado com listas encadeadas;
* implementar a operação de inserção de um registro na tabea Hash; e
* implementar a operação de busca de um registro por uma chave na Tabela Hash.

### Arquivos de Testes

A implementação da tabela Hash deve ser testada com um arquivo `.CSV` contendo descrições de 18944 nomes de jogadores de futebol, chamado `players-fifa.csv`. A primeira linha do arquivo contém a descrição em cada coluna do registro a ser armazenado. A chave é o identificador de cada jogador (`sofifa_id`), e os dados satélites consistem no nome completo do jogador e um string contendo uma lista de posições que o joador atua. Cada linha do arquivo contm os dados de um jogador.

### Experimentos

Para testar a implementação da Tabela Hash, coletamos estatísticas elacionaas à construção da tabela e consultas por registros armazenados na tabela. Como o tamanho da tabela e muito importante na performance, vamos realizar experimentos com os seguintes valores de tamanho da tabela: 3793, 6637, 9473, 12323 e 15149. Todos estes números são números primos próximos aos percentuais de 20%, 35%, 50%, 65% e 80% do total número de jogadores. Para cada tamanho de tabela, realize um experimento que consiste em inserir na tabela os dados de jogadores do arquivo `players-fifa.csv`, e após realize consultas por identificadores (`sofifa_id`) de jogadores descritas no arquivo `consultas.csv`. Para avaliar a performance para cada tamanho de tabela, colete as seguintes estatísticas sobre a construção da tabela e consultas realizadas:

##### estatísticas da tabela hash:
* tempo de construçã da tabela (em milissegundos): t3793, t6637, t9473, t12323 e t15149;
* taxa de ocupação da tabela (número de entradas usadas divididas pelo tamanho da tabela): o3793, o6637, o9473, o2323 e o5149;
* tamanho máximo de lista: M3793, M6637, M9473, M2323 e M5149;
* média do tamanho das listas (para entradas não vazias): m3793, m6637, m9473, m2323 e m5149.

##### estatísticas das consultas:
* tempo de realização de todas as consultas (em milisegundos): a3793, a6637, a9473, a12323 e a15149;
* para cada chave encontrada, retorne o id do jogador (id_jogador), nome do jogador (nome_jogador) e número de testes (numero_testes) na tabela hash realizado até encontrar o jogador: c3793, c6637, c9473, c2323, c5149;
* para cada chave não encontrada, retorne 99999 (id_jogador), NAO_ENCONTRADO (nome_jogador) e número de testes (numero_testes) realizado até concluir que a chave não está na tabela: c3793, c6637, c9473, c2323,c5149.

Os resultados devem ser gravados em dois arquivos: `estatisticas_construcao.txt` e `estatisticas_consultas.txt`.

## ARQUIVOS ENVIADOS
* **`bee1256.js`:** arquivo com o código de solução do desafio 1256 do Beecrowd;
* **`consultas.csv` e `players.csv`:** arquivos .csv de entrada;
* **`tabela-hash.py`:** arquivo com o código de implementação da tabela hash;
* **`estatisticas_consultas.txt` e `estatisticas_construção.txt`:** arquivos de saída do programa.

## EXECUÇÃO
Os arquivos foram compilados na IDE _PyCharm Community_. Arquivos abertos e compilados de acordo com o formato da interface de desenvolvimento.
