#include <windows.h>
#include <string>
#include <iostream>
#include <cstdlib>

DWORD WINAPI ThreadProc(CONST LPVOID lpParam)
{
	int threadNum = *(int*)lpParam;
	delete (int*)lpParam;

	std::wstring outputStr = L"Поток №" + std::to_wstring(threadNum) + L" выполняет свою работу\n";
	std::wcout << outputStr;
	ExitThread(0);
}

HANDLE* CreateThreads(int N)
{
	HANDLE* handles = new HANDLE[N];

	for (int i = 0; i < N; i++)
	{
		handles[i] = CreateThread(NULL, 0, &ThreadProc, new int(i + 1), 0, NULL);
	}

	return handles;
}

int ParseArguments(int argc, const char* argv[])
{
	if (argc < 2)
	{
		std::wcout << L"Неверное количество аргументов\n";
		return -1;
	}

	int N = std::atoi(argv[1]);
	if (N <= 0) {
		std::wcout << L"Количество потоков: " << N << "\n";
		return -1;
	}

	return N;
}

void ClosingThreads(HANDLE* handles, int N)
{
	for (int i = 0; i < N; i++)
	{
		CloseHandle(handles[i]);
	}
	delete[] handles;
}

int main(int argc, const char* argv[])
{
	setlocale(LC_ALL, "ru");
	int N = ParseArguments(argc, argv);

	if (N != -1) 
	{
		HANDLE* handles = CreateThreads(N);

		WaitForMultipleObjects(N, handles, true, INFINITE);

		ClosingThreads(handles, N);
		return 0;
	}
	else {
		return 1;
	}
}