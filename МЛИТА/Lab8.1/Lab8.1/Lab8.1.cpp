//8.1.Слова(3)
//Дано слово, состоящее из M(2 ≤ M ≤ 7) строчных букв латинского алфавита.
// Найти все перестановки символов данного слова.
//Ввод из файла INPUT.TXT.В первой строке файла находится исходное слово.
//Вывод в файл OUTPUT.TXT.
// Вывести в алфавитном порядке без повторений все перестановки символов данного слова 
// по одной перестановке в каждой строке файла.
//Бабина Мария ПС 21

#include <iostream>
#include <fstream>
#include <set>
#include <string>

using namespace std;

void findPermutations(string& s, int pos, set<string>& permutations) 
{
    int n = s.size();
    if (pos == n - 1) 
    {
        permutations.insert(s);
        return;
    }

    for (int k = pos; k < n; k++) 
    {
        if (pos != k) 
        {
            swap(s[pos], s[k]);
        }
        findPermutations(s, pos + 1, permutations);
        if (pos != k) 
        {
            swap(s[pos], s[k]);
        }
    }
}

string readWordFromFile(const string& filename) 
{
    ifstream inputFile(filename);
    if (!inputFile.is_open()) 
    {
        cerr << "Failed to open input file: " << filename << endl;
        exit(1);
    }

    string word;
    inputFile >> word;
    inputFile.close();

    return word;
}


void writePermutationsToFile(const set<string>& permutations, const string& filename) 
{
    ofstream outputFile(filename);
    if (!outputFile.is_open()) 
    {
        cerr << "Failed to open output file: " << filename << endl;
        exit(1); 
    }

    for (const string& permutation : permutations) 
    {
        outputFile << permutation << "\n";
    }

    outputFile.close();
}

int main() {
    string word = readWordFromFile("INPUT.TXT");

    if (word.length() < 2 || word.length() > 7)
    {
        std::cout << "Invalid input data";
        return 1;
    }

    set<string> permutations;

    findPermutations(word, 0, permutations);

    writePermutationsToFile(permutations, "OUTPUT.TXT");

    return 0;
}

