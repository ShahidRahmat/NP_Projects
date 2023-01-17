using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace S10222125_ShippingApp
{
    class Program
    {

        static void InitCustomerList(List<Customer> clist) //b
        {
            clist.Add(new Customer("John Tan", "98501111", new ShippingAddr("Singapore", "Clementi Rd")));
            clist.Add(new Customer("Amy Lim", "99991111", new ShippingAddr("Hong Kong", "Mong Kok Rd")));
            clist.Add(new Customer("Tony Tay", "91112222", new ShippingAddr("Malaysia", "Malacca Rd")));
        }

        static void ListCustomer(List<Customer> CList) //d
        {
            Console.WriteLine("{0, -15}{1, -15}{2,-15}{3,-20}", "Name", "Tel", "Country", "Street");
            foreach (Customer c in CList)
            {
                Console.WriteLine("{0, -15}{1, -15}{2,-15}{3,-20}", c.name, c.tel, c.addr.country, c.addr.street);
            }
        }

        static void Main(string[] args)
        {
            List<Customer> customerlist = new List<Customer>(); //a
            InitCustomerList(customerlist); //c
            ListCustomer(customerlist); //e
        }
    }
}
