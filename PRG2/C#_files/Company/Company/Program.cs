using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Company
{
    class Program
    {
        static void Main(string[] args)
        {
        }

        public static void ApplyDiscountToCustomers(List<Customer> customerList, int purchaseAmount)
        {
            Console.WriteLine("Entitled Discount per ${0}", purchaseAmount);
            Console.WriteLine("{0, -10} {1, -15} {2, -18}", "Cust Id", "Cust Name", "Discount amt($)");

            foreach (Customer c in customerList)
            {
                Console.WriteLine("{0, -10}{ 1, -15}{2, -18:0.00}", c.custId, c.name, c.ApplyDiscount(purchaseAmount));

            }
        }

        public static void RedeemMemberFee(List<Customer> customerList)
        {
            int count = 0;
            List<Member> memberList = new List<Member>();

            foreach(Customer c in customerList){
                if(c is Member){
                    Member m = (Member)c;
                    if(m.points < 100){
                        memberList.Add(m);
                        count++;
                    } else
                    {
                        m.points -= 100;
                    }
                }
            }

            if(count > 0){
                Console.WriteLine("{0, -10}{1, -15}{2, -10}", "Cust Id", "Cust Name", "Points");
                foreach(Member m in memberList){
                    Console.WriteLine("{0, -10}{1, -15} {2, -10}", m.custId, m.name, m.points);
                }
            } else if (count == 0)
            {
                Console.WriteLine("There is no member with unsuccessful deduction of membership fee.");
            }

        }
    }
}
