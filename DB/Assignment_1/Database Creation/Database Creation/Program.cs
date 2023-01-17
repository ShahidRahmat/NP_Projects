using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Database_Creation
{
    class Program
    {
        static void Main(string[] args)
        {
            List<String> all_ent = new List<String>();
            List<String> entities = new List<String>();
            Console.Write("How many entities would you like to have: ");
            int ent_no = Convert.ToInt32(Console.ReadLine());
            for (int i = 0; i < ent_no; i++){
                Console.Write("Enter the entity: ");
                string ent = Console.ReadLine();
                entities.Add(ent);
            }
            using (StreamWriter sw = new StreamWriter("Data_Dict.csv", false))
            {
                sw.WriteLine("Data Dictionary");
            }
            foreach (string e in entities)
            {
                using (StreamWriter sw = new StreamWriter("Data_Dict.csv", true))
                {
                    sw.WriteLine(e);
                    sw.WriteLine("Attribute Name, Description, Data Type & Length, Null Value");
                }
                string s = null;
                List<Attributes> attributes = new List<Attributes>();
                Console.WriteLine("Entity: " + e);
                Console.WriteLine("How many attributes does this entity have: ");
                int att_no = Convert.ToInt32(Console.ReadLine());
                for (int a = 0; a < att_no; a++)
                {
                    Console.WriteLine();
                    Console.Write("Enter the attribute name: ");
                    string a_name = Console.ReadLine();
                    Console.Write("Enter the attribute description: ");
                    string a_d = Console.ReadLine();
                    Console.Write("Enter the attribute's datatype: ");
                    string a_dt = Console.ReadLine();
                    Console.Write("Enter the attribute's null value(y/n): ");
                    string a_nv = Console.ReadLine();
                    Attributes att = new Attributes(a_name, a_d, a_dt, a_nv);
                    attributes.Add(att);
                    s += att.ToString();
                }
                foreach (Attributes a_n in attributes)
                {
                    Console.WriteLine("Attributes: ");
                    Console.WriteLine(a_n.Name);
                    using (StreamWriter sw = new StreamWriter("Data_Dict.csv", true))
                    {
                        string tw = String.Format("{0},{1},{2},{3}", a_n.Name, a_n.Desc, a_n.DType, a_n.Null_v);
                        sw.WriteLine(tw);
                    }

                }
                Console.Write("Enter the entity's primary key: ");
                string e_pk = Console.ReadLine();
                string c_t = String.Format("CREATE TABLE {0} ({1} CONSTRAINT pk_{0} PRIMARY KEY({2}))",e, s, e_pk);
                all_ent.Add(c_t);
                using (StreamWriter sw = new StreamWriter("Data_Dict.csv", true))
                {
                    sw.WriteLine();
                }
            }
            string a_e = null;
            foreach(string ae in all_ent)
            {
                string aes = ae + "\n\n";
                a_e += aes;
            }
            Console.WriteLine(a_e);
        }
    }
}
