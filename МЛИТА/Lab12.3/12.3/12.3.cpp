//12.3.Максимальный путь 1 (6)
//Имеется взвешенный ориентированный ациклический граф.Найти максимальный путь, 
// используя алгоритм Беллмана - Форда.
//Ввод из файла INPUT.TXT.Первая строка входного файла INPUT.TXT содержит 3 
// числа: N - количество вершин графа(3 ≤ N ≤ 1000), M – дуг(3 ≤ M ≤ 500000), 
// A – номер начальной вершины.В следующих M строках по 3 числа, задающих дуги : 
// начало дуги, конец дуги, длина(вес).
//Вывод в файл OUTPUT.TXT.В i - й строке выводится длина максимального пути из
// вершины S до i - й вершины, затем количество вершин максимального пути, а 
// далее номера вершин максимального пути.Все числа разделены пробелами.
// Если пути в некоторую вершину не существует, то в соответствующей строке 
// выводится слово No.Если в графе имеется достижимый из начальной вершины цикл 
// положительной длины, то вывод состоит из двух строк.В первой строке выводится 
// слово No, а во второй – количество и номера вершин обнаруженного цикла через 
// пробел, начиная с его любой вершины и заканчивая ей же.При наличии нескольких 
// циклов вывести информацию о любом из них.
//Пример
//Ввод 1       Ввод 2
//4 6 1        5 6 1
//1 2 1        1 2 1
//1 4 2        1 4 2
//2 3 3        2 3 3
//2 4 3        2 4 3
//3 4 1        3 4 1
//4 3 1        5 2 5
//Вывод 1      Вывод 2
//No           0 1 1
//3 4 3 4      1 2 1 1
//             4 3 1 2 3
//             5 4 1 2 3 4
//             No
// Бабина Мария ПС 21

#include <iostream>
#include <vector>
#include <climits>
#include <algorithm>
#include <fstream>

using namespace std;
const string INPUT_FILE_NAME = "input.txt";
const string OUTPUT_FILE_NAME = "output.txt";

struct Edge {
    int from;
    int to;
    int weight;
};

bool readInput(const string& filename, int& N, int& M, int& A, vector<Edge>& edges) 
{
    ifstream input(filename);
    if (!input.is_open())
    {
        return false;
    }

    input >> N >> M >> A;
    edges.resize(M);

    for (int i = 0; i < M; ++i) 
    {
        input >> edges[i].from >> edges[i].to >> edges[i].weight;
    }
    return true;
}

void bellmanFordMaxPath(int N, int A, const vector<Edge>& edges, vector<long long>& dist, vector<int>& parent, vector<int>& pathLenght)
{
    dist.assign(N + 1, LLONG_MIN);
    parent.assign(N + 1, -1);
    pathLenght.assign(N + 1, 0);

    dist[A] = 0;
    pathLenght[A] = 1;

    for (int i = 1; i <= N - 1; ++i) 
    {
        bool updated = false;
        for (const Edge& e : edges) 
        {
            if (dist[e.from] != LLONG_MIN && dist[e.to] < dist[e.from] + e.weight) 
            {
                dist[e.to] = dist[e.from] + e.weight;
                parent[e.to] = e.from;
                pathLenght[e.to] = pathLenght[e.from] + 1;
                updated = true;
            }
        }
        if (!updated)
        {
            break;
        }
    }
}

bool detectPositiveCycle(int N, const vector<Edge>& edges, const vector<long long>& dist, const vector<int>& parent, vector<int>& cycle) 
{
    for (const Edge& e : edges) 
    {
        if (dist[e.from] != LLONG_MIN && dist[e.to] < dist[e.from] + e.weight) 
        {
            int current = e.from;
            for (int i = 0; i <= N; ++i)
            {
                current = parent[current];
            }

            int start = current;
            cycle.push_back(start);
            for (int v = parent[start]; v != start; v = parent[v])
            {
                cycle.push_back(v);
            }
                
            cycle.push_back(start);
            reverse(cycle.begin(), cycle.end());

            return true;
        }
    }
    return false;
}

void writeOutput(const string& filename, int N, const vector<long long>& dist, const vector<int>& parent, const vector<int>& pathLenght, const vector<int>& cycle)
{
    ofstream out(filename);
    if (!out.is_open()) 
    {
        cerr << "Error opening output file.\n";
        return;
    }

    if (!cycle.empty()) 
    {
        out << "No\n";
        out << cycle.size() << " ";
        for (int v : cycle)
        {
            out << v << " ";
        }
        out << "\n";
        return;
    }

    for (int i = 1; i <= N; ++i) 
    {
        if (dist[i] == LLONG_MIN) 
        {
            out << "No\n";
        }
        else 
        {
            out << dist[i] << " " << pathLenght[i] << " ";
            vector<int> path;
            for (int v = i; v != -1; v = parent[v])
            {
                path.push_back(v);
            }
            reverse(path.begin(), path.end());
            for (size_t j = 0; j < path.size(); ++j) 
            {
                if (j != 0)
                {
                    out << " ";
                }
                out << path[j];
            }
            out << "\n";
        }
    }
}

int main() {
    int N, M, A;
    vector<Edge> edges;

    if (!readInput(INPUT_FILE_NAME, N, M, A, edges)) 
    {
        cerr << "Error reading input.\n";
        return 1;
    }

    vector<long long> dist;
    vector<int> parent, pathLenght, cycle;

    bellmanFordMaxPath(N, A, edges, dist, parent, pathLenght);
    if (detectPositiveCycle(N, edges, dist, parent, cycle)) 
    {
        writeOutput(OUTPUT_FILE_NAME, N, dist, parent, pathLenght, cycle);
    }
    else 
    {
        writeOutput(OUTPUT_FILE_NAME, N, dist, parent, pathLenght, {});
    }

    return 0;
}
