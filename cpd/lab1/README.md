<h2>LABORATÓRIO 1 - CPD - ALGORTIMO SHELLSORT</h2>
<ul>
<li>Na pasta 'DesafioBeecrowd' está o arquivo com o código feito do desafio 1088 do Beecrowd.</li>
<li>Na pasta 'entrada' estão os arquivos textos de entrada enviados via Moodle.</li>
<li>O arquivo 'saida1.txt' e 'saida2.txt' são os arquivos de saída gerados pelos exercícios 1.2 e 1.3.</li>
</ul>

<h4>EXERCICIO 1.1: IMPLEMENTANDO O ALGORITMO DE SHELLSORT - Arquivo shellsort1.cpp</h4>
<p>Criar um código que implemente o algoritmo ShellSort testando as três sequencias abaixo definidas em um vetor:</p>
<ol>
<li> <b>SHELL:</b>
1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,... </li>
<li> <b>KNUTH:</b>
1,4,13,40,121,364,1093,3280,9841,29524,88573,265720,797161,2391484,... </li>
<li> <b>CIURA:</b> A sequencia proposta por Ciura (https://oeis.org/A102549), que é composta dos seguintes números:
1,4,10,23,57,132,301,701,1577,3548,7983,17961,40412,90927,204585,460316,1035711,... </li>
</ol>
<p>Para cada execução do algoritmo de ShellSort com uma dada sequência e um tamanho de vetor n, identifique no vetor correspondente a sequencia a entrada que contem o maior valor menor que o tamanho do vetor n. Por exemplo, para um vetor com 1 milhão de elementos, o maior valor na sequência de SHELL é 524588, na de KNUTH 797161 e na de CIURA 460316. Inicie a execução do ShellSort com esse número encontrado como incremento. Para as próximas exceuções, use o valor anterior na sequencia sucessivamente, ate a ultima chamada com incremento de 1.</p>

<h4>EXERCICIO 1.2: TESTES DE CORREÇÃO - Arquivo shellsort2.cpp</h4>
<p>Criar um código onde testamos a implementação do algoritmo com diferentes vetores de entrada usando as sequencias SHELL, KNUTH e CIURA. Para isso o código deverá ler os vetores de um arquivo de entrada e gravar os resultados em um arquivo de saída. O arquivo de entrada disponibilizado é chamado de entrada1.txt, contendo vários vetores a serem ordenados. Cada vetor é descrito em 1 linha. O primeiro numero da linha descreve o tamanho n do vetor, seguido por n números do vetor. </p>
<p>A saída gerada deve imprimir o vetor parcialmente ordenado após cada etapa do algoritmo de ShellSort, correspondendo a um incremento. A saída deve mostrar o estado da sequência após cada iteração, exatamente como mostrado acima, imprimindo o conteúdo do vetor e o incremento usado. Os resultados devem ser colocados em um arquivo chamado saida1.txt.</p>

<h4>EXERCICIO 1.3: TESTES DE ESCALA - Arquivo shellsort3.cpp</h4>
<p>Cronometrar o tempo de execução em vetores contendo números aleatórios de tamanho 100, 1000, 10000, 100000 e 1000000 para todas as três sequencias. O tempo deve ser convertido para ser impresso em milissegundos. Deveremos também testar a implementação do algoritmo com diferentes vetores de entrada usando as sequencias SHELL, KNUTH e CIURA. Para isso o código deverá ler os vetores de um arquivo de entrada e gravar os resultados em um arquivo de saída. O arquivo de entrada disponibilizado é chamado de entrada2.txt, contendo vários vetores a serem ordenados. Cada vetor é descrito em 1 linha. O primeiro numero da linha descreve o tamanho n do vetor, seguido por n números do vetor.</p>
<p>Em cada linha coloca-se o nome da sequencia usada, seguido do tamanho do vetor de entrada e tempo em milissegundos para ordenar o vetor usando o algoritmo de ShellSort e a sequência respectiva, e ao final uma descrição do processador usado para rodar os testes. Os resultados devem ser armazenados em um arquivo chamado saida2.txt.</p>



