--Q1
SELECT GETDATE()
SELECT DATEPART(month, GETDATE())
SELECT DATENAME(month, GETDATE())
SELECT DATEPART(year, GETDATE())
SELECT DATEPART(day, GETDATE())
--Q2
SELECT MemberID, Name, DateJoin, DATEDIFF(year, DateJoin, GETDATE()) AS 'Years of Membership' FROM Member ORDER BY 'Years of Membership' ASC
--Q3
SELECT LoanNo, ISBN, CopyNo, MemberID, DATEDIFF(day, DateDue, DateReturn) AS 'Number of Days Overdue' FROM Loan ORDER BY DATEDIFF(day, DateDue, DateReturn) DESC
--Q4
SELECT StaffID, Name, Gender, DOB FROM Staff WHERE DATEPART(month, DOB) = 02 ORDER BY Name ASC
--Q5
SELECT COUNT(STAFFID) AS 'Number of Staff' FROM Staff 
--Q6
SELECT COUNT(SupervisorID) FROM Staff
--Q7
SELECT COUNT(DISTINCT SupervisorID) AS 'Number of Supervisors' FROM Staff
--Q8
SELECT COUNT(MemberID) AS 'Members With Email Addresses' FROM Member WHERE EmailAddr IS NOT NULL
--Q9
SELECT COUNT(MemberID) AS 'Members without Email Addresses' FROM Member WHERE EmailAddr IS NULL
--Q10
SELECT MIN(RentalRate) FROM Loan
--Q11
SELECT COUNT(LoanNo) AS 'Number of Loan', SUM(RentalRate) AS 'Total Rental Income' FROM Loan WHERE DATEPART(year, DateOut) = 2014
--Q12
SELECT COUNT(StaffID) AS 'Number of Staff', SUM(Salary)*12 AS 'Total Annual Salary Payout' FROM Staff
--Q13
SELECT LoanNo, DateDue AS 'Old DateDue', DATEADD(day, 10, DateDue) AS 'New DateDue' FROM Loan ORDER BY 'New DateDue' ASC
--Q14
SELECT Name, ISNULL(EmailAddr, 'Email Address Not Available') AS 'Email Address' FROM Member ORDER BY Name ASC
--Q15
SELECT Name, Address, ContactNo FROM Member WHERE ((DATEPART(year, DateJoin) < 2014)) AND (EmailAddr IS NULL)
--Q16
SELECT MemberID, Name, DateJoin FROM Member WHERE DATEDIFF(year, DateJoin, GETDATE()) > 1 ORDER BY DateJoin ASC
--Q17
SELECT ISBN, CopyNo, Status, DateIn, DATEDIFF(year, DateIn, GETDATE()) AS 'Number of Years' FROM BookCopy WHERE DATEDIFF(year, DateIn, GETDATE()) > 3 ORDER BY DateIn ASC
--Q18
SELECT MemberID, Name, DateJoin FROM Member WHERE DATEPART(year, DateJoin) = 2014 ORDER BY DateJoin ASC
--Q19
SELECT MAX(RentalRate) FROM BookCopy
--Q20
SELECT AVG(RentalRate) FROM BookCopy
--Q21
SELECT COUNT(LoanNo) AS 'Number of Loan', SUM(RentalRate) AS 'Total Rental Income' FROM Loan
--Q22
SELECT COUNT(StaffID) AS 'Number of Staff', SUM(Salary) AS 'Total Salary Payout' FROM Staff
--Q23
SELECT UPPER(Name) FROM Member ORDER BY Name ASC
--Q24
SELECT SUBSTRING(ISBN,1,5) AS 'ISBN', Title FROM Book ORDER BY ISBN ASC, Title ASC
--Q25
SELECT ISBN, REPLACE(Title, 'database', 'DB') AS Title FROM Book ORDER BY Title ASC
--Q26
SELECT ISBN, CopyNo, FLOOR(RentalRate) AS 'RentalRate' FROM BookCopy ORDER BY RentalRate DESC
--Q27
SELECT StaffID, Name, round(Salary, -2) AS 'Salary' FROM Staff ORDER BY Salary DESC
--Q28
SELECT COUNT(StaffID) AS 'Total Number Of Staff', AVG(SALARY)*12 AS 'Average Annual Salary Payout' FROM Staff
