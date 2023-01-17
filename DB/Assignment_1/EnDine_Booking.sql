--Creation of Tables
/*
CREATE TABLE Cruise_Ship (ShipID tinyint NOT null,ShipName varchar(20) NOT null,ShipSize smallint null,ShipServices varchar(20) null,ShipType varchar(20) null,ShipRegion varchar(25) NOT null, CONSTRAINT pk_Cruise_Ship PRIMARY KEY(ShipID))

CREATE TABLE Location (LocationID tinyint NOT null,StartportID tinyint NOT null,StaffportName varchar(60) null,EndportID tinyint NOT null,EndportName varchar(60) NOT null,Distance smallint null, CONSTRAINT pk_Location PRIMARY KEY(LocationID))

CREATE TABLE Staff (StaffID tinyint NOT null,StaffName varchar(50) NOT null,StaffContact char(10) NOT null,StaffType varchar(10) null,SupervisorID tinyint null,StaffAddr varchar(100) NOT null,StaffEmailAddr varchar(30) NOT null,StaffGender char(1) NOT null,StaffAge tinyint null,StaffSalary smallmoney null,StaffDOB smalldatetime NOT null, CONSTRAINT pk_Staff PRIMARY KEY(StaffID))

CREATE TABLE Customers (CustID tinyint NOT null,CustName varchar(50) NOT null,CustCabin tinyint NOT null,CustContact char(10) NOT null,CustCruiseStart smalldatetime NOT null,CustCruiseEnd smalldatetime NOT null,CustCruiseDur tinyint null,CustCardID varchar(15) null, CONSTRAINT pk_Customers PRIMARY KEY(CustID))

CREATE TABLE Cabins (CabinID tinyint NOT null,CabinType varchar(15) null,CabinDeck varchar(15) null,CabinSize tinyint null,Cabinprice smallmoney null, CONSTRAINT pk_Cabins PRIMARY KEY(CabinID))

CREATE TABLE Restaurants (RestID tinyint NOT null,RestSeats smallint null,FoodID varchar(30) null,FoodName varchar(30) null,FoodType varchar(20) null,FoodAllerg varchar(50) null,FoodCrit varchar(10) null, CONSTRAINT pk_Restaurants PRIMARY KEY(RestID))

CREATE TABLE Entertainment (EntID tinyint NOT null,EntName varchar(30) NOT null,EntType varchar(20) null,EntTime smalldatetime NOT null,EntDeck varchar(15) null,EntAgeReq tinyint null,EntAvail smallint null,EntCost smallmoney null, CONSTRAINT pk_Entertainment PRIMARY KEY(EntID))
*/
