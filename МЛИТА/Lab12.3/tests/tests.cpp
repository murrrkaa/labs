#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

int main() {
    ofstream fout("INPUT.TXT");

    int N = 1000; // Максимальное количество вершин
    int M = 500000; // Максимальное количество рёбер

    fout << N << " " << M << " 1\n";  // Количество вершин, рёбер и начальная вершина

    vector<pair<int, int>> edges;

    // Генерация рёбер
    for (int i = 0; i < N; ++i) {
        for (int j = i + 1; j < N; ++j) {
            edges.push_back({ i + 1, j + 1 });  // Используем индексацию с 1
            if (edges.size() == M) break;
        }
        if (edges.size() == M) break;
    }

    // Печатаем все рёбра
    for (auto& edge : edges) {
        fout << edge.first << " " << edge.second << " " << 1 << "\n"; // Вес рёбер равен 1
    }

    fout.close();
    return 0;
}
