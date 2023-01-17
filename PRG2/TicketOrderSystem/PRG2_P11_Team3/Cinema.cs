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
    class Cinema
    {
        public string name { get; set; }
        public int hallNo { get; set; }
        public int capacity { get; set; }
        public Cinema() { }

        public Cinema(string n, int h, int c)
        {
            name = n;
            hallNo = h;
            capacity = c;
        }
        public string ToString()
        {
            return String.Format("Cinema Name: {0,-15} | Hall No: {1,-3} | Capacity: {2,-3}", name, hallNo, capacity);
        }
    }
}
