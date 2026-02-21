#include <iostream>
#include <chrono>
#include <omp.h>

double calcSync(long limit) 
{
    double sum = 0.0;

    for (long k = 0; k < limit; ++k) 
    {
        double sign = (k & 1) ? -1.0 : 1.0;
        sum += sign / (2.0 * k + 1.0);
    }
    return sum * 4.0;
}

double calcParallelWrong(long limit) 
{
    double total = 0.0;

#pragma omp parallel for shared(total, limit)
    for (long k = 0; k < limit; ++k) 
    {
        double sign = (k & 1) ? -1.0 : 1.0;
        total += sign / (2.0 * k + 1.0);
    }
    return total * 4.0;
}

double calcParallelAtomic(long limit) 
{
    double total = 0.0;

#pragma omp parallel shared(total, limit) 
{
    #pragma omp for
    for (long k = 0; k < limit; ++k) 
    {
        double value = ((k & 1) ? -1.0 : 1.0) / (2.0 * k + 1.0);

        #pragma omp atomic
        total += value;
    }
}
    return total * 4.0;
}

double calcParallelReduction(long limit) {
    double total = 0.0;

#pragma omp parallel for reduction(+:total) shared(limit)
    for (long k = 0; k < limit; ++k) 
    {
        double sign = (k & 1) ? -1.0 : 1.0;
        total += sign / (2.0 * k + 1.0);
    }
    return total * 4.0;
}

int main()
{
    const long N = 100000000;

    auto measureTime = [](auto func, const char* label, long n) 
        {
            auto t1 = std::chrono::high_resolution_clock::now();
            double res = func(n);
            auto t2 = std::chrono::high_resolution_clock::now();

            double elapsed = std::chrono::duration<double>(t2 - t1).count();
            std::cout << label << ": " << res << " | time: " << elapsed << " sec\n";
        };

    measureTime(calcSync, "SYNC", N);
    measureTime(calcParallelWrong, "Parallel WRONG", N);
    measureTime(calcParallelAtomic, "Parallel ATOMIC", N);
    measureTime(calcParallelReduction, "Parallel REDUCTION", N);

    return 0;
}