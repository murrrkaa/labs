/*16. Реализовать  эвристический   алгоритм   решения  задачи
коммивояжера на неориентированном полном  графе  на  основании 
метода Краскала нахождения остовного дерева. Проиллюстрировать
по шагам этапы поиска (10). Бабина Мария ПС 21*/

#include <iostream>
#include <fstream>
#include <vector>
#include <unordered_set>

using namespace std;

struct Edge {
    int u, v;
    int weight;
};

void readGraph(const string& path, vector<Edge>& edges, unordered_set<int>& uniquePeaks)
{
    ifstream file(path);
    if (file.is_open())
    {
        int u, v, weight;
        while (file >> u >> v >> weight)
        {
            edges.push_back({ u - 1, v - 1, weight });
            uniquePeaks.insert(u - 1);
            uniquePeaks.insert(v - 1);
        }
        file.close();
    }
    else {
        cout << "Не удалось открыть файл!\n";
    }
}


int getParent(int node, vector<int>& parent) 
{
    while (parent[node] != node) 
    { 
        node = parent[node];      
    }
    return node;
}

void checkAndMergeSets(int a, int b, vector<int>& parent)
{
    int edgeOne = getParent(a, parent);
    int edgeTwo = getParent(b, parent);

    if (edgeOne != edgeTwo)
    {
        parent[edgeOne] = edgeTwo;
    }
}


void dfs(int currentNode, const vector<vector<int>>& graph, vector<bool>& visited, vector<int>& path) 
{
    visited[currentNode] = true;
    path.push_back(currentNode);

    for (int i = 0; i < graph[currentNode].size(); i++) 
    {
        int neighbor = graph[currentNode][i];
        if (!visited[neighbor]) 
        {
            dfs(neighbor, graph, visited, path);
        }
    }
}

void sortEdges(vector<Edge>& edges) 
{
    bool swapped;
    for (int i = 0; i < edges.size() - 1; i++) 
    {
        swapped = false;
        for (int j = 0; j < edges.size() - i - 1; j++) 
        {
            if (edges[j].weight > edges[j + 1].weight) 
            {
                swap(edges[j], edges[j + 1]);
                swapped = true;
            }
        }
        if (!swapped) 
        {
            break;
        }
    }
}

void buildTree(const vector<Edge>& edges, vector<vector<int>>& adj, vector<int>& parent) 
{
    for (int i = 0; i < edges.size(); i++) 
    {
        int parentU = getParent(edges[i].u, parent);
        int parentV = getParent(edges[i].v, parent);

        if (parentU != parentV)
        {
            cout << "Ребро " << edges[i].u + 1 << " - " << edges[i].v + 1 << " включено в остовное дерево\n";
            adj[edges[i].u].push_back(edges[i].v);
            adj[edges[i].v].push_back(edges[i].u);
            checkAndMergeSets(edges[i].u, edges[i].v, parent);
        }
        else 
        {
            cout << "Ребро " << edges[i].u + 1 << " - " << edges[i].v + 1 << " не включено в остовное дерево\n";
        }
    }
}

void buildTour(const vector<vector<int>>& adj, vector<int>& tour, int startNode) 
{
    vector<bool> visited(adj.size(), false);
    dfs(startNode, adj, visited, tour);
    tour.push_back(startNode); 
}

int calculateTourWeight(const vector<int>& tour, const vector<Edge>& edges)
{
    int weight = 0;
    for (int i = 0; i < tour.size() - 1; i++)
    {
        int u = tour[i];
        int v = tour[i + 1];
        for (int j = 0; j < edges.size(); j++)
        {
            if ((edges[j].u == u && edges[j].v == v) || (edges[j].u == v && edges[j].v == u))
            {
                weight += edges[j].weight;
                break;
            }
        }
    }
    return weight;
}

int main() {
    setlocale(LC_ALL, "ru");

    string path;
    cout << "Введите путь к файлу:\n";
    cin >> path;

    vector<Edge> edges;
    unordered_set<int> uniquePeaks;
 
    readGraph(path, edges, uniquePeaks);
   
    sortEdges(edges);
    cout << "Отсортированные рёбра по весу:\n";
    for (int i = 0; i < edges.size(); i++) 
    {
        cout << "(" << edges[i].u + 1 << "," << edges[i].v + 1 << ")" << " Вес " << edges[i].weight << endl;
    }

    int n = uniquePeaks.size();
    vector<int> parent(n);
    for (int i = 0; i < n; i++) 
    {
        parent[i] = i;
    }
    vector<vector<int>> adj(n);

    buildTree(edges, adj, parent);

    int startNode = 0;

    vector<int> tour;
    buildTour(adj, tour, startNode);

    cout << "\nЭвристический маршрут коммивояжера\n";
    for (int i = 0; i < tour.size(); i++) 
    {
        cout << tour[i] + 1;
        if (i < tour.size() - 1) cout << " -> ";
    }
    cout << endl;

    int tourWeight = calculateTourWeight(tour, edges);
    cout << "Вес маршрута: " << tourWeight << endl;

    return 0;
}

