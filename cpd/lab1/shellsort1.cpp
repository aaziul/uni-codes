#include <iostream>
#include <vector>
#include <algorithm> 
#include <ctime>     
#include <cstdlib>   

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

// função para gerar a sequencia CIURA
std::vector<int> sequenciaCiura(int n) {
    std::vector<int> ciuraSeq = {1, 4, 10, 23, 57, 132, 301, 701, 1577, 3548, 7983, 17961, 40412, 90927, 204585, 460316, 1035711};
    std::vector<int> seq;
    for (int x : ciuraSeq) {
        if (x < n) seq.push_back(x);
    }
    std::reverse(seq.begin(), seq.end()); 
    return seq;
}

// funcao do algoritmo ShellSort
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

// funcao para determinar a maior sequencia e ordenar o vetor com o algoritmo ShellSort
void aplicShellSort(std::vector<int>& arr, const std::string& tipoSeq) {
    int n = arr.size();
    std::vector<int> seq;

    if (tipoSeq == "SHELL") {
        seq = sequenciaShell(n);
    } else if (tipoSeq == "KNUTH") {
        seq = sequenciaKnuth(n);
    } else if (tipoSeq == "CIURA") {
        seq = sequenciaCiura(n);
    } else {
        throw std::invalid_argument("Sequencia invalida.");
    }

    std::cout << tipoSeq << ": {";
    for (size_t i = 0; i < seq.size(); ++i) {
        std::cout << seq[i] << (i + 1 < seq.size() ? ", " : "");
    }
    std::cout << "}\n";

    shellSort(arr, seq);
}

// funcao para medir o tempo de execucao
double temporizador(std::vector<int>& arr, const std::string& tipoSeq) {
    std::clock_t tempoInicial = std::clock();
    aplicShellSort(arr, tipoSeq);
    std::clock_t tempoFinal = std::clock();
    return double(tempoFinal - tempoInicial) / CLOCKS_PER_SEC;
}


int main() {
    int n = 1000000;
    std::srand(std::time(0)); // gerador de numeros aleatorios

    // gera vetor com numeros aleatorios
    std::vector<int> arr(n);
    for (int i = 0; i < n; ++i) {
        arr[i] = std::rand() % n + 1;
    }

    // copia o vetor original para testar cada sequencia
    std::vector<int> shellArr = arr;
    std::vector<int> knuthArr = arr;
    std::vector<int> ciuraArr = arr;

    // calcula o tempo para a sequencia SHELL
    double tempoShell = temporizador(shellArr, "SHELL");
    std::cout << "Tempo SHELL: " << tempoShell << " segundos.\n";

    // calcula o tempo para a sequencia KNUTH
    double tempoKnuth = temporizador(knuthArr, "KNUTH");
    std::cout << "Tempo KNUTH: " << tempoKnuth << " segundos.\n";

    // calcula o tempo para a sequencia CIURA
    double tempoCiura = temporizador(ciuraArr, "CIURA");
    std::cout << "Tempo CIURA: " << tempoCiura << " segundos.\n";


    return 0;
}
