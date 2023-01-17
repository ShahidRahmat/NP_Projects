//============================================================
// Student Number : S10223048, S10222125
// Student Name : Jevan Teo, Shahid Rahmat
// Module Group : T11
//============================================================

using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;

namespace PRG2_P11_Team3
{
    class Program
    {
        static void LoadMovieCinema(List<Movie> m, List<Cinema> c) //1: Load Movie, Cinema Data
        {

            string[] CineData = File.ReadAllLines("Cinema.csv");
            for (int i = 1; i < CineData.Count(); i++)
            {
                string[] cine = CineData[i].Split(',');
                Cinema newCinema = new Cinema(cine[0], Convert.ToInt32(cine[1]), Convert.ToInt32(cine[2]));
                c.Add(newCinema);
            }

            string[] MovData = File.ReadAllLines("Movie.csv");
            for (int i = 1; i < MovData.Count(); i++)
            {
                string[] mov = MovData[i].Split(',');
                //DateTime datet = Convert.ToDateTime(mov[4]);
                string[] DateTime = mov[4].Split('/');
                DateTime datet = Convert.ToDateTime(DateTime[1] + "/" + DateTime[0] + "/" + DateTime[2]);
                Movie newmovie = new Movie(mov[0], Convert.ToInt32(mov[1]), mov[3], datet, new List<Screening>());
                if (mov[2].Contains("/"))
                {
                    string[] genrelist = mov[2].Split('/');
                    foreach (string g in genrelist) { newmovie.AddGenre(g); }
                }
                else { newmovie.AddGenre(mov[2]); }
                m.Add(newmovie);
            }

        }

        static void LoadScreenings(List<Screening> s, List<Movie> m, List<Cinema> c) //2: Load Screening Data
        {
            string[] sData = File.ReadAllLines("Screening.csv");
            int sNo = 1001;
            for (int i = 1; i < sData.Count(); i++)
            {
                string[] screen = sData[i].Split(',');
                //DateTime sdt = Convert.ToDateTime(screen[0]);
                string[] sDT = screen[0].Split('/'); //Remake datetime for screening
                DateTime sdt = Convert.ToDateTime(sDT[1] + "/" + sDT[0] + "/" + sDT[2]);

                Cinema cine = FindCinema(screen[2], Convert.ToInt32(screen[3]), c);
                Screening NewScreening = new Screening(sNo, sdt, screen[1], cine, FindMovie(screen[4], m));
                NewScreening.seatsRemaining = cine.capacity;
                foreach (Movie mov in m) { if (mov.title == NewScreening.Movie.title) { mov.AddScreening(NewScreening); } }
                s.Add(NewScreening);
                sNo++;
            }
        }

        static Cinema FindCinema(string Name, int number, List<Cinema> cL) //Returns matching cinema
        {
            Cinema MatchingCinema = null;
            foreach (Cinema cine in cL)
            {
                if ((cine.name == Name) && (cine.hallNo == number)) { MatchingCinema = cine; }
            }
            return MatchingCinema;
        }

        static Movie FindMovie(string Title, List<Movie> mL) //Returns matching movie
        {
            Movie Matchingmov = null;
            foreach (Movie mov in mL)
            {
                if (mov.title == Title) { Matchingmov = mov; }
            }
            return Matchingmov;
        }

        static void DisplayMovies(List<Movie> mL) //3: Display all movies
        {
            int i = 1;
            Console.WriteLine("{0,-5}{1,-25}{2,-15}{3,-15}{4,-20}{5,-20}", "S/No", "Title", "Duration", "Opening Date", "Classification", "Genres");
            foreach (Movie m in mL) { Console.WriteLine("{0,-5}{1,-25}{2,-15}{3,-15}{4,-20}{5,-20}", i, m.title, m.duration, m.openingDate.ToString("M/dd/yyyy"), m.classification, m.DisplayGenre()); i++; }
        }

        static void ListScreenings(List<Movie> mL) //4: List all screenings for a selected Movie
        {
            DisplayMovies(mL);
            int movieno = 0;
            bool valid_movieno = false;
            bool exit_option = true;
            while (!valid_movieno)
            {
                Console.Write("Select a movie: ");
                try
                {
                    movieno = Convert.ToInt32(Console.ReadLine()); if ((movieno <= mL.Count()) && (movieno >= 1)) { valid_movieno = true; }
                    else if (movieno == -1) { Console.WriteLine("Exiting to main menu..."); valid_movieno = true; exit_option = false; }
                    else { Console.WriteLine("Invalid Movie Number entered. Please try again."); }
                }
                catch (Exception ex) { Console.WriteLine(ex.Message); }
            }
            if ((valid_movieno) && (exit_option))
            {
                Movie m = FindMovie(mL[(movieno - 1)].title, mL);
                if (m.screeningList.Count != 0)
                {
                    int count = 1;
                    Console.WriteLine("{0, -10}{6,-15}{7,-30}{1, -20}{2, -20}{3, -30}{4, -20}{5, -20}", "S/No", "Cinema Name", "Hall No", "Screening Date Time", "Screening Type", "Seats Remaining", "Screening No", "Movie Title");
                    foreach (Screening s in m.screeningList)
                    {
                        Console.WriteLine("{0, -10}{6,-15}{7,-30}{1, -20}{2, -20}{3, -30}{4, -20}{5, -20}", count, s.Cinema.name, s.Cinema.hallNo, s.screeningDateTime, s.screeningType, s.seatsRemaining, s.screeningNo, s.Movie.title);
                        count++;
                    }
                }
                else { Console.WriteLine("There are no screenings for this movie."); }
            }
        }

