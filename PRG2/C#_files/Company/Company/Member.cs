using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Company
{
    class Member : Customer
    {
        public int membershipNo { get; set; }
        public int points { get; set; }

        public Member() :base() { }
        public Member(int i, string n, int a, int m, int p):base(i,n,a)
        {
            membershipNo = m;
            points = p;
        }

        public bool RedeemPoints(int p)
        {
            bool result = false;
            if (points >= p)
            {
                points -= p;
                result = true;
            }
            return result;
        }

        public override double ApplyDiscount(double purchase)
        {
            return (applicableDiscount + 5) * purchase;
        }

        public override string ToString()
        {
            return base.ToString() + " Membership No: " + membershipNo + " Points: " + points;
        }
    }
}
