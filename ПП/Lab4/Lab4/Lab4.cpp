#include <iostream>
#include <memory>
#include <string>
#include <vector>
#include <optional>
#include <functional>
#include <chrono>
#include <locale>
#include <cmath>
#include <fstream>
#include <mutex>
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
    unsigned threadNumber;
    int priorityValue;
    ofstream* logFile;
    mutex* logMutex;
};

chrono::steady_clock::time_point g_start;

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

vector<int> ParsePriorityValues(int argc, char* argv[], int threadCount)
{
    vector<int> priorityValues(threadCount, THREAD_PRIORITY_NORMAL);

    for (int i = 0; i < argc; ++i) {
        string arg = argv[i];
        if (arg.find("/priorities:") == 0) {
            string list = arg.substr(strlen("/priorities:"));
            size_t pos = 0;
            for (int idx = 0; idx < threadCount; ++idx) {
                size_t comma = list.find(',', pos);
                string priority = (comma == string::npos) ? list.substr(pos) : list.substr(pos, comma - pos);

                if (priority == "above_normal") priorityValues[idx] = THREAD_PRIORITY_ABOVE_NORMAL;
                else if (priority == "below_normal") priorityValues[idx] = THREAD_PRIORITY_BELOW_NORMAL;
                else if (priority == "normal") priorityValues[idx] = THREAD_PRIORITY_NORMAL;
                else priorityValues[idx] = THREAD_PRIORITY_NORMAL;

                if (comma == string::npos) break;
                pos = comma + 1;
            }
            break;
        }
    }

    return priorityValues;
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

    int pixelsToProcess = 15;
    int processed = 0;

    for (int x = startX; x < endX && processed < pixelsToProcess; ++x)
    {
        for (int y = 0; y < imageHeight && processed < pixelsToProcess; ++y)
        {
            Pixel blurredPixel = GetBlurredPixel(*src, x, y);
            processed++;
            for (int i = 0; i < 1000; ++i) {}

            dst->set(x, y, blurredPixel);

            auto t = chrono::steady_clock::now();
            double ms = chrono::duration<double, milli>(t - g_start).count();

            lock_guard<mutex> lock(*data->logMutex);
            (*data->logFile) << data->threadNumber + 1 << "\t" << data->priorityValue << "\t" << ms << endl;
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

    if (!args || (argc == 2 && string(argv[1]) == "/?"))
    {
        cout << "Params format: <input file> <output file> <cores count> <threads count> [/priorities:above,normal,below]" << endl;
        return -1;
    }

    auto priorityValues = ParsePriorityValues(argc, argv, args->threadsCount);

    try
    {
        SetCoresLimit(args->coresCount);

        g_start = chrono::steady_clock::now();

        Bitmap* image = new Bitmap(args->inputFileName);
        Bitmap* dstImage = new Bitmap(image->width(), image->height());
        unsigned imageWidth = image->width();
        unsigned baseColWidth = imageWidth / args->threadsCount;
        unsigned remainder = imageWidth % args->threadsCount;

        ofstream logFile("times.txt", ios::trunc);
        mutex logMutex;

            auto threads = CreateThreads(args->threadsCount, [image, dstImage, baseColWidth, remainder, &priorityValues, &logFile, &logMutex](unsigned threadNumber) {
                unsigned startX = threadNumber * baseColWidth + min<unsigned>(threadNumber, remainder);
                unsigned thisWidth = baseColWidth + (threadNumber < remainder ? 1 : 0);

                return new ProcessBitmapInfo{
                    image, dstImage, startX, thisWidth,
                    threadNumber, priorityValues[threadNumber], &logFile, &logMutex };
                });

            for (int i = 0; i < args->threadsCount; i++) {
                SetThreadPriority(threads[i], priorityValues[i]);
                ResumeThread(threads[i]);
            }

            WaitForMultipleObjects(args->threadsCount, threads.get(), true, INFINITE);

            swap(image, dstImage);

        image->save(args->outputFileName);

        delete image;
        delete dstImage;

    }
    catch (const bmp::Exception& e)
    {
        cout << e.what() << endl;
        return -1;
    }

    return 0;
}