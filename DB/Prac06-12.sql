--Q3
/*
CREATE DATABASE NewNP40Book
*/

--Q4
/*
CREATE TABLE BookCategory 
(BookCat char(2) NOT NULL,
Description varchar(100) NOT NULL,
Constraint pk_BookCat PRIMARY KEY (BookCat))
*/

--Q5
/*
CREATE TABLE Publisher
(PublisherID smallint NOT NULL,
Name varchar(50) NOT NULL,
Constraint pk_Publisher PRIMARY KEY (PublisherID))
*/

--Q6
/*
CREATE TABLE Book 
(ISBN char(10) NOT NULL,
Title varchar(200) NOT NULL,
YearPublish Char(4) NOT NULL,
PublisherID smallint NULL,
BookCat char(2) NULL,
CONSTRAINT pk_Book PRIMARY KEY (ISBN),
CONSTRAINT fk_BookCat FOREIGN KEY (BookCat) REFERENCES BookCategory(BookCat),
CONSTRAINT fk_publisherID FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID))
*/

--Q7i
/*
INSERT INTO BookCategory (BookCat, Description)
	SELECT BookCat, Description
	FROM NP40Book.dbo.BookCategory
*/

--Q7ii
/*
INSERT INTO Publisher (PublisherID, Name)
	SELECT PublisherID, Name
	FROM NP40Book.dbo.Publisher
*/

--Q7iii
/*
INSERT INTO Book(ISBN, Title, YearPublish, PublisherID, BookCat)
	SELECT ISBN, Title, YearPublish, PublisherID, BookCat
	FROM NP40Book.dbo.Book
*/

--Q8
/*
INSERT INTO Book (ISBN, Title, YearPublish, PublisherID, BookCat)
VALUES ('0385605196', 'Not the end of the world', 2002, 4, 'F');
INSERT INTO Book (ISBN, Title, YearPublish, PublisherID, BookCat)
VALUES ('0385605196', 'The Devil wears Prada', 2003, 4, 'F');

The Second book record could not be insert as there is already an existing book with the same ISBN.
*/

--Q9
/*
INSERT INTO Publisher (PublisherID, Name)
VALUES (9, 'Pearson Prentice Hall');
INSERT INTO Book (ISBN, Title, YearPublish, PublisherID, BookCat)
VALUES( '981244579X', 'Database', 2003, 9, 'NF');

The data should be inserted into the Publisher Table first as the Book Table references the PublisherID column to the Publisher Table.
*/

--Q10
/*
UPDATE Publisher
SET Name = 'Happy Day'
WHERE Name LIKE 'Doubleday'
*/

--Q11
/*
UPDATE BookCategory
SET Description = 'Comedy'
WHERE BookCat LIKE 'C'
*/

--Q12
/*
UPDATE Book
SET PublisherID = (
	SELECT PublisherID FROM Publisher
	WHERE Name = 'Addison Wesley')
, BookCat = 'NF'
WHERE Title = 'Database Systems'
*/

--Q13
/*
UPDATE Book
SET PublisherID = (
	SELECT PublisherID From Publisher
	WHERE Name = 'Heinz')
WHERE Title = 'The Best of Catherine Lim'
*/

--Q14
/*
DELETE Book
WHERE ISBN = '0072126949'
INSERT INTO Publisher (PublisherID, Name)
VALUES (9, 'Pearson Prentice Hall');
INSERT INTO Book (ISBN, Title, YearPublish, PublisherID, BookCat)
VALUES( '981244579X', 'Database', 2003, 9, 'NF');
*/

--Q15
/*
DELETE Book WHERE PublisherID = 9;
DELETE Publisher WHERE PublisherID = 9;

The Data should be removed from Book first as the book Publisherid references from Publisher
*/

--Q16
/*
CREATE TABLE Member
(MemberID smallint NOT NULL,
Name varchar(50) NOT NULL,
Address varchar(150) NULL,
ContactNo char(10) Null,
EmailAddr varchar(50) NULL,
Gender char(1) NULL CHECK (Gender in ('M','F')),
DateJoin smalldatetime NOT NULL CHECK (DateJoin < GETDATE()),
BranchNo tinyint NOT NULL,
CONSTRAINT pk_Member PRIMARY KEY (MemberID))
*/

--Q17
/*
INSERT INTO Member
SELECT MemberID, Name, Address, ContactNo, EmailAddr, Gender, DateJoin, BranchNo
FROM NP40Book.dbo.Member
*/

--Q18
/*
CREATE TABLE Reservation 
(MemberID Int NOT NULL,
ISBN char(10) NOT NULL,
ResDate Datetime NOT NULL DEFAULT (GETDATE()),
EndDate Datetime NOT NULL,
CONSTRAINT pk_Reservation PRIMARY KEY (MemberID, ISBN, ResDate),
CONSTRAINT fk_Reservation FOREIGN KEY (ISBN) REFERENCES Book(ISBN),
CONSTRAINT dt_Reservation CHECK (EndDate > ResDate))
*/

--Q19
/*
INSERT INTO Reservation VALUES
(3, '0330255800', '2015-05-02', '2015-05-12')
INSERT INTO Reservation VALUES
(5, '9971643359', '2015-05-14', '2015-06-12')
INSERT INTO Reservation VALUES
(5, '0201708574', '2015-05-18', '2015-05-28')
INSERT INTO Reservation VALUES
(6, '9971643359', '2015-05-20', '2015-06-03')
INSERT INTO Reservation VALUES
(3, '9971643359', GETDATE(), (DATEADD(Week, 2, GETDATE())))
*/

--Q20
SELECT b.ISBN, b.Title, b.YearPublish, b.PublisherID, b.BookCat, r.MemberID, FORMAT (r.ResDate, 'MM-yyyy') AS 'ResDate', FORMAT(r.EndDate, 'MM-yyyy') AS 'EndDate'
FROM Book b INNER JOIN Reservation r ON b.ISBN = r.ISBN
WHERE ('2015-05-30' >= ResDate AND ResDate >= '2015-05-15')