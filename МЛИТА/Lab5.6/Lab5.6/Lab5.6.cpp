//5.6.Троллейбусы(4)
//Троллейбусы одного маршрута проходят через остановку каждые K минут.
// Известны времена прихода N жителей на остановку.Если человек приходит на остановку в момент прихода троллейбуса, 
// то он успевает войти в этот троллейбус.Определить в пределах часа время прибытия первого троллейбуса на остановку 
// T такого, чтобы суммарное время ожидания троллейбуса для всех граждан было минимальным.
// Если этот минимум достигается в разные моменты прибытия, вывести наиболее раннее время.
//Ввод.Первая строка файла INPUT.TXT содержит целые числа K(2 ≤ K < 60) и N(1 ≤ N ≤ 10^4) через пробел.
// Во второй строке заданы моменты прихода жителей - N целых числа от 0 до 10^4.
//    Вывод.Результат в файле OUTPUT.TXT в виде целого числа T(0 ≤ T ≤ 60).
//    Пример
//    Ввод
//    5 3
//    1 1 2
//    Вывод
//    2
// Бабина Мария ПС 21


#include <iostream>
#include <vector>
#include <fstream>
#include <climits>
#include <algorithm>

using namespace std;


int calculateTotalWait(int T, int K, const vector<int>& arrivals) 
{
    int totalWait = 0;

    for (int arrival : arrivals) 
    {
        int nextTransport = (arrival <= T) ? T : T + ((arrival - T + K - 1) / K) * K;
        totalWait += nextTransport - arrival;
    }

    return totalWait;
}


int findMinTime(int K, const vector<int>& arrivals) 
{
    int minWait = INT_MAX;
    int bestT = 0;

    int minT = max(0, *min_element(arrivals.begin(), arrivals.end()));
    int maxT = min(60, minT + K);

    for (int T = minT; T <= maxT; ++T) 
    {
        int totalWait = calculateTotalWait(T, K, arrivals);

        if (totalWait < minWait)
        {
            minWait = totalWait;
            bestT = T;
        }
    }

    return bestT;
}

void readInput(const string& filename, int& K, int& N, vector<int>& arrivals) 
{
    ifstream fin(filename);
    if (!fin.is_open()) 
    {
        cerr << "Failed to open input file: " << filename << endl;
        exit(1); 
    }

    fin >> K >> N;
    arrivals.resize(N);
    for (int i = 0; i < N; ++i) 
    {
        fin >> arrivals[i];
    }

    fin.close();
}


void writeOutput(const string& filename, int result) 
{
    ofstream fout(filename);
    if (!fout.is_open()) 
    {
        cerr << "Failed to open output file: " << filename << endl;
        exit(1); 
    }

    fout << result << "\n";
    fout.close();
}

int main() {
    int K, N;
    vector<int> arrivals;
    readInput("in6.txt", K, N, arrivals);

    int result = findMinTime(K, arrivals);

    writeOutput("output.txt", result);

    return 0;
}
