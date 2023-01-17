using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LineApp
{
    class Line
    { 
        public int a { get; set; }
        public int b { get; set;}
        public int c { get; set;}

        public Line() { }
        public Line(int A, int B, int C)
        {
            a = A;
            b = B;
            c = C;
        }
        public double FindIntersectionX(Line L2)
        {
            double x = ((b * L2.c) - (L2.b * c)) / ((a * L2.b) - (L2.a * b));
            return x;
        }
        public double FindIntersectionY(Line L2)
        {
            double y = ((c * L2.a) - (L2.c * a)) / ((a * L2.b) - (L2.a * b));
            return y;
        }
        public override string ToString()
        {
            return "A: " + a + " B: " + b + " C: " + c;
        }
    }
}
