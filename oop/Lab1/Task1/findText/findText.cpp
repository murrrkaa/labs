#include <iostream>
#include <string>
#include <fstream>
#include <optional>

std::string const ERROR_ARGUMENTS_COUNT = "Invalid arguments count. Usage: <program> <filename> <text_to_search>\n";
std::string const ERROR_OPENING_FILE = "Failed to open file\n";
std::string const ERROR_TEXT_NOT_FOUND = "Text not found\n";

struct Args {
   std::string inputFileName;
   std::string searchedText;
};

std::optional<Args> ParseArguments(int argc, char* argv[])
{
    if (argc != 3)
    {
        return std::nullopt;
    }

    Args args;
    args.inputFileName = argv[1];
    args.searchedText = argv[2];
    return args;
}

std::ifstream OpenFile(std::string inputFileName)
{
    std::ifstream inputFile;
    inputFile.open(inputFileName);
    return inputFile;
}


bool IsFoundText(std::ifstream& inputFile, std::string searchedText)
{
    bool isFound = false;
    std::string str;
    int lineNumber = 0;

    if (searchedText.empty()) {
        return isFound;
    }

    while (std::getline(inputFile, str))
    {
        lineNumber += 1;
        if (str.find(searchedText) != std::string::npos) {
            isFound = true;
            std::cout << lineNumber << "\n";
        }
    }
    return isFound;
}


int main(int argc, char* argv[])
{
    auto args = ParseArguments(argc, argv);
    if (!args)
    {
        std::cout << ERROR_ARGUMENTS_COUNT;
        return 2;
    }

    std::ifstream inputFile = OpenFile(args->inputFileName);
    if (!inputFile.is_open())
    {
        std::cout << ERROR_OPENING_FILE;
        return 3;
    }

    if (!IsFoundText(inputFile, args->searchedText)) {
        std::cout << ERROR_TEXT_NOT_FOUND;
        return 1;
    }

    inputFile.close();

    return 0;
}

