#include <iostream>
#include <memory>
#include <string>
#include <vector>
#include <optional>
#include <functional>
#include <chrono>
#include <locale>
#include <cmath>

#include <tchar.h>
#include <Windows.h>

#include "BitmapPlusPlus.hpp"

using namespace std;
using namespace bmp;

struct Args
{
    string inputFileName;
    string outputFileName;
    int threadsCount;
    int coresCount;
};

struct ProcessBitmapInfo
{
    Bitmap* src;
    Bitmap* dst;
    unsigned startX;
    size_t width;
};

optional<Args> ParseArgs(int argc, char* argv[])
{
    if (argc < 5)
    {
        return nullopt;
    }

    Args result;

    result.inputFileName = argv[1];
    result.outputFileName = argv[2];

    try
    {
        result.coresCount = stoi(argv[3]);
        result.threadsCount = stoi(argv[4]);
    }
    catch (...)
    {
        return nullopt;
    }

    return result;
}

Pixel GetBlurredPixel(Bitmap const& img, int x, int y)
{
    int sumR = 0, sumG = 0, sumB = 0;
    int count = 0;

    for (int i = -10; i <= 10; i++)
    {
        int xi = x + i;
        if (xi < 0 || xi >= img.width()) continue;

        for (int j = -10; j <= 10; j++)
        {
            int yj = y + j;
            if (yj < 0 || yj >= img.height()) continue;

            Pixel p = img.get(xi, yj);
            sumR += p.r;
            sumG += p.g;
            sumB += p.b;
            count++;
        }
    }

    return Pixel(sumR / count, sumG / count, sumB / count);
}

DWORD WINAPI BlurBitmap(CONST LPVOID lpParam)
{
    auto data = reinterpret_cast<ProcessBitmapInfo*>(lpParam);

    Bitmap* src = data->src;
    Bitmap* dst = data->dst;
    int startX = data->startX;
    int endX = startX + static_cast<unsigned>(data->width);
    int imageHeight = src->height();

    for (int x = startX; x < endX; ++x)
    {
        for (int y = 0; y < imageHeight; ++y)
        {
            dst->set(x, y, GetBlurredPixel(*src, x, y));
        }
    }

    delete data;
    ExitThread(0);
}

unique_ptr<HANDLE[]> CreateThreads(size_t count, function<ProcessBitmapInfo* (int)> createData)
{
    auto threads = make_unique<HANDLE[]>(count);

    for (unsigned i = 0; i < count; i++)
    {
        threads[i] = CreateThread(
            NULL, 0, &BlurBitmap, createData(i), CREATE_SUSPENDED, NULL
        );
    }

    return threads;
}

void SetCoresLimit(size_t limit)
{
    SYSTEM_INFO sysinfo;
    GetSystemInfo(&sysinfo);
    size_t maxCoresCount = sysinfo.dwNumberOfProcessors;

    if (limit > maxCoresCount)
    {
        cout << "Max cores count is " << maxCoresCount << endl;
        limit = maxCoresCount;
    }

    auto procHandle = GetCurrentProcess();
    DWORD_PTR mask = static_cast<DWORD_PTR>((pow(2, maxCoresCount) - 1) / pow(2, maxCoresCount - limit));

    SetProcessAffinityMask(procHandle, mask);
}

function<chrono::duration<double>()> StartTimer()
{
    chrono::steady_clock::time_point start = chrono::steady_clock::now();

    return [start]()
        {
            return chrono::steady_clock::now() - start;
        };
}

int main(int argc, char* argv[])
{
    auto args = ParseArgs(argc, argv);

    if (!args)
    {
        cout << "Params format: <input file name> <output file name> <cores count> <threads count>" << endl;
        return -1;
    }

    try
    {
        SetCoresLimit(args->coresCount);

        auto getEllapsedTime = StartTimer();

        Bitmap* image = new Bitmap(args->inputFileName);
        Bitmap* dstImage = new Bitmap(image->width(), image->height());
        unsigned imageWidth = image->width();
        unsigned baseColWidth = imageWidth / args->threadsCount;
        unsigned remainder = imageWidth % args->threadsCount;

        int blurPasses = 5;

        for (int pass = 0; pass < blurPasses; ++pass)
        {
            auto threads = CreateThreads(args->threadsCount, [image, dstImage, baseColWidth, remainder](unsigned threadNumber) {
                unsigned startX = threadNumber * baseColWidth + min<unsigned>(threadNumber, remainder);
                unsigned thisWidth = baseColWidth + (threadNumber < remainder ? 1 : 0);

                return new ProcessBitmapInfo{
                    image,
                    dstImage,
                    startX,
                    thisWidth
                };
                });

            for (int i = 0; i < args->threadsCount; i++)
                ResumeThread(threads[i]);

            WaitForMultipleObjects(args->threadsCount, threads.get(), true, INFINITE);

            swap(image, dstImage);
        }

        image->save(args->outputFileName);

        delete image;
        delete dstImage;

        cout << getEllapsedTime().count() << endl;
    }
    catch (const bmp::Exception& e)
    {
        cout << e.what() << endl;
        return -1;
    }

    return 0;
}