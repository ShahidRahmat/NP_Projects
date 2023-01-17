using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Delivery
{
    class StandardDelivery
    {
        public string name { get; set; }
        public string address { get; set; }
        public int distance { get; set; }

        public StandardDelivery() { }
        public StandardDelivery(string n, string a, int d)
        {
            name = n;
            address = a;
            distance = d;
        }

        public virtual double CalculateCost()
        {
            double cost = 0;
            if (distance > 10)
            {
                cost = 13;
            } else
            {
                cost = 7;
            }
            return cost;
        }

        public virtual string ToString()
        {
            return "Name: " + name + " Address: " + address + " Distance: " + distance;
        }
    }
}
