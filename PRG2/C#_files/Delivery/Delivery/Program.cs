using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Delivery
{
    class Program
    {
        static void Main(string[] args)
        {
            CreateDelivery();
        }
        public static void CreateDelivery()
        {

            Console.Write("Enter name: ");
            string name = Console.ReadLine();
            Console.Write("Enter address: ");
            string address = Console.ReadLine();
            Console.Write("Enter distance(to nearest km): ");
            int distance = Convert.ToInt32(Console.ReadLine());
            Console.Write("Enter base fee: ");
            double basefee = Convert.ToDouble(Console.ReadLine());

            InstantDelivery InstantD = new InstantDelivery(name, address, distance, basefee);
            Console.WriteLine("The cost is ${0:0.00}", InstantD.CalculateCost());

        }
    }
}
