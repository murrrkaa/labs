//17.2.Инверсии 2 (7)
//Задан вектор инверсий перестановки X = (X1, X2, …, XN) чисел от до N(1≤ N ≤ 500000).
// Требуется найти саму перестановку.
//Пример
//Ввод
//5
//0 0 1 3 2
//Вывод
//2 5 4 1 3
//Бабина Мария ПС 21

#include <iostream>
#include <vector>
#include <fstream>

const std::string INPUT_FILE_NAME = "input9.txt";
const std::string OUTPUT_FILE_NAME = "output.txt";

bool readInput(int& N, std::vector<int>& inversionsX)
{
    std::ifstream input(INPUT_FILE_NAME);
    if (!input.is_open())
    {
        std::cout << "Failed to open input file!\n";
        return false;
    }

    input >> N;
    inversionsX.resize(N);
    for (int i = 0; i < N; ++i)
    {
        input >> inversionsX[i];
    }

    input.close();
    return true;
}

bool writeOutput(const std::vector<int>& permutation)
{
    std::ofstream output(OUTPUT_FILE_NAME);
    if (!output.is_open())
    {
        std::cout << "Failed to open output file!\n";
        return false;
    }

    for (int i = 0; i < permutation.size(); ++i)
    {
        output << permutation[i];
        if (i != permutation.size() - 1)
        {
            output << " ";
        }
    }
    output << "\n";

    output.close();
    return true;
}

void updateTree(std::vector<int>& tree, int index, int delta)
{
    while (index < static_cast<int>(tree.size()))
    {
        tree[index] += delta;
        index += index & -index;
    }
}

void initTree(std::vector<int>& tree, int N)
{
    for (int i = 1; i <= N; ++i)
    {
        updateTree(tree, i, 1);
    }
}

int calcSum(const std::vector<int>& tree, int index) 
{
    int result = 0;
    while (index > 0)
    {
        result += tree[index];
        index -= index & -index;
    }
    return result;
}

int findElement(const std::vector<int>& tree, int k) 
{
    int left = 1, right = static_cast<int>(tree.size()) - 1;
    int result = right;
    while (left <= right) 
    {
        int middle = (left + right) / 2;
        int sum = calcSum(tree, middle);
        if (sum >= k) 
        {
            result = middle;
            right = middle - 1;
        }
        else 
        {
            left = middle + 1;
        }
    }
    return result;
}

std::vector<int> restorePermutation(int N, const std::vector<int>& inversionsX) 
{
    std::vector<int> tree(N + 1, 0);
    initTree(tree, N);
    
    std::vector<int> P(N);
    for (int i = N - 1; i >= 0; --i) 
    {
        int k = (i + 1) - inversionsX[i];
        int num = findElement(tree, k);
        P[i] = num;
        updateTree(tree, num, -1);
    }
    return P;
}

int main() 
{
    int N;
    std::vector<int> inversionsX;

    if (!readInput(N, inversionsX))
    {
        return 1;
    }

    std::vector<int> permutation = restorePermutation(N, inversionsX);

    if (!writeOutput(permutation)) 
    {
        return 1;
    }

    return 0;
}