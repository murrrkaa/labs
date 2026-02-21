/*
8. Выборы  старосты  в  группе  студентов  из   M   человек
организованы  по следующим правилам.Задаются целые числа N и
K.Студенты становятся по  кругу  в  соответствии  со  своими
номерами в журнале.Начиная от N - го студента отсчитывается K - й
студент.Счет ведется циклически по возрастанию номеров.Этот
студент   выбывает  из  претендентов.Начиная  со  следующего
студента, процедура повторяется.Последний оставшийся студент
становится старостой.Ввести значения M, N, K и найти номер
старосты(7).

Бабина Мария ПС 21
*/


#include <iostream>
#include <fstream>

struct Node 
{
	int value;
	Node* next;

	Node(int newValue) : value{ newValue }, next{ nullptr } {};
};

Node* creatingQueue(int numberOfStudents) 
{
	Node* head = nullptr;
	Node* end = nullptr;

	for (int i = 1; i <= numberOfStudents; i++) 
	{
		Node* newNode = new Node(i);

		if (!head) 
		{
			head = newNode;
			end = newNode;
			end->next = head;
		}
		else 
		{
			end->next = newNode;
			end = newNode;
			end->next = head;
		}
	}

	if (head) 
	{
		end->next = head;
	}

	return head;

}

Node* findEndOfQueue(Node* head)
{

	if (!head) return nullptr;

	Node* end = head;

	while (end->next != head)
	{
		end = end->next;
	}

	return end;
}

int findNumberOfLeader(Node* head, Node* end,int N, int K)
{

	Node* current = head;
	Node* leader = current;
	Node* prev = nullptr;

	if (N == 1)
	{
		prev = end;
	}
	else
	{
		for (int i = 1; i < N; i++)
		{
			prev = current;
			current = prev->next;
		}
	}


	while (current->next != current) 
	{

		for (int i = 1; i < K; i++)
		{
			prev = current;
			current = prev->next;
		}

		Node* temp = current;
		prev->next = temp->next;
		current = temp->next;

		delete temp;
	}

	return current->value;
}

int main()
{

	setlocale(LC_ALL, "ru");

	while (true)
	{
		int M, N, K;
		std::cout << "Введите значения:\n M - количество студентов \n N - начало отсчета студента\n K - шаг выбывания студента" << "\n";
		std::cin >> M >> N >> K;

		if (M < 1 || N < 1 || N > M || K < 1)
		{
			std::cout << "Неверные входные данные!" << "\n";
			return 1;
		}

		Node* head = creatingQueue(M);
		Node* end = findEndOfQueue(head);

		int leader = findNumberOfLeader(head, end, N, K);

		std::cout << "Староста группы под номером: " << leader << std::endl;


		std::string choice;
		std::cout << "Хотите продолжить? (yes/no)" << "\n";
		std::cin >> choice;

		if (choice != "yes")
		{
			break;
		}

	}

	return 0;
}


