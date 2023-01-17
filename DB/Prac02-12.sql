--Q1
SELECT * FROM Member WHERE BranchNo = 1
--Q2
SELECT * FROM Book WHERE BookCat = 'C'
--Q3
SELECT * FROM Member WHERE BranchNo = 1 or BranchNo = 2
--Q4
SELECT * FROM Book WHERE BookCat = 'C' or BookCat = 'F'
--Q5
SELECT * FROM Member WHERE (BranchNo = 1 or BranchNo = 2) AND 'DateJoin' > '2005-12-31'
--Q6
SELECT * FROM Book WHERE (BookCat = 'C' or BookCat = 'F') AND YearPublish > 2000
--Q7
SELECT * FROM BookCopy WHERE RentalRate > 5 AND Status = 'D'
--Q8
SELECT * FROM Staff WHERE Gender = 'F' AND Salary > 1500
--Q9
SELECT * FROM Loan WHERE DateOut > '2014-12-01' AND DateOut < '2015-01-31'
--Q10
SELECT * FROM Member WHERE DateJoin BETWEEN '2014-01-01 00:00:00' AND '2014-12-31 00:00:00'
--Q11
SELECT * FROM Book WHERE BookCat IN ('C', 'F')
--Q12
SELECT * FROM Member WHERE BranchNo IN (1,2,3)
--Q13
SELECT * FROM Member WHERE Name LIKE 'TAN%'
--Q14
SELECT * FROM Book WHERE Title LIKE 'Database%'
--Q15
SELECT * FROM Book WHERE Title LIKE '%Database'
--Q16
SELECT * FROM Member WHERE Name LIKE '%Kim%'
--Q17
SELECT * FROM Book WHERE BookCat IS NULL
--Q18
SELECT * FROM Staff WHERE SupervisorID IS NULL
--Q19
SELECT * FROM Staff WHERE NOT (DOB BETWEEN '1988-01-01' AND '1990-06-30') ORDER BY DOB ASC
--Q20
SELECT * FROM Book WHERE BookCat IS NULL OR BookCat NOT IN ('C','F') ORDER BY BookCat ASC, YearPublish DESC
SELECT * FROM Book WHERE (BookCat != 'C' AND BookCat != 'F') OR BookCat IS NULL ORDER BY BookCat ASC, YearPublish DESC
--Q21
SELECT * FROM Staff WHERE SupervisorID IS NOT NULL ORDER BY SupervisorID ASC
--Q22
SELECT * FROM Member WHERE Address LIKE '%Street%' ORDER BY Name ASC
--Q23
SELECT * FROM Staff WHERE BranchNo IN (1,3) AND SupervisorID IS NULL
--Q24
SELECT Name, Address, ContactNo FROM Member WHERE EmailAddr IS NULL AND 'DateJoin' < '2014-01-01'
--Q25
SELECT * FROM BookCategory WHERE Description = 'Fiction'
--Q26
SELECT * FROM Book WHERE YearPublish NOT BETWEEN 1990 and 2000