        static void listcinemas(List<Cinema> c)
        {
            int count = 1;
            foreach(Cinema cine in c)
            {
                Console.WriteLine("{0,-8}{1, -20}{2, -20}", count, cine.name, cine.hallNo);
                count++;
            }
        }

        static void AddMovieScreeningSession(List<Movie> mL, List<Cinema> cL, List<Screening> sL)
        {
            while (true)
            {
                DisplayMovies(mL);
                try
                {
                    Console.WriteLine("Select a movie that u want to watch:");
                    int movieno = Convert.ToInt32(Console.ReadLine());  //This is the user entered number and i would convert it to int to search in the movie class
                    if (movieno == -1)
                    {
                        Console.WriteLine("Exiting to main menu..");
                        break;
                    }
                    Movie m = FindMovie(mL[(movieno - 1)].title, mL);
                    while (true)
                    {
                        List<string> allowed = new List<string>() { "2D", "3D" }; //Input validation for the screening type
                        Console.WriteLine("Enter a screening type (2D/3D):");
                        string s_type = Console.ReadLine();
                        if (s_type == "2D" || s_type == "3D")
                        {
                            while (true)
                            {
                                try // Ensures that the entered screening is a valid datetime
                                {
                                    Console.WriteLine("Enter a screening date and time (MM/dd/yyyy hh:mm tt)");
                                    DateTime dt = Convert.ToDateTime(Console.ReadLine());
                                    if (dt.TimeOfDay.TotalMinutes != 0)
                                    {
                                        if (dt >= m.openingDate)
                                        {
                                            Console.WriteLine("{2,-8}{0, -20}{1, -20}", "Cinema", "Hall Number","S/No");
                                            listcinemas(cL); // List all the cinemas
                                        }
                                        else
                                        {
                                            Console.WriteLine(m.openingDate);
                                            Console.WriteLine("dt" + dt);
                                            throw new Exception("The date u entered is before the opening date of the movie.");
                                        }
                                        
                                        while (true)
                                        {
                                            try
                                            {
                                                Console.WriteLine("Select the number for the Cinema and Hall you would like: ");
                                                int choice = Convert.ToInt32(Console.ReadLine());
                                                bool tocreate = true;
                                                if (choice <= cL.Count && choice != 0)
                                                {
                                                    foreach (Screening i in sL)
                                                    {
                                                        if (i.Cinema == cL[choice - 1])
                                                        {
                                                            if (dt <= i.screeningDateTime.AddMinutes(i.Movie.duration + 30)) //30 minutes for cleaning time
                                                            {
                                                                Console.WriteLine("Status Unsuccessful, the timing clashes with another screening.");
                                                                tocreate = false;
                                                                break;
                                                            }
                                                        }
                                                    }
                                                    if (tocreate)
                                                    {
                                                        int screeningNo = (sL.Count + 1001);
                                                        Cinema chosenC = cL[choice - 1];
                                                        Screening s = new Screening(screeningNo, dt, s_type, chosenC, m); ;
                                                        s.seatsRemaining = chosenC.capacity;

                                                        foreach (Movie mv in mL)
                                                        {
                                                            if (mv.title == s.Movie.title)
                                                            {
                                                                mv.AddScreening(s);
                                                            }
                                                        }
                                                        sL.Add(s);
                                                        Console.WriteLine("Status: Successful");
                                                        Console.WriteLine(s.ToString());
                                                        break;
                                                    }
                                                } else if (choice == 0) { Console.WriteLine("The number entered cannot be 0."); }
                                                else { Console.WriteLine("The input number is out of the accepted range."); }
                                            }
                                            catch (Exception o)
                                            {
                                                Console.WriteLine("Error:" + o.Message);
                                                continue;
                                            }
                                        }
                                        break;
                                    }
                                    else
                                    {
                                        Console.WriteLine("Please enter a time together with the date");
                                        continue;
                                    }
                                }

                                catch (Exception d)
                                {
                                    Console.WriteLine("Error:" + d.Message);
                                    continue;
                                }
                            }
                        }
                        else
                        {
                            Console.WriteLine("The input was not 2D/3D. Please enter the right input");
                            continue;
                        }
                        break;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Message:" + ex.Message);
                }
                break;
            }
        }

        static void DeleteScreening(List<Movie> mL, List<Screening> sL, List<Order> oL) //6: Delete a screening from its respective Movie
        {
            bool removed = false;
            int count = 1;
            bool valid_no = false;
            List<Screening> NoOrders = new List<Screening>();
            Console.WriteLine("{0,-8}{1, -15}{2, -30}{3, -20}{4, -20}{5, -10}{6, -20}{7, -30}", "S/No", "ScreeningNo", "Screening Date and Time", "Screening Type", "Cinema Name", "Hall No", "Cinema Capacity", "Movie Title");
            foreach (Screening s in sL)
            {
                bool soldtickets = false;
                foreach (Order o in oL)
                {
                    if (o.ticketList[0].screening == s)
                    {
                        soldtickets = true; //Checks if the screening has any tickets sold
                    }
                }

                if (!soldtickets) { Console.WriteLine("{0,-8}{1, -15}{2, -30}{3, -20}{4, -20}{5, -10}{6, -20}{7, -30}", count, s.screeningNo, s.screeningDateTime, s.screeningType, s.Cinema.name, s.Cinema.hallNo, s.Cinema.capacity, s.Movie.title); count++; NoOrders.Add(s); }
            }
            int ToRemove = 0;
            bool exit_op = true;
            while (!valid_no)
            {
                Console.Write("Enter a session to remove: ");
                try
                {
                    ToRemove = Convert.ToInt32(Console.ReadLine()); if ((ToRemove > 0) && (ToRemove <= NoOrders.Count())) { valid_no = true; }
                    else if (ToRemove == -1) { valid_no = true; exit_op = false; Console.WriteLine("Exiting to main menu.."); }
                    else if (!valid_no) { Console.WriteLine("Invalid number. Please try again."); }
                }
                catch (Exception ex) { Console.WriteLine(ex.Message); }
            }
            if ((valid_no) && (exit_op))
            {
                NoOrders[ToRemove - 1].Movie.screeningList.Remove(NoOrders[ToRemove - 1]); removed = true;
                //Removes the screening
            }
            if (removed) { sL.Remove(NoOrders[ToRemove - 1]); Console.WriteLine("The movie session has been removed."); }
        }

        static void OrderTicks(List<Movie> mL, List<Order> oL, List<Cinema> cL) //7: Order Tickets
        {
            bool createOrder = true;
            DisplayMovies(mL);
            bool movieexists = false;
            int choice = 0;
            bool exit_op = true;
            while (!movieexists)
            {
                Console.Write("Select a movie: ");
                try
                {
                    choice = Convert.ToInt32(Console.ReadLine());
                    if ((choice > 0) && (choice <= mL.Count())) { movieexists = true; }
                    else if (choice == -1) { movieexists = true; exit_op = false; Console.WriteLine("Exiting to main menu.."); }
                    //Selects the movie to order tickets for.
                }
                catch (Exception ex) { Console.WriteLine(ex.Message); }
                if (!movieexists) { Console.WriteLine("Invalid input. Please try again."); }
            }
            if ((movieexists) && (exit_op))
            {
                bool sessionexists = false;
                int screening = 0;
                int i = 1;
                int count = 1;
                Movie m = mL[choice - 1];
                bool exit_op5 = true;
                if (m.screeningList.Count > 0)
                {
                    Console.WriteLine("{0, -10}{6,-15}{7,-30}{1, -20}{2, -20}{3, -30}{4, -20}{5, -20}", "S/No", "Cinema Name", "Hall No", "Screening Time", "Screening Type", "Remaining Seats", "Screening No", "Movie title");
                    foreach (Screening s in m.screeningList) { Console.WriteLine("{0, -10}{6,-15}{7,-30}{1, -20}{2, -20}{3, -30}{4, -20}{5, -20}", count, s.Cinema.name, s.Cinema.hallNo, s.screeningDateTime, s.screeningType, s.seatsRemaining, s.screeningNo, s.Movie.title); count++; }
                }
                else { Console.WriteLine("There are no screenings for this movie. Going back to main menu.."); sessionexists = true; exit_op5 = false; }
                while (!sessionexists)
                {
                    Console.Write("Select screening: ");
                    try
                    {
                        screening = Convert.ToInt32(Console.ReadLine());
                        if ((screening > 0) && (screening <= m.screeningList.Count())) { sessionexists = true; }
                        else if (screening == -1) { sessionexists = true; exit_op5 = false; Console.WriteLine("Exiting to main menu.."); }
                        //Selects the screening for the movie
                    }
                    catch (Exception ex) { Console.WriteLine(ex.Message); }
                    if (!sessionexists) { Console.WriteLine("Invalid session number. Please try again."); }
                }
                if ((sessionexists) && (exit_op5))
                {
                    bool valid_tickno = false;
                    int tickets = 0;
                    Screening ChosenS = m.screeningList[screening - 1];
                    int capacity = ChosenS.seatsRemaining;
                    bool exit_op2 = true;
                    while (!valid_tickno)
                    {
                        Console.Write("How many tickets would you like to order: ");
                        try
                        {
                            tickets = Convert.ToInt32(Console.ReadLine());
                            if (tickets > 0 && tickets <= capacity)
                            {
                                valid_tickno = true;
                            }
                            else if (tickets == -1) { valid_tickno = true; exit_op2 = false; Console.WriteLine("Exiting to main menu.."); }
                            else if (tickets <= 0) { Console.WriteLine("Your number of tickets must be more than 0"); }
                            else
                            {
                                throw new Exception("The number of tickets entered is more than the cinema capacity.");
                            }
                        }
                        catch (Exception ex) { Console.WriteLine(ex.Message); }
                    }
                    string[] yes = { "y", "Y", "Yes", "yes" };
                    string[] n = { "n", "No", "no", "N" };
                    if ((m.classification != "G") && (exit_op2))
                    {
                        bool eligibility = false;
                        bool no = true;
                        string reply = null;
                        while (!eligibility)
                        {
                            Console.Write("This movie is {0} rated. Are all ticket holders eligible? [y/n]: ", m.classification);
                            //Checks if the customers meet the age requirement
                            try
                            {
                                reply = Console.ReadLine(); if (yes.Contains(reply)) { no = false; eligibility = true; }
                                else if (n.Contains(reply)) { eligibility = true; }
                                else if (reply == "z") { eligibility = true; no = false; createOrder = false; Console.WriteLine("Exiting to main menu.."); }
                            }
                            catch (Exception ex) { Console.WriteLine(ex.Message); };
                            if (eligibility == false) { Console.Write("Your input is not a valid option. Please enter again."); }
                        }
                        if (no)
                        {
                            createOrder = false;
                            Console.WriteLine("You have indicated that not all ticket holders are eligible. \nYour order will not be processed. Going back to main menu...");
                        }
                    }
                    if ((createOrder) && (exit_op2))
                    {
                        Order newO = new Order(oL.Count() + 1, DateTime.Now);
                        newO.amount = 0;
                        newO.status = "Unpaid";
                        string[] ticket_types = { "student", "senior citizen", "adult" };
                        string[] yes_no = { "y", "yes", "no", "n" };
                        string[] yes_array = { "y", "Y", "Yes", "yes" };
                        string[] student_Types = { "primary", "secondary", "tertiary" };
                        bool exit_op3 = true;
                        for (int j = 0; j < tickets; j++)
                        {
                            string TType = null;
                            bool ttype = true;
                            Console.Write("For ticket {0}, what type of ticket is this? [Student, Senior Citizen, Adult]: ", j + 1);
                            //Gets the type of ticket
                            try { TType = Console.ReadLine(); TType = TType.ToLower(); } catch (Exception ex) { Console.WriteLine(ex.Message); };
                            if (TType == "z") { exit_op3 = false; ttype = true; j = tickets; Console.WriteLine("Exiting to main menu.."); }
                            else if (!ticket_types.Contains(TType)) { ttype = false; }
                            if ((ttype) && (exit_op3))
                            {
                                if (TType == "student")
                                {
                                    string level = null;
                                    bool valid_level = false;
                                    while (!valid_level)
                                    {
                                        Console.Write("What Level of study are you at? [Primary, Secondary, Tertiary]: ");
                                        try { level = Console.ReadLine(); level = level.ToLower(); if (student_Types.Contains(level)) { valid_level = true; } }
                                        catch (Exception ex) { Console.WriteLine(ex.Message); Console.WriteLine("Please enter a level of study again."); };
                                    }
                                    if (valid_level)
                                    {
                                        Student stu = new Student(ChosenS, level);
                                        newO.AddTicket(stu);
                                        ChosenS.seatsRemaining--;
                                        newO.amount += getprice(ChosenS, stu);
                                    }
                                }
                                else if (TType == "adult")
                                {
                                    Console.WriteLine("Adult");
                                    string yn = null;
                                    bool y_n = false;
                                    bool popcorn = false;
                                    while (!y_n)
                                    {
                                        Console.Write("Would you like to purchase popcorn for $3? [y/n]: ");
                                        try { yn = Console.ReadLine(); yn = yn.ToLower(); if (yes_no.Contains(yn)) { y_n = true; } } catch (Exception ex) { Console.WriteLine(ex.Message); }
                                    }
                                    if (y_n)
                                    {
                                        if (yes_array.Contains(yn)) { popcorn = true; }
                                        Adult adu = new Adult(ChosenS, popcorn);
                                        newO.AddTicket(adu);
                                        newO.amount += getprice(ChosenS, adu);
                                        ChosenS.seatsRemaining--;
                                    }
                                }
                                else if (TType == "senior citizen")
                                {
                                    bool senior = false;
                                    int yob = 0;
                                    while (!senior)
                                    {
                                        Console.Write("Please enter your year of birth: ");
                                        try
                                        {
                                            yob = Convert.ToInt32(Console.ReadLine()); if ((ChosenS.screeningDateTime.Year - yob) < 55)
                                            { Console.WriteLine("This customer is not old enough to be eligible for the senior citizen ticket."); ttype = false; }
                                            //checks if the customer is old enough for the senior citizen ticket
                                            else if ((ChosenS.screeningDateTime.Year - yob) >= 55) { senior = true; }
                                        }
                                        catch (Exception ex) { Console.WriteLine(ex.Message); }
                                    }
                                    if (senior)
                                    {
                                        SeniorCitizen SC = new SeniorCitizen(ChosenS, yob);
                                        newO.AddTicket(SC);
                                        newO.amount += getprice(ChosenS, SC);
                                        ChosenS.seatsRemaining--;
                                    }
                                }
                            }
                            else if (ttype == false) { Console.WriteLine("Ineligibile ticket type. Please enter again."); j--; }

                        }
                        if (exit_op3)
                        {
                            Console.Write("Your total amount is ${0}. Please press any key to make payment", newO.amount);
                            Console.ReadLine();
                            newO.status = "Paid";
                            Console.WriteLine("Your order has been confirmed. Your order number is {0}.", newO.orderNo);
                            oL.Add(newO);
                            try
                            {
                                Console.Write("Would you like to see the details of your order? [y/n]: " +
                                    "");
                                string ans = Console.ReadLine();
                                int numberofticks = 1;
                                if (ans == "y")
                                {
                                    Console.WriteLine(newO.ToString());
                                    //Shows the details of the order
                                    foreach (Ticket t in newO.ticketList)
                                    {
                                        if (t is Adult)
                                        {
                                            Adult a = (Adult)t;
                                            Console.WriteLine("Ticket No: {0,-5}| Ticket Type: {1,-16}| Popcorn: {2,-15}", numberofticks, "Adult", a.popcornOffer);
                                        }
                                        else if (t is SeniorCitizen)
                                        {
                                            SeniorCitizen sc = (SeniorCitizen)t;
                                            Console.WriteLine("Ticket No: {0,-5}| Ticket Type: {1,-16}| Birth Year: {2,-15}", numberofticks, "Senior Citizen", sc.yearOfBirth);
                                        }
                                        else if (t is Student)
                                        {
                                            Student s = (Student)t;
                                            Console.WriteLine("Ticket No: {0,-5}| Ticket Type: {1,-16}| Level of Study: {2,-15}", numberofticks, "Student", s.levelOfStudy);
                                        }
                                        numberofticks += 1;
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine(ex.Message);
                            }
                        }
                    }

                }
            }
        }

        static double getprice(Screening s, Ticket t) //Obtain the price for a ticket based on Screening Time and Ticket Type
        {
            double amt = 0;
            int DoW = ((int)s.screeningDateTime.DayOfWeek);
            int dateint = (s.screeningDateTime - s.Movie.openingDate).Days;
            if (s.screeningType == "3D") //Checks Screening Type
            {
                if (DoW <= 4) //Checks Day of Week
                {
                    if (dateint <= 7) //Checks if its 7 days after the opening date
                    {
                        amt = 11;
                    }
                    else if (t is Student)
                    {
                        amt = 8;
                    }
                    else if (t is Adult)
                    {
                        amt = 11;
                        Adult a = (Adult)t;
                        if (a.popcornOffer == true) { amt += 3; }
                    }
                    else if (t is SeniorCitizen) { amt = 6; }
                }
                else if (DoW > 4) { amt = 14; }
            }
            else if (s.screeningType == "2D")
            {
                if (DoW <= 4)
                {
                    if (dateint <= 7) { amt = 8.5; }
                    else if (t is Student) { amt = 7; }
                    else if (t is Adult)
                    {
                        amt = 8.5;
                        Adult a = (Adult)t;
                        if (a.popcornOffer == true) { amt += 3; }
                    }
                    else if (t is SeniorCitizen) { amt = 5; }
                }
                else if (DoW > 4) { amt = 12.5; }
            }
            return amt;
        }

        static void CancelOrder(List<Order> oL, List<Screening> sL) //8: Cancel an order
        {
            bool ScreenExists = false;
            Screening screen = null;
            bool orderexists = false;
            int orderno = 0;
            bool exit_op = true;
            while (!orderexists)
            {
                Console.Write("Please enter your order number: ");
                try
                {
                    orderno = Convert.ToInt32(Console.ReadLine()); if ((orderno <= oL.Count()) && orderno != 0) { orderexists = true; }
                    if (orderno == -1) { orderexists = true; exit_op = false; Console.WriteLine("Exiting to main menu.."); }
                }
                //Gets the order number
                catch (Exception ex) { Console.WriteLine(ex.Message); }
                if (!orderexists) { Console.WriteLine("Invalid order number. Please try again."); }
            }
            if ((orderexists) && (exit_op))
            {
                Order ChosenO = oL[orderno - 1];
                foreach (Screening s in sL)
                {
                    if (ChosenO.ticketList[0].screening == s) { ScreenExists = true; screen = s; }
                }
                if (ScreenExists)
                {
                    if (screen.screeningDateTime > DateTime.Now)
                    {
                        ChosenO.status = "Cancelled";
                        Console.WriteLine("Your money has been refunded.");
                        screen.seatsRemaining += ChosenO.ticketList.Count();
                        //Restores the number of seats remaining for the screening
                        Console.WriteLine("Your cancellation is successful.");
                    }
                    else if (screen.screeningDateTime <= DateTime.Now)
                    {
                        ChosenO.status = "Paid";
                        Console.WriteLine("The screening has been shown and your money cannot be refunded.");

                    }

                }
                else { Console.WriteLine("The screening could not be located and your order has not been cancelled."); }
            }
            else if (!orderexists) { Console.WriteLine("Your order number is invalid. Please enter again."); }
        }

        static void SalesChart(List<Order> oL, List<Movie> mL) //Adv: Gives a list of movies with tickets sold in each cinema
        {
            List<string> SingaNorth = new List<string>();
            List<int> NorthTicks = new List<int>();
            List<string> SingaSouth = new List<string>();
            List<int> SouthTicks = new List<int>();
            List<string> SingaWest = new List<string>();
            List<int> WestTicks = new List<int>();
            List<string> SingaEast = new List<string>();
            List<int> EastTicks = new List<int>();
            List<string> SingaCentral = new List<string>();
            List<int> CentralTicks = new List<int>();
            bool empty = true;

            foreach (Order o in oL)
            {
                string cinemaName = o.ticketList[0].screening.Cinema.name;
                if (cinemaName == "Singa North")
                {
                    string mname = o.ticketList[0].screening.Movie.title;
                    int tickcount = o.ticketList.Count;
                    AddMovie(SingaNorth, NorthTicks, mname, tickcount);
                }
                else if (cinemaName == "Singa East")
                {
                    string mname = o.ticketList[0].screening.Movie.title;
                    int tickcount = o.ticketList.Count;
                    AddMovie(SingaEast, EastTicks, mname, tickcount);

                }
                else if (cinemaName == "Singa Central")
                {
                    string mname = o.ticketList[0].screening.Movie.title;
                    int tickcount = o.ticketList.Count;
                    AddMovie(SingaCentral, CentralTicks, mname, tickcount);
                }
                else if (cinemaName == "Singa West")
                {
                    string mname = o.ticketList[0].screening.Movie.title;
                    int tickcount = o.ticketList.Count;
                    AddMovie(SingaWest, WestTicks, mname, tickcount);
                }
                else if (cinemaName == "Singa South")
                {
                    string mname = o.ticketList[0].screening.Movie.title;
                    int tickcount = o.ticketList.Count;
                    AddMovie(SingaSouth, SouthTicks, mname, tickcount);
                }
            }
            if (SingaNorth.Count != 0) //Checks if there are any movies sold in that cinema
            {
                List<string> sortedNorth = SortMovies(SingaNorth, NorthTicks);
                Console.WriteLine("---- Singa North ----");
                empty = false;
                foreach (string m in sortedNorth) //Prints the movies if there are movies sold
                {
                    Console.WriteLine(m);
                }
            }
            if (SingaSouth.Count != 0)
            {
                List<string> sortedSouth = SortMovies(SingaSouth, SouthTicks);
                Console.WriteLine("---- Singa South ----");
                empty = false;
                foreach (string m in sortedSouth)
                {
                    Console.WriteLine(m);
                }
            }
            if (SingaEast.Count != 0)
            {
                List<string> SortedEast = SortMovies(SingaEast, EastTicks);
                Console.WriteLine("---- Singa East ----");
                empty = false;
                foreach (string m in SortedEast)
                {
                    Console.WriteLine(m);
                }
            }
            if (SingaWest.Count != 0)
            {
                List<string> sortedWest = SortMovies(SingaWest, WestTicks);
                Console.WriteLine("---- Singa West ----");
                empty = false;
                foreach (string m in sortedWest)
                {
                    Console.WriteLine(m);
                }
            }
            if (SingaCentral.Count != 0)
            {
                List<string> sortedCentral = SortMovies(SingaCentral, CentralTicks);
                Console.WriteLine("---- Singa Central ----");
                empty = false;
                foreach (string m in sortedCentral)
                {
                    Console.WriteLine(m);
                }
            }
            if (empty)
            {
                Console.WriteLine("None of the cinemas have sold any tickets. Please try again later.");
            }
        }

        static List<string> SortMovies(List<string> mNames, List<int> tickCounts) //Sorts the movie names based on the number of tickets
        {
            List<string> mNames2 = mNames;
            List<int> tickCounts2 = tickCounts;
            List<string> sortedNames = new List<string>();
            List<int> sortedTickets = new List<int>();
            int ticketindex = tickCounts2.Count;
            for (int i = 0; i < ticketindex; i++)
            {
                int maxcount = tickCounts2.Max();
                int maxindex = 0;
                for (int j = 0; j < tickCounts2.Count; j++)
                {
                    if (tickCounts2[j] == maxcount)
                    {
                        maxindex = j;
                        break;
                    }
                }
                sortedNames.Add(mNames2[maxindex]);
                sortedTickets.Add(tickCounts2[maxindex]);
                mNames2.RemoveAt(maxindex);
                tickCounts2.RemoveAt(maxindex);
            }
            return sortedNames;
        }

        static void AddMovie(List<string> CinemaMovies, List<int> ticketCount, string moviename, int ticks)
        //Adds the movie to the cinema list if it's not there. If the movie is there, the ticket count is updated.
        {
            bool addmovie = false;
            if (CinemaMovies.Count != 0)
            {
                foreach (string s in CinemaMovies)
                {
                    if (s == moviename)
                    {
                        int index = CinemaMovies.IndexOf(moviename);
                        ticketCount[index] += ticks;
                    }
                }
            }
            if (!addmovie)
            {
                CinemaMovies.Add(moviename);
                ticketCount.Add(ticks);
            }
        }

        static void DisplayOrder(List<Order> orderlist) //Adv: Shows the details of the order
        {
            if (orderlist.Count != 0)
            {
                bool orderexists = false;
                int orderno = 0;
                bool exit_op = true;
                while (!orderexists)
                {
                    Console.Write("Please enter your order number: ");
                    try
                    {
                        orderno = Convert.ToInt32(Console.ReadLine()); if ((orderno <= orderlist.Count()) && orderno != 0) { orderexists = true; }
                        if (orderno == -1) { orderexists = true; exit_op = false; Console.WriteLine("Exiting to main menu.."); }
                    }
                    //Gets the order number
                    catch (Exception ex) { Console.WriteLine(ex.Message); }
                    if (!orderexists) { Console.WriteLine("Invalid order number. Please try again."); }
                }
                if (exit_op)
                {
                    Order o = orderlist[orderno - 1];
                    Screening s = o.ticketList[0].screening;
                    Console.WriteLine("Order No: {0,-3} | Order Status: {1,-10} | Order Price: {2,-5} | No of Tickets: {4,-5} |" +
                        " Screening Time: {5,-20} | Cinema Name: {6,-15} | Hall No: {7,-5} | Movie Title: {3,-25}", o.orderNo, o.status, o.amount, s.Movie.title, o.ticketList.Count, s.screeningDateTime, s.Cinema.name, s.Cinema.hallNo);
                    try
                    {
                        Console.Write("Would you like to details of each ticket? [y/n]: ");
                        string ans = Console.ReadLine();
                        int numberofticks = 1;
                        if (ans == "y")
                        {
                            foreach (Ticket t in o.ticketList)
                            {
                                if (t is Adult)
                                {
                                    Adult a = (Adult)t;
                                    Console.WriteLine("Ticket No: {0,-5}| Ticket Type: {1,-16}| Popcorn: {2,-15}", numberofticks, "Adult", a.popcornOffer);
                                }
                                else if (t is SeniorCitizen)
                                {
                                    SeniorCitizen sc = (SeniorCitizen)t;
                                    Console.WriteLine("Ticket No: {0,-5}| Ticket Type: {1,-16}| Birth Year: {2,-15}", numberofticks, "Senior Citizen", sc.yearOfBirth);
                                }
                                else if (t is Student)
                                {
                                    Student stu = (Student)t;
                                    Console.WriteLine("Ticket No: {0,-5}| Ticket Type: {1,-16}| Level of Study: {2,-15}", numberofticks, "Student", stu.levelOfStudy);
                                }
                                numberofticks += 1;
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                    }
                }
            }
            else if (orderlist.Count == 0)
            {
                Console.WriteLine("There are no orders now.");
            }
        }

        static void sortScreenings(List<Screening> sList) //Adv 3.2: Screenings in descending order
        {
            sList.Sort();
            int count = 1;
            Console.WriteLine("{0,-3}. {1, -20}{2, -30}{3, -30}{4, -30}{5, -30}{6, -30}{7, -30}", "S/No", "Screening Number", "Screening Date Time", "Screening Type", "Remaining Seats", "Cinema Name", "Cinema Hall Number", "Cinema Capacity");
            foreach (Screening s in sList)
            {
                Console.WriteLine("{0,-4}. {1, -20}{2, -30}{3, -30}{4, -30}{5, -30}{6, -30}{7, -30}", count, s.screeningNo, s.screeningDateTime, s.screeningType, s.seatsRemaining, s.Cinema.name, s.Cinema.hallNo, s.Cinema.capacity);
                count++;
            }
        }

        static void RecommedMovies(List<Order> oL, List<Movie> mL) //3.1 Advanced. Recommend Movies based on sale of tickets
        {
            List<int> TicketCount = new List<int>();
            List<string> Movienames = new List<string>();
            foreach (Movie m in mL)
            {
                int tickets = 0;
                foreach (Order o in oL)
                {
                    if (o.ticketList[0].screening.Movie.title == m.title)
                    {
                        tickets += o.ticketList.Count;
                    }
                }
                TicketCount.Add(tickets);
                Movienames.Add(m.title); //Adds all the movie names and the number of tickets for each movie into lists
            }

            List<string> OrderedNames = new List<string>();
            List<int> OrderedTicketCount = new List<int>(); //Sorts both lists in descending order of number of tickets sold
            int ticketindex = TicketCount.Count;
            for (int i = 0; i < ticketindex; i++)
            {
                int maxcount = TicketCount.Max();
                int maxindex = 0;
                for (int j = 0; j < TicketCount.Count; j++)
                {
                    if (TicketCount[j] == maxcount)
                    {
                        maxindex = j;
                        break;
                    }
                }
                OrderedNames.Add(Movienames[maxindex]);
                OrderedTicketCount.Add(TicketCount[maxindex]);
                Movienames.RemoveAt(maxindex);
                TicketCount.RemoveAt(maxindex);
            }
            bool valid_op = false;
            string choice = "";
            bool exit_op = true;
            while (!valid_op)
            {
                Console.WriteLine("Would you like \n(a) See all the movies based off ticket sales\nor\n" +
                    "(b) See the top 3 movies based off ticket sales");
                //Choose to list all movies or top 3 in descending order of ticket sales
                try
                {
                    Console.Write("Enter your option: ");
                    choice = Console.ReadLine(); if ((choice.ToLower() == "a") || (choice.ToLower() == "b")) { valid_op = true; }
                    else if (choice.ToLower() == "z") { valid_op = true; exit_op = false; Console.WriteLine("Exiting to main menu.."); }
                }
                catch (Exception ex) { Console.WriteLine(ex.Message); }
                if (!valid_op) { Console.WriteLine("Input not accepted. Please try again."); }
            }
            if ((valid_op) && (exit_op))
            {
                Console.WriteLine();
                Console.WriteLine("{0,-25}{1,-15}", "Movie Name", "Tickets sold");
                if (choice.ToLower() == "a")
                {
                    for (int i = 0; i < OrderedTicketCount.Count; i++)
                    {
                        Console.WriteLine("{0,-25}{1,-15}", OrderedNames[i], OrderedTicketCount[i]);
                    }
                }
                else if (choice.ToLower() == "b")
                {
                    for (int i = 0; i < 3; i++)
                    {
                        Console.WriteLine("{0,-25}{1,-15}", OrderedNames[i], OrderedTicketCount[i]);
                    }
                }
            }

        }

        static void DisplayMenu() //Prints the menu and options
        {
            Console.WriteLine("------Menu------");
            Console.WriteLine("1.  Display All The Movies");
            Console.WriteLine("2.  Display Movie Screenings");
            Console.WriteLine("3.  Add Screening Session");
            Console.WriteLine("4.  Delete a Screening Session");
            Console.WriteLine("5.  Order Tickets");
            Console.WriteLine("6.  Cancel Order");
            Console.WriteLine("7.  List Screenings based on Seats Remaining");
            Console.WriteLine("8.  Recommend Movies based off ticket sales");
            Console.WriteLine("9.  Sales Chart for Movies at each Cinema");
            Console.WriteLine("10. Check Order Details");
            Console.WriteLine("0.  Exit Menu");
            Console.WriteLine("----------------");
        }

        static void RunProgram(List<Movie> mL, List<Cinema> cL, List<Screening> sL, List<Order> oL)
        {
            while (true)
            {
                try
                {
                    DisplayMenu();
                    bool valid_op = false;
                    int op = 1;
                    Console.Write("Enter an option: ");
                    try { op = Convert.ToInt32(Console.ReadLine()); if ((op >= 0) && (op <= 10)) { valid_op = true; } } catch (Exception ex) { Console.WriteLine(ex.Message); }
                    if (valid_op)
                    {
                        if (op == 0) { Console.WriteLine("You have ended the program."); break; }
                        else if (op == 1) { DisplayMovies(mL); }
                        else if (op == 2) { ListScreenings(mL); }
                        else if (op == 3) { AddMovieScreeningSession(mL, cL, sL); }
                        else if (op == 4) { DeleteScreening(mL, sL, oL); }
                        else if (op == 5) { OrderTicks(mL, oL, cL); }
                        else if (op == 6) { CancelOrder(oL, sL); }
                        else if (op == 7) { sortScreenings(sL); }
                        else if (op == 8) { RecommedMovies(oL, mL); }
                        else if (op == 9) { SalesChart(oL, mL); }
                        else if (op == 10) { DisplayOrder(oL); }
                    }
                    else { Console.WriteLine("Invalid option number. Please try again."); }
                }
                catch (Exception ex) { Console.WriteLine(ex.Message); }
            }
        }

        static void Main(string[] args)
        {
            List<Screening> sList = new List<Screening>();
            List<Cinema> cList = new List<Cinema>();
            List<Movie> mList = new List<Movie>();
            List<Order> oList = new List<Order>();
            LoadMovieCinema(mList, cList); //Loading the Movie and Cinema Data
            LoadScreenings(sList, mList, cList); //Loading the Screening Data
            RunProgram(mList, cList, sList, oList);
        }
    }
}
