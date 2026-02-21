#include "ProcessArray.h" 
#include <vector> 
#include <algorithm>

std::vector<float> ProcessArray(std::vector<float> array, std::vector<float>& result_array, float min, float max)
{
	std::transform(array.begin(), array.end(), result_array.begin(), [min, max](float el) 
		{
		return el * max / min;
		});

	return result_array;
}