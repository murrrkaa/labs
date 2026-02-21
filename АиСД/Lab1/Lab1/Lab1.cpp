/*  25. На вход подаются строки, которые содержат информацию о
среднесуточной температуре некоторых дней года.Формат каждой
из строк следующий : сначала записана дата в виде dd.mm
(на запись номера дня и номера месяца в числовом формате отводится
    строго два символа, день от месяца отделен точкой), затем через
    пробел записано значение температуры - число со знаком плюс или
    минус, с точностью до 1 цифры после десятичной точки.Данная
    информация не отсортирована, то есть хронологический порядок
    нарушен.Требуется написать программу, которая будет выводить на
    экран информацию о месяце(месяцах), среднемесячная температура у
    которого(которых) наименее отклоняется от среднегодовой.
    В первой строке вывести среднегодовую температуру.
    Найденные значения для каждого из месяцев следует выводить в
    отдельной строке в виде : номер месяца, значение среднемесячной
    температуры, отклонение от среднегодовой температуры(8). 
    
    
    Бабина Мария ПС 21   */


#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib> 
#include <cmath>
#include <iomanip>

struct DataMonth
{
    int number_of_days;
    float temperatures;
    float average_temperature;
    float devitation;

    DataMonth() {
        number_of_days = 0;
        temperatures = 0.0;
        average_temperature = 0.0;
        devitation = 10000.0;
    }
};

int main()
{
    setlocale(LC_ALL, "ru");

    DataMonth data_months[12];

    std::string date_input, temperature_day_input;

    int all_days = 0;
    float year_temperatures = 0.0;

    std::string path;
    std::cout << "Путь к файлу: \n";
    std::cin >> path;

    std::ifstream file_input;
    file_input.open(path);

    if (file_input.is_open())
    {
        while (file_input >> date_input >> temperature_day_input)
        {

            int month = std::stoi(date_input.substr(3, 2)) - 1;
            float temparature = std::stof(temperature_day_input);

            data_months[month].temperatures += temparature;
            data_months[month].number_of_days += 1;

            all_days += 1;
            year_temperatures += temparature;
       }

        float average_year_temperature = all_days ? year_temperatures / all_days : 0.0;
        float min_devitation = 10000.0;

        for (int i = 0; i < 12; i++)
        {
            if (data_months[i].number_of_days)
            {
                data_months[i].average_temperature = data_months[i].temperatures / data_months[i].number_of_days;
                data_months[i].devitation = fabs(average_year_temperature - data_months[i].average_temperature);
            }

            if (data_months[i].devitation < min_devitation)
            {
                min_devitation = data_months[i].devitation;
            }

        }

        std::cout << std::fixed << std::setprecision(1) << "Среднегодовая температура: " << average_year_temperature << "\n";

        for (int i = 0; i < 12; i++)
        {
            int j = i;

            if (data_months[j].devitation == min_devitation)
            {
                std::cout << j + 1 << " ";
                std::cout << std::fixed << std::setprecision(1) << data_months[j].average_temperature << " ";
                std::cout << std::fixed << std::setprecision(1) << data_months[j].devitation << "\n";
            }
            
        }

    }
    else
    {
        std::cout << "Ошибка при открытии файла!\n";
    }

    file_input.close();

    return 0;
}