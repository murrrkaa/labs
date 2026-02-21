#include <iostream>
#include <cstdlib>
#include <string>
#include <algorithm>

const long long MAX_VALUE = 4294967295;
const int MIN_VALUE = 0;
const int ERROR_VALIDATION = -1;
const std::string ERROR_INVALID_NUMBER = "ERROR\n";
const std::string REFERENCE = "Usage: dec2bin.exe [NUMBER]\nConvert a decimal number to binary.\n\nIf no NUMBER is provided, the program reads from stdin.\n";

using NumberType = long long;

void PrintUsage()
{
    std::cout << REFERENCE;
}

std::string EnterValue()
{
    std::string number;
    std::cin >> number;
    return number;
}

std::string ParseArgument(int argc, char* argv[], bool& fromStdIn)
{
    if (argc == 2)
    {
        return argv[1];
    }
    else
    {
        fromStdIn = true;
        std::string number = EnterValue();
        return number;
    }
}

NumberType ConvertToNumber(std::string arg)
{
    return std::stoull(arg);
}

std::string DecToBin(NumberType number)
{
    std::string binaryNumber;

    if (number == 0)
    {
        binaryNumber = "0";
    }

    while (number > 0)
    {
        int remainderOfDivision = number % 2;
        binaryNumber += !remainderOfDivision ? "0" : "1";
        number /= 2;
    }
    std::reverse(binaryNumber.begin(), binaryNumber.end());
    return binaryNumber;
}

NumberType CheckNumberForBoundaries(NumberType number)
{
    if (number < MIN_VALUE || number > MAX_VALUE)
    {
        throw std::out_of_range(ERROR_INVALID_NUMBER);
    }
    return number;
}

bool IsValidDecimalNumber(const std::string& str)
{
    if (str.empty()) return false;

    for (int i = 0; i < str.length(); i++)
    {
        if (!isdigit(str[i]))
        {
            return false;
        }
    }
    return true;
}

NumberType ValidateNumber(std::string arg)
{
    if (IsValidDecimalNumber(arg))
    {
        try
        {
            NumberType number = ConvertToNumber(arg);
            NumberType numberChecked = CheckNumberForBoundaries(number);
            return numberChecked;
        }
        catch (std::invalid_argument)
        {
            return ERROR_VALIDATION;
        }
        catch (std::out_of_range)
        {
            return ERROR_VALIDATION;
        }
    }
    else
    {
        return ERROR_VALIDATION;
    }
}

int main(int argc, char* argv[])
{
    bool fromStdin = false;
    std::string argument = ParseArgument(argc, argv, fromStdin);
    if (argument == "-h")
    {
        PrintUsage();
        return 0;
    }

    NumberType number = ValidateNumber(argument);

    if (number != ERROR_VALIDATION)
    {
        std::string binaryBumber = DecToBin(number);
        std::cout << binaryBumber << "\n";
    }
    else
    {
        std::cout << ERROR_INVALID_NUMBER;
        if (fromStdin)
        {
            return 0;
        } 
        else
        {
            return 1;
        }
    }
    return 0;
}
