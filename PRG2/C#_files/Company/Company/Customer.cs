using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Company
{
    class Customer
    {
        public int custId { get; set; }
        public string name { get; set; }
        public int applicableDiscount { get; set; }

        public Customer() { }
        public Customer(int i, string n, int a)
        {
            custId = i;
            name = n;
            applicableDiscount = a;
        }
        
        public virtual double ApplyDiscount(double purchaseAmt)
        {
            return applicableDiscount* purchaseAmt;
        }

        public virtual string ToString()
        {
            return "Cust ID: " + custId + " Name: " + name + " Applicable Disc: " + applicableDiscount;
        }
    }
}
