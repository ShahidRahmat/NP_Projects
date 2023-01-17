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
    class SeniorCitizen : Ticket
    {
        public int yearOfBirth { get; set; }
        public SeniorCitizen() : base() { }

        public SeniorCitizen(Screening s, int y) : base(s)
        {
            yearOfBirth = y;
        }
        public override double CalculatePrice()
        {
            return 0;
        }
        public override string ToString()
        {
            return base.ToString() + " Year of Birth: " + yearOfBirth;
        }
    }
}
