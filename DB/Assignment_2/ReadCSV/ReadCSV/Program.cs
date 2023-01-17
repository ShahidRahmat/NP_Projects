using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;

namespace ReadCSV
{
    class Program
    {
        static void ReadFile()
        {
            string[] tNames = {"Passenger", "PassengerContact","EventType","Event","Eatery", "Cuisine","Dish"
            ,"FoodCategory", "Reservation","EventSession","PassengerOrders","Ingredient","DishContains","Booking","DishCategory", "CsDish" };
            string[] allLines = File.ReadAllLines("fake.csv");
            string table_name = "";
            foreach (string line in allLines)
            {
                string[] Tables = line.Split(';');
                foreach (string t in Tables)
                {
                    int count = 0;
                    string[] values = t.Split(',');
                    bool tn = false;
                    bool print = true;
                    foreach (string i in values)
                    {
                        if (tNames.Contains(i))
                        {
                            table_name = i;
                            tn = true;
                        }
                    }
                        string statement = String.Format("INSERT INTO {0} VALUES (", table_name);
                        string statement2 = statement;
                        if (!tn)
                        {
                            foreach (string v in values)
                            {
                                if (v != "")
                                {
                                    count += 1;
                                    string toadd = String.Format("\'{0}\', ", v);
                                    if (v.Length != 8)
                                    {
                                        try
                                        {
                                            int number = Convert.ToInt32(v);
                                            toadd = String.Format("{0}, ", v);
                                        }
                                        catch (Exception ex) { };
                                    }
                                    if (v.ToLower() == "null")
                                    {
                                        toadd = String.Format("{0}, ", v);
                                    }
                                    if (v.Contains("/"))
                                    {
                                        string[] datetime = v.Split('/');
                                        string newdt = (datetime[1] + "/" + datetime[0] + "/" + datetime[2]);
                                        toadd = String.Format("'{0}', ", newdt);
                                    }
                                    statement += toadd;
                                }
                            }
                            statement += ")";
                        }

                        if ((statement.Contains("()")) || (statement == statement2)) { print = false; }
                        List<char> stringarray = new List<char>();
                        string toprint = "";
                        if (print)
                        {
                            int lastcomma = -1;
                            int c = 0;
                            foreach (char i in statement)
                            {
                                if (i == ',')
                                {
                                    lastcomma = c;
                                }
                                c += 1;
                                stringarray.Add(i);
                            }
                            stringarray.RemoveAt(lastcomma);
                            foreach (char a in stringarray)
                            {
                                toprint += a;
                            }
                            //statement = statement.TrimEnd(',');
                            //int index = statement.LastIndexOf(',');
                            //statement = statement.Remove(index);
                            Console.WriteLine(toprint);
                        }
                    
                }
            }
            foreach(string t in tNames)
            {
                Console.WriteLine("Select * from {0}", t);
            }
        }

        static void Main(string[] args)
        {

            ReadFile();
        }
    }
}
