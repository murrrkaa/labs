//2.2.Электрички(7)
//Железная дорога имеет n станций, пронумерованных в порядке их расположения от 1 до n(2 ≤ n ≤ 800).
// Электрички курсируют в обоих направлениях.Каждая из m электричек(1 ≤ m ≤ 800) может следовать между 
// любыми двумя станциями, останавливаясь как на всех промежуточных станциях, так и на некоторых из них.
// Электрички тратят одинаковое время ti на преодоление расстояния между соседними станциями i и i + 1 
// независимо от своих остановок и направления движения(1 ≤ i ≤ n – 1, 1 ≤ ti ≤ 106).
// Известно расписание движения электричек.Пассажир Вася в определенный момент времени h(1 ≤ h ≤ 106) 
// прибыл на станцию с номером a.Ему нужно как можно раньше добраться до станции b.Помогите Васе.
//Ввод.В первой строке задано число станций n, количество электричек m, номера станций a и b и 
// момент прибытия h на станцию a.Во второй строке содержится n – 1 значений t1, t2, …, tn - 1. 
// В следующих m строках задается расписание движения поездов.Для каждого i - го 
// поезда указываются время отправления si от начальной станции, количество остановок ki, 
// включая начальную и конечную станции, номера станций для остановки в порядке следования электрички.
// Все числа целые и не превышают 106.
//Вывод.В единственной строке вывести наиболее ранний момент времени достижения станции b.
// Если станция b недостижима, вывести No.Время стоянки электричек на станциях не учитывается.
// 
//Бабина Мария ПС-21

#include <iostream>
#include <vector>
#include <queue>
#include <climits>
#include <fstream>
#include <set>

using namespace std;

const string INPUT_FILE_NAME = "input20.txt";
const string OUTPUT_FILE_NAME = "output.txt";

struct Train 
{
    int departure_time;
    vector<int> stops;
    vector<int> arrival_times;
};

struct Station 
{
    int id;
    int time;

    bool operator<(const Station& other) const 
    {
        if (time == other.time)
            return id < other.id;
        return time < other.time;
    }
};

void readInput(ifstream& inputFile, int& n, int& m, int& a, int& b, int& h, vector<int>& t, vector<Train>& trains) 
{
    inputFile >> n >> m >> a >> b >> h;

    t.resize(n - 1);
    for (int i = 0; i < n - 1; ++i) 
    {
        inputFile >> t[i];
    }

    trains.resize(m);
    for (int i = 0; i < m; ++i) 
    {
        int si, ki;
        inputFile >> si >> ki;
        trains[i].departure_time = si;
        trains[i].stops.resize(ki);
        for (int j = 0; j < ki; ++j) 
        {
            inputFile >> trains[i].stops[j];
        }
    }
}

void calculateArrivalTimes(vector<Train>& trains, const vector<int>& t) 
{
    for (auto& train : trains) 
    {
        train.arrival_times.resize(train.stops.size());
        train.arrival_times[0] = train.departure_time;
        for (size_t j = 1; j < train.stops.size(); ++j) 
        {
            int prev_stop = train.stops[j - 1];
            int curr_stop = train.stops[j];
            int travel_time = 0;
            for (int k = min(prev_stop, curr_stop); k < max(prev_stop, curr_stop); ++k) 
            {
                travel_time += t[k - 1];
            }
            train.arrival_times[j] = train.arrival_times[j - 1] + travel_time;
        }
    }
}
void initializeQueue(set<Station>& queue, int start, int start_time)
{
    queue.insert({ start, start_time });
}

vector<vector<int>> buildStationToTrainsMap(const vector<Train>& trains, int num_stations) 
{
    vector<vector<int>> station_to_trains(num_stations + 1);
    for (int i = 0; i < trains.size(); ++i) 
    {
        for (int stop : trains[i].stops) 
        {
            station_to_trains[stop].push_back(i);
        }
    }
    return station_to_trains;
}

void updateTimeToNextStations(const Train& train, size_t current_stop_index,
    vector<int>& earliest_arrival, set<Station>& pq) {
    for (size_t j = current_stop_index + 1; j < train.stops.size(); ++j) 
    {
        int next_station = train.stops[j];
        int arrival_time = train.arrival_times[j];
        if (arrival_time < earliest_arrival[next_station]) 
        {
            if (earliest_arrival[next_station] != INT_MAX) 
            {
                pq.erase({ next_station, earliest_arrival[next_station] });
            }
            earliest_arrival[next_station] = arrival_time;
            pq.insert({ next_station, arrival_time });
        }
    }
}

void processCurrentStation(const Station& current, const vector<vector<int>>& station_to_trains,
    const vector<Train>& trains, vector<int>& earliest_arrival, set<Station>& pq) {

    for (int train_index : station_to_trains[current.id]) 
    {
        const Train& train = trains[train_index];
        for (size_t i = 0; i < train.stops.size(); ++i) 
        {
            if (train.stops[i] == current.id && train.arrival_times[i] >= earliest_arrival[current.id]) 
            {
                updateTimeToNextStations(train, i, earliest_arrival, pq);
                break;
            }
        }
    }
}

void bfs(int start, int end, const vector<Train>& trains, vector<int>& earliest_arrival) 
{
    set<Station> queue;
    initializeQueue(queue, start, earliest_arrival[start]);

    vector<vector<int>> station_to_trains = buildStationToTrainsMap(trains, earliest_arrival.size() - 1);

    while (!queue.empty())
    {
        Station current = *queue.begin();
        queue.erase(queue.begin());

        if (current.id == end) break;

        processCurrentStation(current, station_to_trains, trains, earliest_arrival, queue);
    }
}

void printResult(ofstream& outputFile, int end, const vector<int>& earliest_arrival) 
{
    if (earliest_arrival[end] != INT_MAX) 
    {
        outputFile << earliest_arrival[end] << endl;
    }
    else {
        outputFile << "No" << endl;
    }
}

int main() {
    int n, m, a, b, h;
    vector<int> t;
    vector<Train> trains;

    ifstream inputFile;
    inputFile.open(INPUT_FILE_NAME);

    if (!inputFile.is_open()) 
    {
        cout << "Failed to open input file!\n";
        return 1;
    }

    readInput(inputFile, n, m, a, b, h, t, trains);

    calculateArrivalTimes(trains, t);

    vector<int> earliest_arrival(n + 1, INT_MAX);
    earliest_arrival[a] = h;

    bfs(a, b, trains, earliest_arrival);

    ofstream outputFile;
    outputFile.open(OUTPUT_FILE_NAME);
    if (!outputFile.is_open()) 
    {
        cout << "Failed to open output file!\n";
        return 1;
    }

    printResult(outputFile, b, earliest_arrival);

    return 0;
}