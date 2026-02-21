//Учебный план включает перечень дисциплин.Задан список
//пар   дисциплин.Отдельная   пара   показывает, что  вторая
//дисциплина должна изучаться  после  первой.Составить  список
//дисциплин учебного плана в порядке их изучения.В том случае,
//когда задание некорректно, т.е.в списке пар имеются  циклы,
//выдать хотя бы один из них(10).
//Бабина Мария ПС 21

#include <iostream>
#include <vector>
#include <string>
#include <fstream>

struct DisciplinedCouple {
    std::string first;
    std::string second;
};


void printCycle(const std::vector<std::string>& cycle) {
    std::cout << "Cycle\n";
    for (int i = cycle.size() - 1; i >= 0; --i) {
        std::cout << cycle[i] << " ";
    }
    std::cout << std::endl;
}


int findIndex(const std::string& discipline, const std::vector<std::string>& disciplines) {
    for (int i = 0; i < disciplines.size(); ++i) {
        if (disciplines[i] == discipline) {
            return i;
        }
    }
    return -1;  
}


bool DFS(int node, const std::vector<std::vector<int>>& graph, std::vector<bool>& visited,
    std::vector<bool>& stackForCycle, std::vector<int>& sortedOrder, std::vector<int>& parent,
    std::vector<std::string>& disciplines, std::vector<std::string>& cycle) {

    visited[node] = true;
    stackForCycle[node] = true;

    for (int i = 0; i < graph[node].size(); ++i) {
        int neighbor = graph[node][i];
        if (!visited[neighbor]) {
            parent[neighbor] = node;
            if (DFS(neighbor, graph, visited, stackForCycle, sortedOrder, parent, disciplines, cycle)) {
                return true;
            }
        }

        if (stackForCycle[neighbor]) {
            cycle.push_back(disciplines[neighbor]);
            int current = node;
            while (current != neighbor) {
                cycle.push_back(disciplines[current]);
                current = parent[current];
            }
            cycle.push_back(disciplines[neighbor]);
            return true;
        }
    }

    stackForCycle[node] = false;
    sortedOrder.push_back(node); 
    return false;
}

bool sortingOfDisciplines(const std::vector<DisciplinedCouple>& disciplined, std::vector<std::string>& sortedOrder) {
    std::vector<std::string> disciplines;


    for (int i = 0; i < disciplined.size(); ++i) {
        const auto& pair = disciplined[i];
        if (findIndex(pair.first, disciplines) == -1) {
            disciplines.push_back(pair.first);
        }
        if (findIndex(pair.second, disciplines) == -1) {
            disciplines.push_back(pair.second);
        }
    }

    int n = disciplines.size();
    std::vector<bool> visited(n, false);
    std::vector<bool> stackForCycle(n, false);
    std::vector<int> parent(n, -1);
    std::vector<std::vector<int>> graph(n);

    for (int i = 0; i < disciplined.size(); ++i) {
        const auto& pair = disciplined[i];
        int u = findIndex(pair.first, disciplines);
        int v = findIndex(pair.second, disciplines);
        graph[u].push_back(v);
    }

    std::vector<std::string> cycle;
    std::vector<int> sortedDisciplinesIndex;

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            if (DFS(i, graph, visited, stackForCycle, sortedDisciplinesIndex, parent, disciplines, cycle)) {
                printCycle(cycle);
                return false;  
            }
        }
    }

    for (int i = sortedDisciplinesIndex.size() - 1; i >= 0; i--) {
        sortedOrder.push_back(disciplines[sortedDisciplinesIndex[i]]);
    }

    return true;
}

void printDisciplinesList(const std::vector<std::string>& sortedDisciplined) {
    for (int i = 0; i < sortedDisciplined.size(); ++i) {
        std::cout << sortedDisciplined[i] << " ";
    }
}


int main()
{
    setlocale(LC_ALL, "ru");

    std::string path;
    std::cout << "Введите путь к файлу:\n";
    std::cin >> path;
    std::ifstream file;
    file.open(path);

    std::vector<DisciplinedCouple> disciplined;

    if (file.is_open()) {
        std::string str;
        std::locale::global(std::locale("ru_RU.UTF-8"));

        while (getline(file, str)) { 
            int pos = str.find(' ');
            std::string first = str.substr(0, pos); 
            std::string second = str.substr(pos + 1);
            disciplined.push_back({ first, second });
            
        }

        std::vector<std::string> sortedDisciplined;
        if (sortingOfDisciplines(disciplined, sortedDisciplined)) {
            printDisciplinesList(sortedDisciplined);
        }
    }
    else {
        std::cout << "Не удалось открыть файл!" << "\n";
    }

    return 0;
}