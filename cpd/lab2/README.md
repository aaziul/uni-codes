<h1>LABORATÓRIO 2 - QUICKSORT</h1>

OBJETIVO
Implementar quatro versões do algoritmo QuickSort, usando duas estratégias para escolha de particionador, e duas estratégias de particionamento.

As estratégias para escolha do particionador que devem ser implementadas são:
	1 - Escolha 1 (Mediana de 3): particionador deve ser a mediana entre o primeiro, último e elemento na posição média de cada sub-vetor (média entre o índice do primeiro e último elemento arredondada para baixo);
	2 - Escolha 2 (Aleatório): particionador será um elemento aleatório do sub-vetor.

A estratégia de escolha deve primeiro definir qual será o particionador, e após feita esta escolha, colocar o particionador na primeira posição do sub-vetor, trocando com o elemento atualmente na primeira posição. Após esta troca, implemente o algoritmo de QuickSort usando o primeiro elemento como particionador.

Duas estratégias de particionamento devem ser implementadas:
	1 - Particionamento 1 (Lomuto);
	2 - Particionamento 2 (Hoare).

Para todas as quatro combinações (escolha x particionamento), teste cada uma das versões do algoritmo com o arquivo 'entrada-quicksort.txt', contendo vetores aleatórios de tamanho 100, 1000, 10000, 100000 e 1000000. O programa deve ler os vetores de um arquivo de entrada e gravar resultados em um arquivo de saída. A entrada é o arquivo 'entrada-quicksort.txt', contento vários vetores a serem ordenados. Cada vetor é descrito em 1 linha. O primeiro número da linha descreve o tamanho n do vetor, seguido por n números do vetor.

Para cada uma das 4 combinações de escolha e particionamento, execute o código com o arquivo de entrada, e armazene o número de trocas (swaps) entre elementos do vetor, o número de chamadas recursivas e o tempo de execução em milissegundos. Salve esse arquivo com o nome resultados.txt.

ARQUIVOS ENVIADOS
    -> 'bee1259.cpp': código do problema extra do beecrowd;
    -> 'Problema #1259 - Beecrowd.pdf': comprovação do desafio do beecrowd resolvido;
    -> 'entrada-quicksort.txt': arquivo de entrada do programa, disponibilizado via Moodle;
    -> 'quicksort.cpp': código do laboratório sobre quicksort;
    -> 'resultados.txt': resultado após a execução do código do laboratório.

EXECUÇÃO
Para executar, com o compilador de C++ instalado, abra o terminal integrado na pasta onde o código e o arquivo de entrada foram salvos e escreva 'g++ -o quicksort quicksort.cpp' para gerar o arquivo executável. Após a criação do mesmo, digite './quicksort' para o programa ser executado e gerar o arquivo de saída.
