#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm> 

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

// funcao para imprimir o vetor
void imprimeVetor(const std::vector<int>& arr, std::ofstream& saida) {
    for (int num : arr) {
        saida << num << " ";
    }
}

// funcao ShellSort 
void shellSort(std::vector<int>& arr, const std::vector<int>& seq, const std::string& nomeSeq, std::ofstream& saida) {
    int n = arr.size();
    
    // imprime o vetor inicial e o nome da sequencia
    imprimeVetor(arr, saida);
    saida << "SEQ=" << nomeSeq << "\n";

    // realiza o algoritmo ShellSort com a sequencia
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

        // imprime o vetor apos cada incremento
        imprimeVetor(arr, saida);
        saida << "INCR=" << gap << "\n";
    }
}

// funcao para ler o arquivo de entrada e processar cada vetor
void aberturaArq(const std::string& arqEntrada, const std::string& arqSaida) {
    std::ifstream entrada(arqEntrada);
    std::ofstream saida(arqSaida);

    if (!entrada.is_open() || !saida.is_open()) {
        std::cerr << "Erro ao abrir arquivos!" << std::endl;
        return;
    }

    int n;
    while (entrada >> n) {
        std::vector<int> arr(n);
        for (int i = 0; i < n; i++) {
            entrada >> arr[i];
        }

        std::vector<int> arrShell = arr;
        std::vector<int> arrKnuth = arr;
        std::vector<int> arrCiura = arr;

        // aplica o ShellSort com a sequencia SHELL
        shellSort(arrShell, sequenciaShell(n), "SHELL", saida);

        // aplica o ShellSort com a sequencia KNUTH
        shellSort(arrKnuth, sequenciaKnuth(n), "KNUTH", saida);

        // aplica o ShellSort com a sequencia CIURA
        shellSort(arrCiura, sequenciaCiura(n), "CIURA", saida);

        saida << "\n"; 
    }

    entrada.close();
    saida.close();
}

int main() {
    std::string arqEntrada = "entrada1.txt";
    std::string arqSaida = "saida1.txt";

    aberturaArq(arqEntrada, arqSaida);

    std::cout << "Concluido. Confira o arquivo saida1.txt." << std::endl;
    return 0;
}
