using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Delivery
{
    class InstantDelivery :StandardDelivery
    {
        public double baseFee { get; set; }

        public InstantDelivery() : base() { }
        public InstantDelivery(string n, string a, int d, double b) : base (n, a, d)
        {
            baseFee = b;
        }
        public override double CalculateCost()
        {
            Double cost = 0.00;



            if(distance > 5) {
                cost = baseFee + (5 * 1) + ((distance - 5) * 0.70);
            } else if (distance <= 5)
            {
                cost = baseFee + (distance * 1);
            }
            return cost;
        }

        public override string ToString()
        {
            return base.ToString() + "Base Fee: " +baseFee;
        }

    }
}
