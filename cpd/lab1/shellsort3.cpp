#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <chrono>
#include <iomanip>

// funcao para gerar a sequencia SHELL
std::vector<int> sequenciaShell(int n) {
    std::vector<int> seq;
    int k = 1;
    while (k < n) {
        seq.push_back(k);
        k *= 2;
    }
    std::reverse(seq.begin(), seq.end());
    return seq;
}

// funcao para gerar a sequencia KNUTH
std::vector<int> sequenciaKnuth(int n) {
    std::vector<int> seq;
    int k = 1;
    while (k < n) {
        seq.push_back(k);
        k = 3 * k + 1;
    }
    std::reverse(seq.begin(), seq.end());
    return seq;
}

// funcao para gerar a sequencia CIURA
std::vector<int> sequenciaCiura(int n) {
    std::vector<int> ciuraSeq = {1, 4, 10, 23, 57, 132, 301, 701, 1577, 3548, 7983, 17961, 40412, 90927, 204585, 460316, 1035711};
    std::vector<int> seq;
    for (int x : ciuraSeq) {
        if (x < n) seq.push_back(x);
    }
    std::reverse(seq.begin(), seq.end());
    return seq;
}

// funcao ShellSort
void shellSort(std::vector<int>& arr, const std::vector<int>& seq) {
    int n = arr.size();
    for (int gap : seq) {
        for (int i = gap; i < n; i++) {
            int temp = arr[i];
            int j = i;
            while (j >= gap && arr[j - gap] > temp) {
                arr[j] = arr[j - gap];
                j -= gap;
            }
            arr[j] = temp;
        }
    }
}

// funcao para calcular o tempo de execucao do ShellSort e imprimir os resultados
void tempoRes(const std::string& seq_name, std::vector<int>& arr, const std::vector<int>& seq, std::ofstream& saida, const std::string& infoProc) {
    const int repeticoes = (arr.size() <= 1000) ? 100 : 1; 
    double tempoTotal = 0;

    for (int i = 0; i < repeticoes; ++i) {
        std::vector<int> copiaArr = arr;  
        auto start = std::chrono::high_resolution_clock::now();
        
        shellSort(copiaArr, seq);
        
        auto end = std::chrono::high_resolution_clock::now();
        std::chrono::duration<double, std::milli> duracao = end - start; // medindo em milissegundos
        tempoTotal += duracao.count();
    }

    double tempoMili = tempoTotal / repeticoes; // tempo medio em milissegundos

    saida << seq_name << "," << arr.size() << "," << std::fixed << std::setprecision(6) << tempoMili << "," << infoProc << "\n";
}

// funcao para ler o arquivo de entrada e processar cada vetor
void processarArq(const std::string& arqEntrada, const std::string& arqSaida) {
    std::ifstream entrada(arqEntrada);
    std::ofstream saida(arqSaida);

    if (!entrada.is_open() || !saida.is_open()) {
        std::cerr << "Erro ao abrir arquivos!" << std::endl;
        return;
    }

    std::string infoProc = "AMD Ryzen 7 3700U 2.30 GHz";  // informacao do processador

    int n;
    while (entrada >> n) {
        std::vector<int> arr(n);
        for (int i = 0; i < n; i++) {
            entrada >> arr[i];
        }

        std::vector<int> arrShell = arr;
        std::vector<int> arrKnuth = arr;
        std::vector<int> arrCiura = arr;

        // executa e cronometra o ShellSort com a sequencia SHELL
        tempoRes("SHELL", arrShell, sequenciaShell(n), saida, infoProc);

        // executa e cronometra o ShellSort com a sequencia KNUTH
        tempoRes("KNUTH", arrKnuth, sequenciaKnuth(n), saida, infoProc);

        // executa e cronometra o ShellSort com a sequencia CIURA
        tempoRes("CIURA", arrCiura, sequenciaCiura(n), saida, infoProc);
    }

    entrada.close();
    saida.close();
}

int main() {
    std::string arqEntrada = "entrada2.txt";
    std::string arqSaida = "saida2.txt";

    processarArq(arqEntrada, arqSaida);

    std::cout << "Concluido. Confira o arquivo saida2.txt." << std::endl;
    return 0;
}
