--Q1
SELECT BranchNo, Count(MemberID) AS "Number of Members" FROM Member GROUP BY BranchNo
--Q2
SELECT ISBN, COUNT(CopyNo) AS "Number of Copies" FROM BookCopy GROUP BY ISBN ORDER BY COUNT(CopyNo) DESC
--Q3
SELECT ISBN, COUNT(CopyNo) AS "Number of Copies" FROM BookCopy GROUP BY ISBN HAVING COUNT(CopyNo) > 2 ORDER BY COUNT(CopyNo) DESC
--Q4
SELECT BookCat, PublisherID, COUNT(ISBN) AS "Number of Books" FROM Book GROUP BY BookCat, PublisherID
--Q5
SELECT BranchNo, SupervisorID, COUNT(StaffID) AS "Number of Female Staffs" FROM Staff WHERE Gender = 'F' AND SupervisorID IS NOT NULL GROUP BY BranchNo, SupervisorID
--Q6
SELECT Name, COUNT(ISBN) AS "Number of Books" FROM Publisher p INNER JOIN Book b ON p.PublisherID = b.PublisherID GROUP BY p.Name ORDER BY COUNT(ISBN) DESC
--Q7
SELECT ISBN, CopyNo, DateOut FROM Loan WHERE MemberID = (SELECT MemberID FROM Member WHERE Name = 'Kumar')
--Q8
SELECT Title, YearPublish FROM Book WHERE ISBN IN (SELECT ISBN FROM BookCopy WHERE CopyNo > 0)
--Q9
SELECT ISBN, Title FROM Book WHERE ISBN NOT IN (SELECT ISBN FROM BookCopy WHERE CopyNo > 0)
--Q10
SELECT Name, Salary FROM Staff WHERE Salary = (SELECT MAX(Salary) FROM Staff)
--Q11
SELECT MemberID, Name, Gender FROM Member WHERE MemberID IN (SELECT MemberID FROM Loan GROUP BY MemberID HAVING COUNT(MemberID) >5)
--Q12
SELECT Name FROM Staff WHERE StaffID IN (SELECT SupervisorID FROM Staff) ORDER BY Name ASC
--Q13
--Yes. You can self join the Staff Table and look for the supervisor with the highest salary. Although it is unneccessary
--Q14
SELECT BranchNo, COUNT(MemberID) AS "Number of Members" FROM Member GROUP BY BranchNo HAVING COUNT(MemberID) > 2
--Q15
SELECT BranchNo, Gender, COUNT(MemberID) AS "Number of Members" FROM Member GROUP BY BranchNo, Gender
--Q16
SELECT Name, COUNT(ISBN) AS "Number of Books" FROM Author a INNER JOIN BookAuthor ba ON a.AuthorID = ba.AuthorID GROUP BY Name ORDER BY COUNT(ISBN) DESC
--Q17
SELECT LoanNo, ISBN, DateOut FROM Loan WHERE MemberID IN (SELECT MemberID FROM Member WHERE BranchNo = 1) ORDER BY DateOut ASC
--Q18
SELECT BranchNo, SupervisorID, Gender, COUNT(StaffID) AS "Number of Staffs" FROM Staff WHERE SupervisorID IS NOT NULL GROUP BY BranchNo, SupervisorID, Gender 


