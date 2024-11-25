# LABORATORIO 3 - RADIX SORT

## OBJETIVO
Implementar o algoritmo Radix Sort para ordenação de strings e usá-lo para responder tarefas de análise de strings em um arquivo contendo obras literárias.

### TAREFA 1.1: Implementar Radix Sort MSD para strings
* Implementar o Radix Sort MSD para ordenação de strings. O algoritmo deve receber como entrada um vetor de strings e um número contendo o tamanho de entrada, e gerar como saída o vetor de strings ordenado em ordem lexicográfica (crescente).

### TAREFA 1.2: Ordenar palavras de um arquivo de entrada
* Usar arquivos de texto da pasta `'entradas'` para validar o algoritmo Radix Sort MSD. Ao testar um arquivo de texto, é necessário fazer a leitura do mesmo e armazená-lo em um  vetor de strings compatível com o algortimo Radix Sort MSD implementado na tarefa anterior. Inicialmente, testamos o algoritmo com os arquivos `'test1.txt'`, `'test2.txt'`, `'test3.txt'` e `'test4.txt'`, verificando a correção do algoritmo.
* Após validar o algoritmo com os arquivos teste, aplicaremos o algoritmo nos arquivos das duas obras literárias, `'frankstein.txt'` e `'war_and_peace.txt'`, após geraremos os arquivos de saída `'frankstein_sorted.txt'` e `'war_and_peace_sorted.txt'`, contendo cada arquivo as palavras ordenadas em ordem lexicográfica, uma palavra por linha.

### TAREFA 1.3: Contar as palavras do arquivo ordenado
* Usando os arquivos `'frankstein_sorted.txt'` e `'war_and_peace.txt'` da tarefa anterior, conte quantas vezes cada palavra acontece e imprima em ordem cada palavra seguida de sua contagem. Gerando os arquivos `'frankstein_counted.txt'` e `'war_and_peace_counted.txt'`. 

### TAREFA 1.4: Top 2000 palavras mais frequentes
* Usando os arquivos os arquivos `'frankstein_counted.txt'` e `'war_and_peace_counted.txt'` da tarefa anterior, gere um ranking com as 2000 palavras mais frequentes de cada livro. Este ranking deve ordenar as palavras mais frequentes às menos frequentes. Para duas palavras com mesmo número de ocorrências, imprima elas no ranking em ordem lexicográfica. Gere os arquivos `'frankstein_ranked.txt'` e `'war_and_peace_ranked.txt'`.

# ARQUIVOS
* **pasta 'entradas':** pasta com os arquivos de texto para entrada teste para os programas e arquivos texto das obras literárias;
* **'bee1244.py':** código de resolução do problema 1244 do Beecrowd;
* **'radix.py':** código referente a tarefa 1.1 e 1.2 do laboratório;
* **'counting.py':** código referente à tarefa 1.3 do laboratório;
* **'ranking.py':** código referente à tarefa 1.4 do laboratório;
* **pasta 'resultados-testes':** pasta com os arquivos de texto de saída dos textos de teste para o programa da tarefa 1.1;
* **'frankstein_sorted.txt':** arquivo do resultado da compilação da ordenação de `'radix.py'` do arquivo texto `'franksein.txt'`;
* **'war_and_peace_sorted.txt':** arquivo do resultado da compilação da ordenação de `'radix.py'` do arquivo texto `'war_and_peace.txt'`;
* **'frankstein_counted.txt':** arquivo do resultado da compilação da contagem de `'counting.py'`do arquivo texto `'frankstein_sorted.txt'`;
* **'war_and_peace_counted.txt':** arquivo do resultado da compilação da contagem de `'counting.py'`do arquivo texto `'war_and_peace_sorted.txt'`;
* **'frankstein_ranked.txt':** arquivo do resultado da compilação do ranking de `'ranking.py'`do arquivo texto `'frankstein_counted.txt'`;
* **'war_and_peace_ranked.txt':** arquivo do resultado da compilação do ranking de `'ranking.py'`do arquivo texto `'war_and_peace.txt'`.

# EXECUÇÃO
Os arquivos foram compilados na IDE _PyCharm Community_. Arquivos abertos e compilados de acordo com o formato da interface de desenvolvimento.
