#include <iostream>
#include <vector>
#include <cmath>
#include <fstream>

using namespace std;

// Смещения для 8-связной окрестности
const int dx[8] = { -1, -1, -1, 0, 1, 1, 1, 0 };
const int dy[8] = { -1, 0, 1, 1, 1, 0, -1, -1 };

bool isBoundary(int x, int y, int M, int N, const vector<vector<int>>& grid) {
    for (int i = 0; i < 8; ++i) {
        int nx = x + dx[i];
        int ny = y + dy[i];
        if (nx < 0 || ny < 0 || nx >= M || ny >= N || grid[nx][ny] == 0)
            return true;
    }
    return false;
}

int countCorners(int x, int y, int M, int N, const vector<vector<int>>& grid) {
    int count = 0;
    for (int i = 0; i < 8; i += 2) {
        int nx = x + dx[i];
        int ny = y + dy[i];
        if (nx < 0 || ny < 0 || nx >= M || ny >= N || grid[nx][ny] == 0)
            count++;
    }
    return count;
}

int main() {
    ifstream input("INPUT.TXT");
    ofstream output("OUTPUT.TXT");

    int M, N, L;
    input >> M >> N >> L;

    vector<vector<int>> grid(M, vector<int>(N));
    for (int i = 0; i < M; ++i)
        for (int j = 0; j < N; ++j)
            input >> grid[i][j];

    double perimeter = 0.0;
    double halfL = L / 2.0;

    for (int i = 0; i < M; ++i) {
        for (int j = 0; j < N; ++j) {
            if (grid[i][j] == 1 && isBoundary(i, j, M, N, grid)) {
                perimeter += L + L; // Две стороны границы

                // Считаем углы для округления
                int corners = countCorners(i, j, M, N, grid);
                perimeter += corners * (M_PI * halfL / 2);
            }
        }
    }

    output << fixed;
    output.precision(1);
    output << perimeter << endl;

    return 0;
}

// Программа считает длину безопасного маршрута, включая скругление углов! 🚀
