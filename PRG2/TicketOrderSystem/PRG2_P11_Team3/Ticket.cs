//============================================================
// Student Number : S10223048, S10222125
// Student Name : Jevan Teo, Shahid Rahmat
// Module Group : T11
//============================================================

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PRG2_P11_Team3
{
    abstract class Ticket
    {
        public Screening screening { get; set; }
        public Ticket() { }
        public Ticket(Screening s)
        {
            screening = s;
        }
        public abstract double CalculatePrice();
        public override string ToString()
        {
            return String.Format("| Screening: {0,-5}", screening.ToString());
        }
    }
}
