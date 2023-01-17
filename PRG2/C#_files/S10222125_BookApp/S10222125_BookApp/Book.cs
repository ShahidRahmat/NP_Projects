using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace S10222125_BookApp
{//Id, b.Isbn, b.Title, b.Author, b.Pages, b.Qty
    class Book
    {
        public int Id { get; set; }
        public string Isbn { get; set; }
        public string Title { get; set; }
        public string Author { get; set; }
        public int Pages { get; set; }
        public int Qty { get; set; }

    }
}
