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
    class Screening : IComparable<Screening>
    {
        public int screeningNo { get; set; }
        public DateTime screeningDateTime { get; set; }
        public string screeningType { get; set; }
        public int seatsRemaining { get; set; }
        public Cinema Cinema { get; set; }
        public Movie Movie { get; set; }

        public Screening() { }
        public Screening(int sN, DateTime sDT, string sT, Cinema c, Movie m)
        {
            screeningNo = sN;
            screeningDateTime = sDT;
            screeningType = sT;
            Cinema = c;
            Movie = m;
        } 

        public int CompareTo(Screening s)
        {
            if (seatsRemaining > s.seatsRemaining)
            {
                return -1;
            } else if (seatsRemaining == s.seatsRemaining)
            {
                return 0;
            } else { return 1; }
        }

        public string ToString()
        {
            return String.Format("Screening Number: {0,-3} | Screening Date & Time: {1,-20} | Screening Type: {2,-3} | Seats Remaining: {3,-3} |\n{4,-8} | {5}\n", screeningNo, screeningDateTime, screeningType, seatsRemaining, Cinema.ToString(), Movie.ToString());
        }
    }
}
