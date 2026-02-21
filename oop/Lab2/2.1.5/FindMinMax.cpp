#include "Constants.h"
#include "FindMinMax.h" 
#include <vector> 
#include <string> 
#include <algorithm>
#include <iomanip>

std::pair<float, float> FindMinMax(std::vector<float>& array)
{
	auto [min_el, max_el] = std::minmax_element(array.begin(), array.end());

	if (*min_el == 0)
	{
		throw std::runtime_error(ERROR_MESSAGE);
	}

	return { *min_el, *max_el };
}