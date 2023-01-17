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
    class Student : Ticket
    {
        public string levelOfStudy { get; set; }
        public Student():base(){ }
        public Student(Screening s, string l) : base(s)
        {
            levelOfStudy = l;
        }

        public override double CalculatePrice()
        {
            return 0;
        }
        public override string ToString()
        {
            return base.ToString() + " Level of Study: " + levelOfStudy;
        }
    }
}
