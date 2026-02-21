#include <windows.h>
#include <mmsystem.h>
#include <string>
#include <iostream>
#include <fstream>
#pragma comment(lib, "winmm.lib")

int operations = 0;
int threads = 0;
int priorityThread = 1;

DWORD WINAPI ThreadProc(CONST LPVOID lpParam)
{
    int threadNum = *(int*)lpParam;
    delete (int*)lpParam;

    std::wstring fileName = L"thread_" + std::to_wstring(threadNum) + L".txt";
    std::ofstream outputFile(fileName);
    if (!outputFile.is_open()) {
        std::wcerr << L"Ошибка: не удалось открыть файл " << fileName << L" для записи!\n";
        ExitThread(1);
    }

    for (int i = 0; i < operations; ++i)
    {
        for (int j = 0; j < 100000000; ++j) {};
        DWORD currentTime = timeGetTime();
        outputFile << threadNum << "|" << currentTime << "\n";
    }

    outputFile.close();
    ExitThread(0);
}

HANDLE* CreateThreads(int N)
{
    HANDLE* handles = new HANDLE[N];
    for (int i = 0; i < N; i++)
    {
        handles[i] = CreateThread(NULL, 0, &ThreadProc, new int(i + 1), CREATE_SUSPENDED, NULL);

        if (i + 1 == priorityThread) {
            SetThreadPriority(handles[i], THREAD_PRIORITY_HIGHEST);
        }
        else {
            SetThreadPriority(handles[i], THREAD_PRIORITY_NORMAL);
        }
    }

    for (int i = 0; i < N; i++) {
        ResumeThread(handles[i]);
    }
    
    return handles;
}

void ClosingThreads(HANDLE* handles, int N)
{
    for (int i = 0; i < N; i++)
    {
        CloseHandle(handles[i]);
    }
    delete[] handles;
}

int ParseArguments(int argc, const char* argv[])
{
    if (argc < 2)
    {
        std::wcout << L"Неверное количество аргументов\n";
        return -1;
    }

    threads = std::atoi(argv[1]);
    operations = std::atoi(argv[2]);

    if (threads <= 0 || operations <= 0) {
        std::wcout << L"Неверные данные:" << "\n";
        return -1;
    }

    return 1;
}

int main(int argc, const char* argv[])
{
    setlocale(LC_ALL, "ru");

    if (ParseArguments(argc, argv) == -1) {
        std::wcout << L"Неверно введенные данные!";
        return 1;
    }

    std::wstring pause;
    std::getline(std::wcin, pause);

    HANDLE* handles = CreateThreads(threads);

    WaitForMultipleObjects(threads, handles, TRUE, INFINITE);

    ClosingThreads(handles, threads);

    return 0;
}