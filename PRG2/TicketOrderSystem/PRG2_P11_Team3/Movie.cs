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
    class Movie
    {
        public string title { get; set; }
        public int duration { get; set; }
        public string classification { get; set; }
        public DateTime openingDate { get; set; }

        public List<Screening> screeningList = new List<Screening>();

        public List<string> genreList = new List<string>();
        public Movie() { }
        public Movie(string t, int d, string c, DateTime o, List<Screening> s)
        {
            title = t;
            duration = d;
            classification = c;
            openingDate = o;
            screeningList = s;
        }

        public void AddScreening(Screening s)
        {
            screeningList.Add(s);
        }


        public void AddGenre(string g)
        {
            genreList.Add(g);
        }

        public string DisplayGenre()
        {
            string genres = "";
            if (genreList.Count() > 1)
            {
                foreach (string g in genreList)
                {
                    if (genres.Length == 0)
                    {
                        genres += g;
                    } else { genres += (", " + g); }
                }
            } else if (genreList.Count() == 1)
            {
                genres = genreList[0];
            }
            return genres;
        }

        public string ToString()
        {
            return String.Format("Title: {0,-25} | Duration: {1, -5} | Genres: {4,-10} | Classification: {2,-10} | Opening Date: {3,-8}", title, duration, classification, openingDate.ToString("dd/MM/yyyy"), DisplayGenre());
        }
    }
}
