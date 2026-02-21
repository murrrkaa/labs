#include "Constants.h"
#include "ReadNumbers.h"
#include "FindMinMax.h"
#include "PrintResult.h"
#include "ProcessArray.h"
#include <iomanip>
#include <iostream>   
#include <vector> 
#include <string> 
#include <iomanip>

int main()
{
	try 
	{
		std::vector<float> array;
		ReadNumbers(array);
		if (array.empty())
		{
			return 0;
		}
		auto [min, max] = FindMinMax(array);
		std::vector<float> result_array(array.size());
		ProcessArray(array, result_array, min, max);
		PrintResult(result_array);
	}
	catch(const std::runtime_error& e)
	{
		std::cout << e.what();
		return 0;
	}

	return 0;
}
