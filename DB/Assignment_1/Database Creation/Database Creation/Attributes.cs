using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Database_Creation
{
    class Attributes
    {
        public string Name { get; set; }
        public string Desc { get; set; }
        public string DType { get; set; }
        public string Null_v { get; set; }

        public Attributes() { }
        public Attributes(string n, string d, string dt, string nv)
        {
            Name = n;
            Desc = d;
            DType = dt;
            Null_v = nv;
        }
        public string ToString()
        {
            string s = null;
            string n;
            if (Null_v == "n")
            {
                n = "NOT";
                s = String.Format("{0} {1} NOT null,", Name, DType);
            } else if (Null_v == "y")
            {
                s = String.Format("{0} {1} null,", Name, DType);
            }
            return s;
        }

    }
}
