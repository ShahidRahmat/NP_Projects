using System;
using System.Collections.Generic;
using System.Net.Http;
using Newtonsoft.Json;
using System.Threading.Tasks;

namespace CarParkAvailabilityApp
{
    class Program
    {
        static void Main(string[] args)
        {
            using (HttpClient client = new HttpClient())
            {
                // 1. Send http request 
                client.BaseAddress = new Uri("https://api.data.gov.sg");
                Task<HttpResponseMessage> responseTask = client.GetAsync("/v1/transport/carpark-availability");

                // 2. Wait for http response 
                responseTask.Wait();
                HttpResponseMessage result = responseTask.Result;
                if (result.IsSuccessStatusCode)
                {
                    // 3. Retrieve data (content) 
                    Task<string> readTask = result.Content.ReadAsStringAsync();
                    readTask.Wait();
                    string data = readTask.Result;

                    // 4. Convert data string to object 
                    Rootobject cpa = JsonConvert.DeserializeObject<Rootobject>(data);

                    foreach (Item item in cpa.items)
                    {
                        Carpark_Data[] carparkList = item.carpark_data;     // List<Carpark_Data> carparkList = item.carpark_data; 
                        foreach (Carpark_Data c in carparkList)
                        {
                            Console.WriteLine("Carpark Number: " + c.carpark_number);
                            Carpark_Info[] carparkInfoList = c.carpark_info;  // List<Carpark_Info> carparkInfoList = c.carpark_info; 
                            foreach (Carpark_Info info in carparkInfoList)
                            {
                                Console.WriteLine("Total Lots: " + info.total_lots);
                                Console.WriteLine("Lots Available: " + info.lots_available);
                                Console.WriteLine("==========================");
                            }
                        }
                    }
                }
            }
        }
    }
}
