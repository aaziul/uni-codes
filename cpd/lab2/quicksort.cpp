#include <iostream>
#include <fstream>
#include <vector>
#include <chrono>
#include <cstdlib>
#include <algorithm>

using namespace std;
using namespace std::chrono;

int trocas, recursoes;

// funcao para escolher o particionador pela mediana de 3
int medianaTres(vector<int>& arr, int low, int high) {
    int mid = low + (high - low) / 2;
    if (arr[low] > arr[mid]) swap(arr[low], arr[mid]);
    if (arr[low] > arr[high]) swap(arr[low], arr[high]);
    if (arr[mid] > arr[high]) swap(arr[mid], arr[high]);
    swap(arr[low], arr[mid]);
    return arr[low];
}

//funao para escolher o particionador aleatoriamente
int escolhaAleatoria(vector<int>& arr, int low, int high) {
    int random_index = low + rand() % (high - low + 1);
    swap(arr[low], arr[random_index]);
    return arr[low];
}

// particionamento lomuto
int lomuto(vector<int>& arr, int low, int high) {
    int pivot = arr[low];
    int i = low;
    for (int j = low + 1; j <= high; ++j) {
        if (arr[j] < pivot) {
            ++i;
            swap(arr[i], arr[j]);
            ++trocas;
        }
    }
    swap(arr[low], arr[i]);
    ++trocas;
    return i;
}

// particionamento hoare
int hoare(vector<int>& arr, int low, int high) {
    int pivot = arr[low];
    int i = low - 1, j = high + 1;
    while (true) {
        do { ++i; } while (arr[i] < pivot);
        do { --j; } while (arr[j] > pivot);
        if (i >= j) return j;
        swap(arr[i], arr[j]);
        ++trocas;
    }
}

// funcao de QuickSort usando particionamento Lomuto
void quicksortLomuto(vector<int>& arr, int low, int high, int (*escolha_particionador)(vector<int>&, int, int)) {
    if (low < high) {
        ++recursoes;
        int pivot = escolha_particionador(arr, low, high);
        int p = lomuto(arr, low, high);
        quicksortLomuto(arr, low, p - 1, escolha_particionador);
        quicksortLomuto(arr, p + 1, high, escolha_particionador);
    }
}

// funcao de QuickSort usando particionamento Hoare
void quicksortHoare(vector<int>& arr, int low, int high, int (*escolha_particionador)(vector<int>&, int, int)) {
    if (low < high) {
        ++recursoes;
        int pivot = escolha_particionador(arr, low, high);
        int p = hoare(arr, low, high);
        quicksortHoare(arr, low, p, escolha_particionador);
        quicksortHoare(arr, p + 1, high, escolha_particionador);
    }
}

// funcao para medir tempo de execução e gravar resultados
void executar(vector<int> arr, int tamanho, const string& escolha, const string& particionamento, void (*quicksort)(vector<int>&, int, int, int (*)(vector<int>&, int, int)), int (*escolha_particionador)(vector<int>&, int, int), const string& arquivo_saida) {
    trocas = recursoes = 0;
    auto inicio = high_resolution_clock::now();
    
    quicksort(arr, 0, tamanho - 1, escolha_particionador);
    
    auto fim = high_resolution_clock::now();
    duration<double, milli> duracao = fim - inicio;
    
    ofstream saida(arquivo_saida, ios::app);
    saida << tamanho << "," << escolha << "," << particionamento << "," << trocas << "," << recursoes << "," << duracao.count() << endl;
    saida.close();
}

// funcao para ler os vetores do arquivo de entrada e executar os testes
void lerExecutar(const string& arquivo_entrada, const string& arquivo_saida) {
    ifstream entrada(arquivo_entrada);
    int n;
    
    while (entrada >> n) {
        vector<int> arr(n);
        for (int i = 0; i < n; ++i) {
            entrada >> arr[i];
        }
        
        executar(arr, n, "aleatorio", "lomuto", quicksortLomuto, escolhaAleatoria, arquivo_saida);
        executar(arr, n, "aleatorio", "hoare", quicksortHoare, escolhaAleatoria, arquivo_saida);
        executar(arr, n, "mediana3", "lomuto", quicksortLomuto, medianaTres, arquivo_saida);
        executar(arr, n, "mediana3", "hoare", quicksortHoare, medianaTres, arquivo_saida);
    }
    
    entrada.close();
}

int main() {
    string arquivo_entrada = "entrada-quicksort.txt";
    string arquivo_saida = "resultados.txt";
    
    ofstream saida(arquivo_saida);
    saida.close();

    lerExecutar(arquivo_entrada, arquivo_saida);
    
    cout << "Concluido, resultados salvos em " << arquivo_saida << endl;
    
    return 0;
}
