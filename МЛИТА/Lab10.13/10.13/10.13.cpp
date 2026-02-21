//10.13.Квадрат в квадрате(5)
//Требуется в каждую клетку квадратной таблицы размером N × N поставить ноль или единицу так, 
// чтобы в максимальном количестве квадратов размера K×K было ровно S единиц.
//Ввод из файла INPUT.TXT.Единственная строка  содержит  три  числа : N, K, S(1 ≤ N ≤ 500, 1 ≤ K ≤ N, 0 ≤ S ≤ K2).
//Вывод в файл OUTPUT.TXT.В первую строку необходимо вывести максимальное число квадратов из нулей 
// и единиц размера K×K, в каждом из которых ровно S единиц.В следующих N строках вывести по N 
// элементов в строке полученную таблицу из нулей и единиц.Если решений несколько, то вывести любое из них.
//Пример
//Ввод
//4 2 2
//Вывод
//9
//1 0 0 1
//0 1 1 0
//1 0 0 1
//0 1 1 0
//Бабина Мария ПС 21

#include <iostream>
#include <fstream>
#include <vector>

using Matrix = std::vector<std::vector<int>>;
const std::string INPUT_FILE_NAME = "input5.txt";
const std::string OUTPUT_FILE_NAME = "output5.txt";

Matrix buildSubMatrix(int K, int S)
{
    Matrix subMatrix(K, std::vector<int>(K, 0));
    int count = 0;
    for (int i = 0; i < K; ++i)
    {
        for (int j = 0; j < K; ++j)
        {
            if (count < S)
            {
                subMatrix[i][j] = 1;
                count++;
            }
        }
    }
    return subMatrix;
}

Matrix fillGridMatrix(int N, int K, const Matrix& subMatrix)
{
    Matrix gridMatrix(N, std::vector<int>(N));
    for (int i = 0; i < N; ++i)
    {
        for (int j = 0; j < N; ++j)
        {
            gridMatrix[i][j] = subMatrix[i % K][j % K];
        }
    }
    return gridMatrix;
}

Matrix buildPrefixSum(const Matrix& gridMatrix)
{
    int N = gridMatrix.size();
    Matrix prefixSum(N + 1, std::vector<int>(N + 1, 0));
    for (int i = 1; i <= N; ++i)
    {
        for (int j = 1; j <= N; ++j)
        {
            prefixSum[i][j] = gridMatrix[i - 1][j - 1] + prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1];
        }
    }
    return prefixSum;
}

int squareSum(const Matrix& prefixSum, int x, int y, int K)
{
    return prefixSum[x + K][y + K] - prefixSum[x][y + K] - prefixSum[x + K][y] + prefixSum[x][y];
}

int countValidSquares(const Matrix& prefixSum, int N, int K, int S)
{
    int count = 0;
    for (int i = 0; i <= N - K; ++i)
    {
        for (int j = 0; j <= N - K; ++j)
        {
            if (squareSum(prefixSum, i, j, K) == S)
            {
                ++count;
            }
        }
    }
    return count;
}

void printGrid(std::ofstream& fout, const Matrix& gridMatrix)
{
    int N = gridMatrix.size();
    for (int i = 0; i < N; ++i)
    {
        for (int j = 0; j < N; ++j)
        {
            fout << gridMatrix[i][j] << (j + 1 == N ? '\n' : ' ');
        }
    }
}

int main() {
    std::ifstream inputFile(INPUT_FILE_NAME);
    if (!inputFile.is_open()) {
        std::cout << "Failed to open input file!\n";
        return 1;
    }

    int N, K, S;
    inputFile >> N >> K >> S;
    inputFile.close();

    std::ofstream outputFile(OUTPUT_FILE_NAME);
    if (!outputFile.is_open()) {
        std::cout << "Failed to open output file!\n";
        return 1;
    }

    Matrix subMatrix = buildSubMatrix(K, S);
    Matrix gridMatrix = fillGridMatrix(N, K, subMatrix);
    Matrix prefixSum = buildPrefixSum(gridMatrix);
    int count = countValidSquares(prefixSum, N, K, S);

    outputFile << count << '\n';
    printGrid(outputFile, gridMatrix);

    outputFile.close();

    return 0;
}

