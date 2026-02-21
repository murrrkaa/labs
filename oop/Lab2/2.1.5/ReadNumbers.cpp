#include "Constants.h"
#include "ReadNumbers.h"
#include <iostream>  
#include <sstream>  
#include <vector> 
#include <string> 
#include <algorithm>
#include <iomanip>

std::vector<float> ReadNumbers(std::vector<float>& array)
{
	std::string line;
	if (std::getline(std::cin, line))
	{
		std::istringstream iss(line);
		float number;
		while (iss >> number)
		{
			array.push_back(number);
		}
		iss.clear();
		std::string remaining;
		if (iss >> remaining && !iss.eof())
		{
			throw std::runtime_error(ERROR_MESSAGE);
		}
	}
	return array;
}