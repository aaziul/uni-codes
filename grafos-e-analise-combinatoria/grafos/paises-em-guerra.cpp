#include <iostream>
#include <vector>
#include <queue>
#include <map>
#include <set>
#include <climits>
#include <sstream>

using namespace std;

// Função para implementar o algoritmo de Dijkstra
vector<int> dijkstra(const vector<vector<pair<int, int>>>& graph, int source, int N) {
    vector<int> distances(N + 1, INT_MAX);
    distances[source] = 0;

    // Priority queue para o algoritmo de Dijkstra
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
    pq.push({0, source});

    while (!pq.empty()) {
        int current_dist = pq.top().first;
        int current_node = pq.top().second;
        pq.pop();

        if (current_dist > distances[current_node]) continue;

        for (const auto& neighbor : graph[current_node]) {
            int next_node = neighbor.first;
            int weight = neighbor.second;
            int new_dist = current_dist + weight;

            if (new_dist < distances[next_node]) {
                distances[next_node] = new_dist;
                pq.push({new_dist, next_node});
            }
        }
    }

    return distances;
}

void processCommunication() {
    int N, E;
    while (cin >> N >> E, N != 0 || E != 0) {
        vector<vector<pair<int, int>>> graph(N + 1);
        map<int, set<int>> reciproca;

        for (int i = 0; i < E; ++i) {
            int X, Y, H;
            cin >> X >> Y >> H;
            graph[X].emplace_back(Y, H);
            reciproca[X].insert(Y);
            if (reciproca[Y].count(X)) {
                // Adiciona aresta bidirecional com peso zero se já existe conexão mútua
                for (auto& edge : graph[X]) {
                    if (edge.first == Y) {
                        edge.second = 0;
                        break;
                    }
                }
                for (auto& edge : graph[Y]) {
                    if (edge.first == X) {
                        edge.second = 0;
                        break;
                    }
                }
            }
        }

        int K;
        cin >> K;
        vector<pair<int, int>> queries(K);
        for (int i = 0; i < K; ++i) {
            int O, D;
            cin >> O >> D;
            queries[i] = {O, D};
        }

        for (const auto& query : queries) {
            int O = query.first;
            int D = query.second;
            vector<int> distances = dijkstra(graph, O, N);
            if (distances[D] == INT_MAX) {
                cout << "Nao e possivel entregar a carta" << endl;
            } else {
                cout << distances[D] << endl;
            }
        }
        cout << endl; // Linha em branco após cada caso de teste
    }
}

int main() {
    processCommunication();
    return 0;
}
