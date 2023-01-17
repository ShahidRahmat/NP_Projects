using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace S10222125_ShippingApp
{
    class Customer
    {
        public string name { get; set; }
        public string tel { get; set; }
        public ShippingAddr addr { get; set; }

        public Customer() { }
        public Customer(string n, string t, ShippingAddr a)
        {
            name = n;
            tel = t;
            addr = a;
        }

        public string ToString()
        {
            return "Name: " + name + " Tel: " + tel + addr.ToString();
        }
    }
}
