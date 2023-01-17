--Q1
SELECT * FROM Staff
--Q2
SELECT * FROM Book
--Q3
SELECT StaffID, Name, Gender FROM Staff
--Q4
SELECT ISBN, Title, PublisherID, BookCat FROM Book
--Q5
SELECT SupervisorID FROM Staff
--Q6
SELECT DISTINCT SupervisorID FROM Staff
--Q7
SELECT BranchNo FROM Member
--Q8
SELECT DISTINCT BranchNo FROM Member
--Q9
SELECT ISBN, CopyNo, RentalRate, RentalRate*0.98 AS "New RentalRate" FROM BookCopy
--Q10
SELECT StaffID, Name, Salary, Salary*1.1 AS "New Salary" FROM Staff
--Q11
SELECT * FROM Staff ORDER BY Name ASC
--Q12
SELECT * FROM Staff ORDER BY Name DESC
--Q13
SELECT StaffID, ContactNo FROM StaffContact ORDER BY StaffID ASC
--Q14
SELECT Name, Salary FROM Staff ORDER BY Salary DESC
--Q15
SELECT * FROM BookCopy ORDER BY DateIn DESC
--Q16
SELECT BranchNo, Name, Salary FROM Staff ORDER BY BranchNo ASC, Name ASC