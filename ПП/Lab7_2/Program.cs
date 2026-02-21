using System;
using System.Diagnostics;
using System.Net.Http;
using System.Threading.Tasks;

class Program
{
    static async Task Main(string[] args)
    {
        string apiUrl = "https://dog.ceo/api/breeds/image/random";
        int imageCount = 15;

        await DownloadImagesAsync(apiUrl, imageCount);
        DownloadImagesSync(apiUrl, imageCount);
    }

    static async Task DownloadImagesAsync(string url, int count)
    {
        Console.WriteLine("Download Images");
        var stopwatch = Stopwatch.StartNew();

        using HttpClient client = new HttpClient();
        Task[] tasks = new Task[count];

        for (int i = 0; i < count; i++)
        {
            tasks[i] = DownloadImageAsync(client, url, i + 1);
        }

        await Task.WhenAll(tasks);

        stopwatch.Stop();
        Console.WriteLine($"Success! Time: {stopwatch.ElapsedMilliseconds} ms");
    }

    static async Task DownloadImageAsync(HttpClient client, string url, int number)
    {
        try
        {
            Console.WriteLine($"Starting download from url: {url}");
            var response = await client.GetAsync(url);
            if (!response.IsSuccessStatusCode)
            {
                Console.WriteLine($"Ошибка при загрузке картинки {number}: {response.StatusCode}");
                return;
            }

            string json = await response.Content.ReadAsStringAsync();
            Console.WriteLine($"Image from {url} download successfully!");
        }
        catch (Exception error)
        {
            Console.WriteLine($"Ошибка при загрузке картинки {number}: {error.Message}");
        }
    }

    static void DownloadImagesSync(string url, int count)
    {
        Console.WriteLine("Download Images");
        var stopwatch = Stopwatch.StartNew();

        using HttpClient client = new HttpClient();

        for (int i = 0; i < count; i++)
        {
            try
            {
                Console.WriteLine($"Starting download from url: {url}");
                var response = client.GetAsync(url).Result;
                if (!response.IsSuccessStatusCode)
                {
                    Console.WriteLine($"Ошибка при загрузке картинки {i + 1}: {response.StatusCode}");
                    continue;
                }

                string json = response.Content.ReadAsStringAsync().Result;
                Console.WriteLine($"Image from {url} download successfully!");
            }
            catch (Exception error)
            {
                Console.WriteLine($"Ошибка при загрузке картинки {i + 1}: {error.Message}");
            }
        }
        stopwatch.Stop();
        Console.WriteLine($"Success! Time: {stopwatch.ElapsedMilliseconds} ms");
    }
}