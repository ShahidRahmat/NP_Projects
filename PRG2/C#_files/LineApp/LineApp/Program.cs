using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LineApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.Write("Enter the values of a, b, c of line 1 equation ax + by = c: ");
            string values1 = Console.ReadLine();
            string[] val1 = values1.Split(',');
            Line L1 = new Line(Convert.ToInt32(val1[0]), Convert.ToInt32(val1[1]), Convert.ToInt32(val1[2]));


            Console.Write("Enter the values of a, b, c of line 2 equation ax + by = c: ");
            string values2 = Console.ReadLine();
            string[] val2 = values2.Split(',');
            Line L2 = new Line(Convert.ToInt32(val2[0]), Convert.ToInt32(val2[1]), Convert.ToInt32(val2[2]));

            double Xvalue = L1.FindIntersectionX(L2);
            double Yvalue = L1.FindIntersectionY(L2);

            Console.WriteLine("The intersection point(x, y): ({0}, {1})", Xvalue, Yvalue);

        }
    }
}
