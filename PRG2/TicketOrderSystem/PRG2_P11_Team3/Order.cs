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
    class Order
    {
        public int orderNo { get; set; }
        public DateTime orderDateTime { get; set; }
        public double amount { get; set; }
        public string status { get; set; }
        public List<Ticket> ticketList = new List<Ticket>();
        public Order() { }
        public Order(int o, DateTime oDT)
        {
            orderNo = o;
            orderDateTime = oDT;
        }
        public void AddTicket(Ticket t)
        {
            ticketList.Add(t);
        }
        public string ToString()
        {
            return "Order No: " + orderNo + " | Time of Order: " + orderDateTime + " | Amount: " + amount + " | Status: " + status;
        }
    }
}
