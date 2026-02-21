#include "PrintResult.h"
#include <iostream>  
#include <vector> 
#include <algorithm>
#include <iomanip>

void PrintResult(std::vector<float> result)
{
	std::cout << std::fixed << std::setprecision(3);

	std::for_each(result.begin(), result.end(), [](float el) 
		{
		std::cout << el << " ";
		});

	std::cout << "\n";
}