//13.4.Циклический сдвиг(5)
//Последовательность круглых скобок называют правильной, если можно добавить в нее числа и знаки 
//арифметических операций так, что полученное алгебраическое выражение станет корректным.
//Например, скобочная последовательность(())() является правильной, а(())) и())(() такими не являются.
//    Задана скобочная последовательность из N символов(1 ≤ N ≤ 6×105).
//    Найти минимальный номер позиции, начиная с которой последовательность, 
//    образованная циклическим сдвигом, окажется правильной скобочной последовательностью.
//    Ввод из файла INPUT.TXT.В первой строке задано значение N.Во второй строке 
//    находится скобочная последовательность длины N.
//    Вывод в файл OUTPUT.TXT.Вывести номер позиции.Если правильную скобочную 
//    последовательность получить невозможно, вывести No.
//    Примеры
//    Ввод 1       Ввод 2       Ввод 3
//    8            6            6
//    ((())())     ()))((       ((())(  
//        Вывод 1      Вывод 2      Вывод 3
//        1            5            No
// Бабина Мария ПС 21

#include <iostream>
#include <fstream>
#include <string>
#include <vector>

const std::string INPUT_FILE_NAME = "input7.txt";
const std::string OUTPUT_FILE_NAME = "output.txt";

int findMinShiftPosition(int n, const std::string& s) 
{
    int openCount = 0, closeCount = 0;
    for (char c : s) 
    {
        if (c == '(')
        {
            openCount++;
        }
        else
        {
            closeCount++;
        }
    }

    if (openCount != closeCount) 
    {
        return -1;
    }

    int balance = 0;
    int minBalance = 0;
    int minPos = 0;

    for (int i = 0; i < n; ++i) 
    {
        if (s[i] == '(') 
        {
            balance++;
        }
        else
        {
            balance--;
        }

        if (balance < minBalance) 
        {
            minBalance = balance;
            minPos = i + 1;
        }
    }

    balance = 0;
    for (int i = 0; i < n; ++i) 
    {
        int pos = (minPos + i) % n;
        if (s[pos] == '(') 
        {
            balance++;
        }
        else 
        {
            balance--;
        }

        if (balance < 0) 
        {
            return -1;
        }
    }

    return (balance == 0) ? (minPos + 1) : -1;
}

bool readInput(int& n, std::string& s) 
{
    std::ifstream inputFile(INPUT_FILE_NAME);
    if (!inputFile.is_open()) 
    {
        std::cout << "Failed to open input file!\n";
        return false;
    }
    inputFile >> n >> s;
    inputFile.close();
    return true;
}

bool writeOutput(int result) 
{
    std::ofstream outputFile(OUTPUT_FILE_NAME);
    if (!outputFile.is_open()) 
    {
        std::cout << "Failed to open output file!\n";
        return false;
    }
    if (result == -1) 
    {
        outputFile << "No\n";
    }
    else 
    {
        outputFile << result << std::endl;
    }
    outputFile.close();
    return true;
}

int main() 
{
    int n;
    std::string inputStr;

    if (!readInput(n, inputStr)) 
    {
        return 1;
    }

    int result = findMinShiftPosition(n, inputStr);

    if (!writeOutput(result))
    {
        return 1;
    }

    return 0;
}