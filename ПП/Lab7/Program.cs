using System;
using System.IO;
using System.Threading.Tasks;

class Program
{
    static async Task Main(string[] args)
    {
        Console.Write("Введите путь к файлу: ");
        var path = Console.ReadLine();

        if (!File.Exists(path))
        {
            Console.WriteLine("Файл не найден");
            return;
        }

        Console.Write("Введите символы, которые нужно удалить: ");
        var charsToRemove = Console.ReadLine();

        string text = await File.ReadAllTextAsync(path);

        foreach (var ch in charsToRemove)
        {
            text = text.Replace(ch.ToString(), "");
        }

        await File.WriteAllTextAsync(path, text);

        Console.WriteLine("Файл обновлён");
    }
}