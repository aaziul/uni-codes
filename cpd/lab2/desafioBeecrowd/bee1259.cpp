#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

// funcao para ordenar os numeros
vector<int> ordenarNumeros(const vector<int>& numeros) {
    vector<int> pares, impares;
    
    for(int num : numeros) {
        if(num % 2 == 0) {
            pares.push_back(num); // coloca o numero no vetor pares
        } else {
            impares.push_back(num); // coloca o numero no vetor impares
        }
    }
    
    sort(pares.begin(), pares.end()); // pares em ordem crescente
    sort(impares.begin(), impares.end(), greater<int>()); // impares em ordem decrescente

    vector<int> resultado;
    resultado.insert(resultado.end(), pares.begin(), pares.end()); // insere os pares no resultado
    resultado.insert(resultado.end(), impares.begin(), impares.end()); // insere os impares no resultado
    
    return resultado;
}

int main() {
    int N;
    cin >> N;
    
    vector<int> numeros(N);

    // recebe os numeros 
    for(int i = 0; i < N; ++i) {
        cin >> numeros[i];
    }

    vector<int> numerosOrdenados = ordenarNumeros(numeros);
    
    // imprime os numeros ja ordenados
    for(int num : numerosOrdenados) {
        cout << num << endl;
    }
    
    return 0;
}
