--Q1
SELECT bc.ISBN, bc.CopyNo, Title, bc.RentalRate FROM BookCopy bc INNER JOIN Book b ON bc.ISBN = b.ISBN

--Q2
SELECT ISBN, Title, Description as 'Category' FROM Book INNER JOIN BookCategory ON Book.BookCat = BookCategory.BookCat ORDER BY Title ASC

--Q3
SELECT b.BranchNo, Address, Name AS 'Manager''s Name' FROM Branch b INNER JOIN Staff s ON b.MgrID = s.StaffID

--Q4
SELECT s.StaffID, s.Name, s.DateJoin FROM Staff s INNER JOIN Staff sup ON s.SupervisorID = sup.StaffID WHERE sup.Name = 'May May'

--Q5
SELECT b.ISBN, Title, DateOut FROM Loan l INNER JOIN Member m ON m.MemberID = l.MemberID INNER JOIN Book b ON l.ISBN = b.ISBN WHERE m.Name = 'Kumar' ORDER BY DateOut ASC

--Q6
SELECT b.ISBN, Title, Name AS 'Author' FROM Book b INNER JOIN BookAuthor ba ON b.ISBN = ba.ISBN INNER JOIN Author a ON ba.AuthorID = a.AuthorID ORDER BY Title ASC

--Q7
SELECT COUNT(LoanNo) AS 'Number Of Loans', SUM(RentalRate) AS "Total Rental Rate" FROM Loan l INNER JOIN Member m ON l.MemberID = m.MemberID WHERE Name = 'Jeremy Law'

--Q8
SELECT DISTINCT(s.Name) FROM Staff s INNER JOIN Staff sup ON s.StaffID = sup.SupervisorID ORDER BY Name ASC

--Q9
SELECT ISBN, Title, YearPublish FROM Book b INNER JOIN Publisher p ON b.PublisherID = p.PublisherID INNER JOIN BookCategory bc ON b.BookCat = bc.BookCat WHERE Description = 'Fiction' and Name = 'Arrow Books' ORDER BY YearPublish ASC

--Q10
SELECT s.StaffID, s.Name, s.DateJoin, DATEDIFF(year, s.DateJoin, GETDATE()) AS 'Years In Service' FROM Staff s INNER JOIN Staff sup ON s.SupervisorID = sup.StaffID WHERE sup.Name = 'May May' AND DATEDIFF(year, s.DateJoin, GETDATE()) < 10

--Q11
SELECT LoanNo, ISBN, Name, DateOut, RentalRate FROM Loan l INNER JOIN Member m ON l.MemberID = m.MemberID

--Q12
SELECT l.ISBN, CopyNo, DateOut FROM Loan l INNER JOIN Book b ON l.ISBN = b.ISBN WHERE Title = 'Stuart Little'

--Q13
SELECT ISBN, Title, YearPublish FROM Book b INNER JOIN Publisher p ON b.PublisherID = p.PublisherID WHERE Name = 'Pan Books'

--Q14
SELECT m.MemberID, Name, DateDue, DateReturn FROM Loan l INNER JOIN Member m ON l.MemberID = m.MemberID WHERE (DATEDIFF(day, DateDue, DateReturn) > 0) ORDER BY DateReturn DESC
