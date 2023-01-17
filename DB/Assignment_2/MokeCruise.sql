/*
-----CREATION OF TABLES-----

Create Table Eatery(
EatyID int NOT NULL,
EatyClhr time NOT NULL,
EatyOpHr time NOT NULL,
EatyCapacity int NOT NULL,
EatyLoc Varchar(100) NOT NULL,
EatyName VarChar(100) NOT NULL,
CONSTRAINT Pk_Eatery PRIMARY KEY (EatyID))

CREATE TABLE Cuisine
(
cuisineID Int NOT NULL,
cuisineName VarChar(100) NOT NULL,
CONSTRAINT Pk_Cuisine Primary Key(cuisineID))

Create Table Reservation(
ReservID int NOT NULL,
ReservStatus char(10) NOT NULL, 
NoOfPax int NOT NULL,
ReservDateTime DateTime NOT NULL,
RequiredDateTime DateTime NULL,
PrgID int NOT NULL,
EatyID int NOT NULL,
CONSTRAINT Pk_Reserv PRIMARY KEY (ReservID),
CONSTRAINT Fk_Reserv FOREIGN KEY (EatyID) REFERENCES Eatery(EatyID))

CREATE TABLE Passenger
(
PgrID int,
PgrName VarChar(100) Not NULL,
PgrEmail VarChar(100) Not NULL,
CabinNo Int Not Null,
PgrGender char(2) NOT NULL CHECK(PgrGender IN ('M', 'F')),
PgrDOB DateTime NOT NULL DEFAULT (GETDATE()),
Constraint PK_Passenger Primary Key(PgrID),
)

CREATE TABLE PassengerContact
(
PgrID Int Not NULL,
PgrContactNo VarChar(100) Not null,
Constraint FK_PassengerContact_PgrID Foreign Key(PgrID) REFERENCES Passenger(PgrID),
Constraint PK_PassengerContact_PgrContactNo PRIMARY KEY (PgrContactNo)
)

CREATE TABLE EventType
(
ETID INT NOT NULL,
ETName VARCHAR(100) NOT NULL,
CONSTRAINT PK_EventType Primary Key(ETID)
)

CREATE TABLE Event
(
EventID int NOT NULL,
EventName VarChar(100) NOT NULL,
EventDescr VarChar(255) NULL,
ChildPrice Money NULL,
AdultPrice Money NULL,
EventDuration SmallInt NOT NULL,
EventCapacity Int NOT NULL,
MinAge Int NULL,
MaxAge INT NULL,
EventLoc VarChar(100) NOT NULL, 
ETID Int NOT NULL,
CONSTRAINT PK_Event Primary Key(EventID),
CONSTRAINT FK_Event_ETID Foreign Key(ETID) REFERENCES EventType(ETID)
)

CREATE TABLE EventSession
(
SessionNo Int NOT NULL,
EventID Int NOT NULL,
EventDateTime DateTime NOT NULL,
CONSTRAINT PK_EventSession Primary Key(SessionNo),
CONSTRAINT FK_EventSession_EventID Foreign Key(EventID) REFERENCES Event(EventID)
)

CREATE TABLE PassengerOrders
(
PgrID Int NOT NULL,
DelDateTime DateTime NOT NULL,
DeliverTo Int NOT NULL,
OrderDateTime DateTime NOT NULL,
OrderQty Int NOT NULL,
OrderPrice Money NOT NULL,
DishID Int NOT NULL,
CONSTRAINT Pk_Passenger_Orders PRIMARY KEY (PgrID),
CONSTRAINT Fk_PassengerOrders_PgrID Foreign Key(PgrID) REFERENCES Passenger(PgrID),
CONSTRAINT FK_PassengerOrders_DishID Foreign Key(DishID) REFERENCES Dish(DishID)
)

CREATE TABLE Dish
(
DishID Int NOT NULL,
DishName VarChar(100) NOT NULL,
DishDescr VarChar(255) NULL,
CuisineID Int NOT NULL,
EatyID Int NOT NULL,
CONSTRAINT PK_Dish Primary Key(DishID),
CONSTRAINT FK_Dish_EatyID Foreign Key(EatyID) REFERENCES Eatery(EatyID),
CONSTRAINT FK_Dish_cuisineID Foreign Key(cuisineID) REFERENCES Cuisine(cuisineID)
)

CREATE TABLE Ingredient
(
IngredID Int NOT NULL,
IngredName varchar(20) Not NULL,
CONSTRAINT PK_Ingredient PRIMARY KEY (IngredID)
)

CREATE TABLE DishContains
(
IngredID Int NOT NULL,
DishID Int NOT NULL,
CONSTRAINT FK_DishContains_IngredID Foreign Key(IngredID) REFERENCES Ingredient(IngredID),
CONSTRAINT FK_DishContains_DishID Foreign Key(DishID) REFERENCES Dish(DishID)
)

CREATE TABLE FoodCategory
(
FcID Int NOT NULL,
FcName VarChar(100) NOT NULL,
FcDescr VarChar(255) NULL,
CONSTRAINT PK_FoodCategory Primary Key(FcID),
)

CREATE TABLE DishCategory
(
FcID Int NOT NULL,
DishID Int NOT NULL,
CONSTRAINT Pk_DishCategory PRIMARY KEY(FcID, DishID),
CONSTRAINT FK_DishCategory_FcID Foreign Key(FcID) REFERENCES FoodCategory(FcID),
CONSTRAINT FK_DishID Foreign key(DishID) REFERENCES Dish(DishID)
)

CREATE TABLE CSDish
(
DishID Int NOT NULL,
Price Money NOT NULL,
CONSTRAINT FK_CSDish_DishID Foreign Key(DishID) REFERENCES Dish(DishID)
)

CREATE TABLE Booking
(
BookingID Int NOT NULL,
NoOfAdultTicket Int NOT NULL,
NoOfChildTicket Int NOT NULL,
AdultSalesPrice Money NULL,
ChildSalesPrice Money NULL,
BookDateTime DateTime NOT NULL,
BookStatus VarChar(20) NOT NULL,
PgrID Int NOT NULL,
SessionNo Int NOT NULL,
EventID Int NOT NULL,
CONSTRAINT PK_Booking Primary Key(BookingID),
CONSTRAINT FK_Booking_PgrID Foreign Key(PgrID) REFERENCES Passenger(PgrID),
CONSTRAINT FK_Booking_SessionNo Foreign Key(SessionNo) REFERENCES EventSession(SessionNo),
CONSTRAINT FK_Booking_EventID Foreign Key(EventID) REFERENCES Event(EventID)
)

----------------------------

-------INSERTING DATA-------

INSERT INTO Passenger VALUES (1, 'Johnny Boy', 'johnnyboy@gmail.com', 2, 'M', '2/2/1993' )
INSERT INTO Passenger VALUES (2, 'Mary Lim', 'marylim@hotmail.com', 3, 'F', '9/16/1998' )
INSERT INTO Passenger VALUES (3, 'Caleb Speed', 'calebspeed@yahoo.com.sg', 2, 'M', '2/12/2007' )
INSERT INTO Passenger VALUES (4, ' Patricia Khoo', 'patriciakhoo@gmail.com', 4, 'F', '5/10/1992' )
INSERT INTO Passenger VALUES (5, 'Lesley Teo', 'lesleyteo@gmail.com', 10, 'M', '4/18/2000' )
INSERT INTO Passenger VALUES (6, 'Adeline Tan', 'adelinetan@gmail.com', 6, 'F', '3/27/1998' )
INSERT INTO Passenger VALUES (7, 'Amy Lin', 'amylin2001@gmail.com', 7, 'F', '9/3/2001' )
INSERT INTO Passenger VALUES (8, 'Elaine Choo', 'Elainechoo@gmail.com', 5, 'F', '4/16/2000' )
INSERT INTO Passenger VALUES (9, 'Tim Tam', 'Timtam@gmail.com', 9, 'M', '5/23/1990' )
INSERT INTO Passenger VALUES (10, 'Jon Lee', 'Jonlee@gmail.com', 3, 'M', '9/25/1985' )
INSERT INTO Passenger VALUES (11, 'Alec Benjamin', 'alecbenjamin@gmail.com', 11, 'M', '5/28/1994' )
INSERT INTO Passenger VALUES (12, 'Sam Smith', 'samsmith@gmail.com', 12, 'M', '5/19/1992' )
INSERT INTO Passenger VALUES (13, 'Lewis Capaldi', 'lewisCap@gmail.com', 13, 'M', '10/7/1996' )
INSERT INTO Passenger VALUES (14, 'Julia Michaels', 'juliam@gmail.com', 14, 'F', '11/13/1993' )
INSERT INTO Passenger VALUES (15, 'James Arthur', 'jamesarthur@gmail.com', 16, 'M', '3/2/1988' )
INSERT INTO Passenger VALUES (16, 'Jaymes Young', 'jaymesyoung@gmail.com', 15, 'M', '9/1/1991' )
INSERT INTO Passenger VALUES (17, 'Isaac Dunbar', 'isaacdun@gmail.com', 17, 'M', '3/17/2003' )
INSERT INTO Passenger VALUES (18, 'Lyn Lapid', 'lynlapid@gmail.com', 18, 'F', '10/24/2001' )
INSERT INTO Passenger VALUES (19, 'James Blunt', 'james_blunt@gmail.com', 19, 'M', '2/22/1974' )
INSERT INTO Passenger VALUES (20, 'Ryan Woods', 'ryanwood1988@gmail.com', 20, 'M', '5/16/1988' )
INSERT INTO Passenger VALUES (21, 'Marmar Oso', 'marmar@gmail.com', 21, 'M', '3/1/1999' )
INSERT INTO Passenger VALUES (22, 'Jacob Banks', 'jacob_1991@gmail.com', 22, 'M', '6/24/1991' )
INSERT INTO Passenger VALUES (23, 'Jack Rutter', 'rutter_1999@gmail.com', 23, 'M', '10/12/1999' )
INSERT INTO Passenger VALUES (24, 'Sasha Alec Sloan', 'sashasloan@gmail.com', 24, 'F', '3/11/1995' )
INSERT INTO Passenger VALUES (25, 'David Hugo', 'davidhugo2000@gmail.com', 25, 'M', '12/16/2000' )

INSERT INTO Booking VALUES (1, 1, 1, 12, 8, '2/13/2022 18:00', 'Pending', 1, 1, 1 )
INSERT INTO Booking VALUES (2, 1, 0, 14, 10, '1/6/2022', 'Completed', 2, 2, 2 )
INSERT INTO Booking VALUES (3, 1, 1, 12, 8, '2/13/2022 18:00', 'Pending', 3, 1, 1 )
INSERT INTO Booking VALUES (4, 1, 0, null, null, '12/30/2021 12:00', 'Completed', 4, 4, 4 )
INSERT INTO Booking VALUES (5, 1, 0, 13, 8, '1/17/2022 18:00', 'Pending', 5, 5, 5 )
INSERT INTO Booking VALUES (6, 2, 0, null, null, '1/16/2022 15:00', 'Completed', 6, 6, 6 )
INSERT INTO Booking VALUES (7, 1, 1, 5, 10, '1/10/2022 18:00', 'Completed', 7, 7, 7 )
INSERT INTO Booking VALUES (8, 2, 3, 10, 15, '1/14/2022 13:00 pm', 'Pending', 8, 8, 8 )
INSERT INTO Booking VALUES (9, 4, 0, 9, null, '1/1/2022 18:00', 'Completed', 9, 9, 9 )
INSERT INTO Booking VALUES (10, 1, 2, 14, 10, '1/1/2022 10:00', 'Pending', 10, 10, 10 )
INSERT INTO Booking VALUES (11, 2, 1, null, null, '2/5/2022 10:00', 'Pending', 3, 11, 11 )
INSERT INTO Booking VALUES (12, 1, 0, null, null, '2/3/2022 23:00 pm', 'Pending', 11, 12, 12 )
INSERT INTO Booking VALUES (13, 1, 0, 8, 5, '1/7/2022 13:00 pm', 'Completed', 4, 13, 13 )
INSERT INTO Booking VALUES (14, 2, 0, 5, null, '1/20/2022 16:00 pm', 'Completed', 5, 14, 14 )
INSERT INTO Booking VALUES (15, 1, 0, 10, null, '1/1/2022 16:00 pm', 'Completed', 12, 15, 15 )
INSERT INTO Booking VALUES (16, 1, 0, 13, 8, '1/19/2022 16:00 pm', 'Completed', 13, 19, 5 )
INSERT INTO Booking VALUES (17, 2, 1, 14, 10, '1/13/2022 15:00 pm', 'Completed', 14, 16, 2 )
INSERT INTO Booking VALUES (18, 2, 0, 13, 7, '2/9/2022 18:00 pm', 'Pending', 15, 17, 3 )
INSERT INTO Booking VALUES (19, 2, 0, null, null, '1/25/202 14:00 pm', 'Completed', 16, 20, 6 )
INSERT INTO Booking VALUES (20, 1, 1, 10, 5, '2/10/2022 12:00', 'Completed', 17, 7, 7 )

INSERT INTO PassengerContact VALUES (1, '92920101' )
INSERT INTO PassengerContact VALUES (2, '92910430' )
INSERT INTO PassengerContact VALUES (3, '81010393' )
INSERT INTO PassengerContact VALUES (4, '91020092' )
INSERT INTO PassengerContact VALUES (5, '91203891' )
INSERT INTO PassengerContact VALUES (6, '84355937' )
INSERT INTO PassengerContact VALUES (7, '84757869' )
INSERT INTO PassengerContact VALUES (8, '94758855' )
INSERT INTO PassengerContact VALUES (9, '92746596' )
INSERT INTO PassengerContact VALUES (10, '85734737' )
INSERT INTO PassengerContact VALUES (11, '88475757' )
INSERT INTO PassengerContact VALUES (12, '99375758' )
INSERT INTO PassengerContact VALUES (13, '82943754' )
INSERT INTO PassengerContact VALUES (14, '88576468' )
INSERT INTO PassengerContact VALUES (15, '98375638' )
INSERT INTO PassengerContact VALUES (16, '89474782' )
INSERT INTO PassengerContact VALUES (17, '88535858' )
INSERT INTO PassengerContact VALUES (18, '98897747' )
INSERT INTO PassengerContact VALUES (19, '84834758' )
INSERT INTO PassengerContact VALUES (20, '84835735' )
INSERT INTO PassengerContact VALUES (21, '99375734' )
INSERT INTO PassengerContact VALUES (22, '82948573' )
INSERT INTO PassengerContact VALUES (23, '92847473' )
INSERT INTO PassengerContact VALUES (24, '82847357' )
INSERT INTO PassengerContact VALUES (25, '83867385' )

INSERT INTO EventType VALUES (1, 'Competition' )
INSERT INTO EventType VALUES (2, 'Musical' )
INSERT INTO EventType VALUES (3, 'Movie' )
INSERT INTO EventType VALUES (4, 'Music Performance' )
INSERT INTO EventType VALUES (5, 'Workshops' )
INSERT INTO EventType VALUES (6, 'Dance Festival' )
INSERT INTO EventType VALUES (7, 'Seminars' )
INSERT INTO EventType VALUES (8, 'Trade Shows' )
INSERT INTO EventType VALUES (9, 'Carnival' )
INSERT INTO EventType VALUES (10, 'Exhibitions' )
INSERT INTO EventType VALUES (11, 'Beverage Function' )
INSERT INTO EventType VALUES (12, 'Games' )

INSERT INTO Event VALUES (1, 'The Lost Kings', 'A play of the kings who lost their homes ', 8, 12, 120, 100, 5, 100, 'Deck 5', 2 )
INSERT INTO Event VALUES (2, 'Les miserable', 'A story of Jean Valjean', 10, 14, 120, 200, 5, 100, 'Deck 10', 2 )
INSERT INTO Event VALUES (3, 'Spooderman', 'A movie made by barvel', 7, 13, 145, 150, 13, 100, 'Deck 2', 3 )
INSERT INTO Event VALUES (4, 'Cup Stacking Competition', 'Competition for anyone to participate', null, null, 180, 100, 8, 100, 'Deck 6', 1 )
INSERT INTO Event VALUES (5, 'Tangled', 'A musical about rapunzel, a naive little girl ', 8, 13, 145, 100, 13, 100, 'Deck 5', 2 )
INSERT INTO Event VALUES (6, 'Paper folding workshop', 'A workshop for all to join to learn paper folding techniques', null, null, 180, 100, 5, 90, 'Deck 2', 5 )
INSERT INTO Event VALUES (7, 'Titanic exhibition', 'An exhibition of the artifacts on the titanic', 5, 10, 600, 200, 10, 100, 'Deck 5', 10 )
INSERT INTO Event VALUES (8, 'Beethoven Symphony', 'A musical performance of symphonies by Beethoven', 10, 15, 120, 150, 9, 95, 'Deck 7', 4 )
INSERT INTO Event VALUES (9, 'Bouncy Castle', 'A carnival for children to attend and have fun!', 9, null, 180, 100, 5, 11, 'Deck 3', 9 )
INSERT INTO Event VALUES (10, 'Venom', 'A movie by barvel of magical powers', 10, 14, 145, 100, 13, 80, 'Deck 2', 3 )
INSERT INTO Event VALUES (11, 'Book Fair', 'A fair for all to purchase books of interest', null, null, 600, 500, null, null, 'Deck 5', 8 )
INSERT INTO Event VALUES (12, 'Ticketed Cash Bar', 'Attendees have limited free drinks', null, null, 120, 150, 21, null, 'Deck 6', 11 )
INSERT INTO Event VALUES (13, 'Scavenger Hunt', 'Participants look to gather items listed', 5, 8, 180, 50, 7, null, 'Deck 2', 1 )
INSERT INTO Event VALUES (14, 'Dance-off', 'A dancing competition', null, 5, 120, 100, 5, null, 'Deck 9', 1 )
INSERT INTO Event VALUES (15, 'Fashion Show', 'A display of trending outfits', null, 10, 120, 200, 10, null, 'Deck 10', 10 )

INSERT INTO Eatery VALUES (1, '10:00 pm', '9:00 am', 100, 'Deck 3', 'Bfc' )
INSERT INTO Eatery VALUES (2, '10:00 pm', '10:00 am', 200, 'Deck 4', 'Ackdonalds' )
INSERT INTO Eatery VALUES (3, '11:00 pm', '11:00 am', 50, 'Deck 3', 'Goody bread' )
INSERT INTO Eatery VALUES (4, '11:00 pm', '10:00 am', 150, 'Deck 4', 'Food Center' )
INSERT INTO Eatery VALUES (5, '10:00 pm', '9:00 am', 75, 'Deck 1', 'Lukes Steakhouse' )
INSERT INTO Eatery VALUES (6, '12:00 am', '6:00 am', 100, 'Deck 2', 'The Day Place' )
INSERT INTO Eatery VALUES (7, '10:00 pm', '8:00 am', 60, 'Deck 2', 'Arduinos' )
INSERT INTO Eatery VALUES (8, '11:00 pm', '11:00 am', 40, 'Deck 4', 'Lim Kitchen' )
INSERT INTO Eatery VALUES (9, '2:00 am', '5:00 pm', 50, 'Deck 3', 'Night Meals' )
INSERT INTO Eatery VALUES (10, '10:00 pm', '10:00 am', 50, 'Deck 1', 'Heavens Restaurant' )
INSERT INTO Eatery VALUES (11, '2:00 pm', '4:00 am', 30, 'Deck 3', 'Rise n Shine' )
INSERT INTO Eatery VALUES (12, '8:00 pm', '12:00 pm', 40, 'Deck 5', 'Noma' )
INSERT INTO Eatery VALUES (13, '12:00 am', '2:00 pm', 50, 'Deck 5', 'Casa Del Cibo' )
INSERT INTO Eatery VALUES (14, '8:00 pm', '10:00 am', 50, 'Deck 2', 'Pujol' )
INSERT INTO Eatery VALUES (15, '6:00 am', '10:00 pm', 40, 'Deck 3', 'The Den' )

INSERT INTO Cuisine VALUES (1, 'Italian' )
INSERT INTO Cuisine VALUES (2, 'Scandinavian' )
INSERT INTO Cuisine VALUES (3, 'American' )
INSERT INTO Cuisine VALUES (4, 'Chinese' )
INSERT INTO Cuisine VALUES (5, 'French' )
INSERT INTO Cuisine VALUES (6, 'Greek' )
INSERT INTO Cuisine VALUES (7, 'Mediterranean' )
INSERT INTO Cuisine VALUES (8, 'Japanese' )
INSERT INTO Cuisine VALUES (9, 'Turkish' )
INSERT INTO Cuisine VALUES (10, 'Thai' )
INSERT INTO Cuisine VALUES (11, 'Indian' )
INSERT INTO Cuisine VALUES (12, 'Spanish' )
INSERT INTO Cuisine VALUES (13, 'Lebanese' )
INSERT INTO Cuisine VALUES (14, 'Moroccan' )
INSERT INTO Cuisine VALUES (15, 'Swedish' )

INSERT INTO Dish VALUES (1, 'Carbonara', 'Creamy spaghetti with ham', 1, 5 )
INSERT INTO Dish VALUES (2, 'Prime Sirloin Steak', 'Beautiful piece of steak with chips as', 2, 5 )
INSERT INTO Dish VALUES (3, 'Cheeseburger', 'Beatiful beef patties with cheese between two', 3, 2 )
INSERT INTO Dish VALUES (4, 'Chicken Rice', 'Chicken slices with a bowl of rice and soup', 4, 4 )
INSERT INTO Dish VALUES (5, 'Spicy Fried Chicken', 'Fried chicken that is marinated in dif', 3, 1 )
INSERT INTO Dish VALUES (6, 'Salmon Sashimi', 'Fresh slices of salmon with a drizzle of lemon juice', 8, 10 )
INSERT INTO Dish VALUES (7, 'Tom Yum Soup', 'Sweet and sour soup with seafood', 10, 6 )
INSERT INTO Dish VALUES (8, 'Kebabs', 'It is a deliciously cooked meat', 9, 7 )
INSERT INTO Dish VALUES (9, 'Pastitsio', 'Greek lasagna that has a mix or meat pasta bechamel and tomato sauce topped with melted cheese', 6, 9 )
INSERT INTO Dish VALUES (10, 'Pizza', 'Varieties of pizzas available', 7, 3 )
INSERT INTO Dish VALUES (11, 'Fajitas', 'Grilled meat with peppers and onion', 12, 13 )
INSERT INTO Dish VALUES (12, 'Key Lime Pie', 'Lime flavoured pie with meringue', 3, 11 )
INSERT INTO Dish VALUES (13, 'Hash Browns', 'Fried chopped potatoes', 3, 2 )
INSERT INTO Dish VALUES (14, 'Cobb Salad', 'Salad greens with meat and eggs', 3, 15 )
INSERT INTO Dish VALUES (15, 'Pot Roast', 'Slow cooked beef', 3, 5 )
INSERT INTO Dish VALUES (16, 'Pad krapow moo', 'Stir-fried basil and pork', 10, 12 )
INSERT INTO Dish VALUES (17, 'Menemen', 'Scrambled eggs with spices, onions and pepper', 9, 14 )
INSERT INTO Dish VALUES (18, 'Sweet Roll', 'Wheat bun with almond paste', 15, 8 )
INSERT INTO Dish VALUES (19, 'Som Tum', 'Spicy green papaya salad', 10, 15 )
INSERT INTO Dish VALUES (20, 'Warak Enab', 'Ground beef in brined grape leaves', 13, 13 )
INSERT INTO Dish VALUES (21, 'Cioppino', 'Seafood stew with tomatoes and wine', 1, 6 )
INSERT INTO Dish VALUES (22, 'Clam Chowder', 'Clam soup with potatoes and onions', 3, 5 )
INSERT INTO Dish VALUES (23, 'Chicken Makhani', 'Chicken with spiced tomato sauce', 11, 12 )
INSERT INTO Dish VALUES (24, 'Meatballs', 'Ground meat rolled into balls', 15, 7 )
INSERT INTO Dish VALUES (25, 'Chicken Bastilla', 'Chicken with spices in a pastry', 14, 13 )

INSERT INTO Ingredient VALUES (1, 'Beef' )
INSERT INTO Ingredient VALUES (2, 'Noodles' )
INSERT INTO Ingredient VALUES (3, 'Bread' )
INSERT INTO Ingredient VALUES (4, 'Potato' )
INSERT INTO Ingredient VALUES (5, 'Chicken' )
INSERT INTO Ingredient VALUES (6, 'Salmon' )
INSERT INTO Ingredient VALUES (7, 'Flour' )
INSERT INTO Ingredient VALUES (8, 'Egg' )
INSERT INTO Ingredient VALUES (9, 'Rice' )
INSERT INTO Ingredient VALUES (10, 'Butter' )
INSERT INTO Ingredient VALUES (11, 'Salt' )
INSERT INTO Ingredient VALUES (12, 'Olive oil' )
INSERT INTO Ingredient VALUES (13, 'Vegetable oil' )
INSERT INTO Ingredient VALUES (14, 'Pork' )
INSERT INTO Ingredient VALUES (15, 'Milk' )
INSERT INTO Ingredient VALUES (16, 'Mushrooms' )
INSERT INTO Ingredient VALUES (17, 'Peppers' )
INSERT INTO Ingredient VALUES (18, 'Onion' )
INSERT INTO Ingredient VALUES (19, 'Coconut' )
INSERT INTO Ingredient VALUES (20, 'Garlic' )
INSERT INTO Ingredient VALUES (21, 'Orange' )
INSERT INTO Ingredient VALUES (22, 'Cheeseburger' )
INSERT INTO Ingredient VALUES (23, 'Lamb' )
INSERT INTO Ingredient VALUES (24, 'Turkey' )
INSERT INTO Ingredient VALUES (25, 'Tomatoes' )
INSERT INTO Ingredient VALUES (26, 'Paprika' )
INSERT INTO Ingredient VALUES (27, 'Almond' )
INSERT INTO Ingredient VALUES (28, 'Clam ' )
INSERT INTO Ingredient VALUES (29, 'Mayonnaise' )
INSERT INTO Ingredient VALUES (30, 'Basil' )
INSERT INTO Ingredient VALUES (31, 'Cheese' )
INSERT INTO Ingredient VALUES (32, 'Papaya' )
INSERT INTO Ingredient VALUES (33, 'Bechamel' )
INSERT INTO Ingredient VALUES (34, 'Galangal' )
INSERT INTO Ingredient VALUES (35, 'Chili' )
INSERT INTO Ingredient VALUES (36, 'Guanciale' )
INSERT INTO Ingredient VALUES (37, 'Thyme' )
INSERT INTO Ingredient VALUES (38, 'Pickle' )
INSERT INTO Ingredient VALUES (39, 'Ginger' )
INSERT INTO Ingredient VALUES (40, 'Soy Sauce' )
INSERT INTO Ingredient VALUES (41, 'Salmon' )
INSERT INTO Ingredient VALUES (42, 'Prawns' )
INSERT INTO Ingredient VALUES (43, 'Fish' )
INSERT INTO Ingredient VALUES (44, 'Lime' )
INSERT INTO Ingredient VALUES (45, 'FishSauce' )
INSERT INTO Ingredient VALUES (46, 'Cream' )
INSERT INTO Ingredient VALUES (47, 'Sugar' )

INSERT INTO EventSession VALUES (1, 1, '2/15/2022' )
INSERT INTO EventSession VALUES (2, 2, '1/10/2022' )
INSERT INTO EventSession VALUES (3, 3, '2/11/2022 14:00 pm' )
INSERT INTO EventSession VALUES (4, 4, '1/3/2022 12:00' )
INSERT INTO EventSession VALUES (5, 5, '2/22/2022 17:00' )
INSERT INTO EventSession VALUES (6, 6, '1/17/2022 15:00' )
INSERT INTO EventSession VALUES (7, 7, '2/12/2022 12:00' )
INSERT INTO EventSession VALUES (8, 8, '1/25/2022 13:00' )
INSERT INTO EventSession VALUES (9, 9, '1/10/2022 13:00' )
INSERT INTO EventSession VALUES (10, 10, '2/12/2022 19:00' )
INSERT INTO EventSession VALUES (11, 11, '2/12/2022 10:00' )
INSERT INTO EventSession VALUES (12, 12, '2/14/2022 23:00' )
INSERT INTO EventSession VALUES (13, 13, '1/20/2022 13:00' )
INSERT INTO EventSession VALUES (14, 14, '1/25/2022 16:00' )
INSERT INTO EventSession VALUES (15, 15, '1/3/2022 20:00' )
INSERT INTO EventSession VALUES (16, 2, '1/16/2022  15:00:00 pm' )
INSERT INTO EventSession VALUES (17, 3, '2/11/2022 18:00 pm' )
INSERT INTO EventSession VALUES (18, 4, '1/13/2022 10:00' )
INSERT INTO EventSession VALUES (19, 5, '1/22/2022 16:00 pm' )
INSERT INTO EventSession VALUES (20, 6, '1/28/2022 14:00 pm' )

INSERT INTO FoodCategory VALUES (1, 'Vegan', 'Food that is made out of purely greens or vegetables' )
INSERT INTO FoodCategory VALUES (2, 'Halal', 'Food that is suitable for muslim consumption' )
INSERT INTO FoodCategory VALUES (3, 'Meat or Poultry', 'Food that contains meat ' )
INSERT INTO FoodCategory VALUES (4, 'Whole Grains', 'Food that provides carbohydrates' )
INSERT INTO FoodCategory VALUES (5, 'Kosher', 'Food that is suitable for Jewish Consumption' )
INSERT INTO FoodCategory VALUES (6, 'Dairy-Free', 'Food without dairy products like cheese' )
INSERT INTO FoodCategory VALUES (7, 'Vegetarian', 'Food without slaughter of animals' )
INSERT INTO FoodCategory VALUES (8, 'Gluten-Free', 'Food without the protein gluten' )
INSERT INTO FoodCategory VALUES (9, 'Keto', 'Low Carb and High fat food' )
INSERT INTO FoodCategory VALUES (10, 'Diabetic-Friendly', 'Low fat and less sweet food' )
INSERT INTO FoodCategory VALUES (11, 'Seafood', 'Food that comes from the sea' )

INSERT INTO Reservation VALUES (1, 'Pending', 5, '2/15/2022 12:00', '2/16/2022 12:00', 1, 1 )
INSERT INTO Reservation VALUES (2, 'Completed', 5, '1/8/2022 11:00', '1/9/2022 11:00', 2, 2 )
INSERT INTO Reservation VALUES (3, 'Pending', 2, '2/9/2022 18:00', '2/10/2022 18:00', 3, 5 )
INSERT INTO Reservation VALUES (4, 'Pending', 3, '2/19/2022 19:00', '2/20/2022 19:00', 4, 4 )
INSERT INTO Reservation VALUES (5, 'Completed', 1, '1/11/2022', '1/12/2022 15:00', 5, 3 )
INSERT INTO Reservation VALUES (6, 'Completed', 4, '2/20/2022 10:00', '2/20/2022 18:00', 6, 7 )
INSERT INTO Reservation VALUES (7, 'Completed', 2, '2/16/2022 12:00', '2/17/2022 12:00', 7, 10 )
INSERT INTO Reservation VALUES (8, 'Pending', 4, '2/9/2022 10:00', '2/10/2022 4:00', 8, 9 )
INSERT INTO Reservation VALUES (9, 'Pending', 1, '2/6/2022 13:00', '2/7/2022 13:00', 9, 6 )
INSERT INTO Reservation VALUES (10, 'Completed', 5, '1/8/2022 11:00', '1/9/2022 11:00', 10, 2 )
INSERT INTO Reservation VALUES (11, 'Pending', 5, '2/10/2022 18:00', '2/10/2022 6:00', 3, 12 )
INSERT INTO Reservation VALUES (12, 'Completed', 2, '1/5/2022 10:00', '1/7/2022 19:00', 11, 14 )
INSERT INTO Reservation VALUES (13, 'Completed', 1, '1/19/2022 13:00 pm', '2/20/2022 11:00', 12, 15 )
INSERT INTO Reservation VALUES (14, 'Pending', 1, '2/22/2022 6:00', '2/23/2022 12:00pm', 13, 13 )
INSERT INTO Reservation VALUES (15, 'Completed', 2, '2/25/2022 1:00', '2/27/2022 14:00', 14, 11 )
INSERT INTO Reservation VALUES (16, 'Pending', 1, '2/22/2022 13:00:00pm', '2/22/2022 13:00:00pm', 15, 15 )
INSERT INTO Reservation VALUES (17, 'Completed', 2, '12/29/2021 13:00', '12/29/2021 13:00', 16, 14 )
INSERT INTO Reservation VALUES (18, 'Completed', 2, '12/23/2021 10:00', '12/23/2021 10:00', 2, 11 )
INSERT INTO Reservation VALUES (19, 'Pending', 1, '1/12/2022 13:00:00pm', '2/12/2022 13:00:00pm', 17, 12 )
INSERT INTO Reservation VALUES (20, 'Completed', 2, '12/21/2021 12:00', '12/21/2021 12:00', 18, 13 )
INSERT INTO Reservation VALUES (21, 'Pending', 1, '2/22/2022 15:00:00pm', '2/22/2022 15:00:00pm', 3, 15 )
INSERT INTO Reservation VALUES (22, 'Pending', 2, '1/18/2022 13:00:00pm', '2/18/2022 13:00:00pm', 19, 9 )
INSERT INTO Reservation VALUES (23, 'Completed', 1, '12/26/2021 10:00', '12/26/2021 10:00', 20, 5 )
INSERT INTO Reservation VALUES (24, 'Pending ', 1, '1/15/2022 13:00:00pm', '2/15/2022 13:00:00pm', 21, 4 )
INSERT INTO Reservation VALUES (25, 'Completed', 2, '12/25/2021 11:00', '12/25/2021 11:00', 22, 8 )

INSERT INTO PassengerOrders VALUES (1, '1/10/2022 12:00', 2, '1/10/2022 11:00', 2, 30, 1 )
INSERT INTO PassengerOrders VALUES (2, '1/2/2022 19:00', 3, '1/2/2022 18:00', 1, 15, 4 )
INSERT INTO PassengerOrders VALUES (3, '1/10/2022 12:00', 2, '1/10/2022 11:00', 2, 30, 1 )
INSERT INTO PassengerOrders VALUES (4, '1/7/2022 21:00', 4, '1/15/2022 20:00', 1, 20, 2 )
INSERT INTO PassengerOrders VALUES (5, '1/17/2022 12:00', 10, '1/17/2022 10:00', 1, 11, 3 )
INSERT INTO PassengerOrders VALUES (6, '1/8/2022 12:30', 6, '2/8/2022 11:30', 1, 7, 7 )
INSERT INTO PassengerOrders VALUES (7, '1/22/2022 12:20', 7, '2/22/2022 11:20', 1, 12, 5 )
INSERT INTO PassengerOrders VALUES (8, '1/13/2022 18:00', 5, '1/13/2022 17:00', 1, 13, 8 )
INSERT INTO PassengerOrders VALUES (9, '1/11/2022 21:00', 9, '1/11/2022 20:30', 1, 20, 10 )
INSERT INTO PassengerOrders VALUES (10, '1/10/2022', 3, '1/10/2022 11:00', 2, 30, 1 )
INSERT INTO PassengerOrders VALUES (11, '1/7/2022 13:00 pm', 11, '1/7/2022 11:00', 2, 10, 12 )
INSERT INTO PassengerOrders VALUES (12, '1/19/2022 19:00', 12, '1/19/2022 17:00 pm', 1, '11.5', 11 )
INSERT INTO PassengerOrders VALUES (13, '1/23/2022 14:00 pm', 13, '1/23/2022 20:00 pm', 1, 15, 15 )
INSERT INTO PassengerOrders VALUES (14, '1/11/2022 13:00 pm', 14, '1/11/2022 13:30 pm', 1, '2.5', 13 )
INSERT INTO PassengerOrders VALUES (15, '1/13/2022 11:00', 16, '1/13/2022 13:00 pm', 1, '11.5', 11 )
INSERT INTO PassengerOrders VALUES (16, '1/13/2022 11:00', 15, '1/13/2022 13:00 pm', 1, 20, 13 )
INSERT INTO PassengerOrders VALUES (17, '1/11/2022 17:00', 17, '1/11/2022 17:30 pm', 1, 5, 14 )
INSERT INTO PassengerOrders VALUES (18, '1/17/2022 15:00 pm', 18, '1/17/2022 20:00', 1, 5, 16 )
INSERT INTO PassengerOrders VALUES (19, '1/24/2022 13:00 pm', 19, '1/24/2022 14:00 pm', 1, 3, 18 )
INSERT INTO PassengerOrders VALUES (20, '1/10/2022 16:00 pm', 20, '1/10/2022 18:00 pm', 1, 10, 20 )

INSERT INTO DishContains VALUES (1, 2 )
INSERT INTO DishContains VALUES (2, 1 )
INSERT INTO DishContains VALUES (3, 3 )
INSERT INTO DishContains VALUES (5, 4 )
INSERT INTO DishContains VALUES (5, 5 )
INSERT INTO DishContains VALUES (6, 6 )
INSERT INTO DishContains VALUES (7, 10 )
INSERT INTO DishContains VALUES (8, 8 )
INSERT INTO DishContains VALUES (2, 9 )
INSERT INTO DishContains VALUES (10, 10 )
INSERT INTO DishContains VALUES (11, 18 )
INSERT INTO DishContains VALUES (12, 10 )
INSERT INTO DishContains VALUES (13, 4 )
INSERT INTO DishContains VALUES (14, 13 )
INSERT INTO DishContains VALUES (15, 1 )
INSERT INTO DishContains VALUES (16, 14 )
INSERT INTO DishContains VALUES (17, 8 )
INSERT INTO DishContains VALUES (18, 3 )
INSERT INTO DishContains VALUES (19, 13 )
INSERT INTO DishContains VALUES (20, 1 )
INSERT INTO DishContains VALUES (21, 25 )
INSERT INTO DishContains VALUES (22, 5 )
INSERT INTO DishContains VALUES (23, 12 )
INSERT INTO DishContains VALUES (24, 1 )
INSERT INTO DishContains VALUES (25, 5 )
INSERT INTO DishContains VALUES (36, 1 )
INSERT INTO DishContains VALUES (8, 1 )
INSERT INTO DishContains VALUES (37, 2 )
INSERT INTO DishContains VALUES (1, 3 )
INSERT INTO DishContains VALUES (12, 3 )
INSERT INTO DishContains VALUES (38, 3 )
INSERT INTO DishContains VALUES (9, 4 )
INSERT INTO DishContains VALUES (20, 4 )
INSERT INTO DishContains VALUES (11, 4 )
INSERT INTO DishContains VALUES (39, 4 )
INSERT INTO DishContains VALUES (40, 4 )
INSERT INTO DishContains VALUES (35, 4 )
INSERT INTO DishContains VALUES (35, 5 )
INSERT INTO DishContains VALUES (41, 6 )
INSERT INTO DishContains VALUES (42, 7 )
INSERT INTO DishContains VALUES (43, 7 )
INSERT INTO DishContains VALUES (25, 7 )
INSERT INTO DishContains VALUES (16, 7 )
INSERT INTO DishContains VALUES (18, 7 )
INSERT INTO DishContains VALUES (44, 7 )
INSERT INTO DishContains VALUES (45, 7 )
INSERT INTO DishContains VALUES (18, 8 )
INSERT INTO DishContains VALUES (20, 8 )
INSERT INTO DishContains VALUES (35, 8 )
INSERT INTO DishContains VALUES (31, 9 )
INSERT INTO DishContains VALUES (1, 9 )
INSERT INTO DishContains VALUES (25, 9 )
INSERT INTO DishContains VALUES (8, 9 )
INSERT INTO DishContains VALUES (31, 10 )
INSERT INTO DishContains VALUES (12, 10 )
INSERT INTO DishContains VALUES (25, 10 )
INSERT INTO DishContains VALUES (20, 10 )
INSERT INTO DishContains VALUES (5, 11 )
INSERT INTO DishContains VALUES (35, 11 )
INSERT INTO DishContains VALUES (44, 12 )
INSERT INTO DishContains VALUES (15, 12 )
INSERT INTO DishContains VALUES (8, 12 )
INSERT INTO DishContains VALUES (4, 13 )
INSERT INTO DishContains VALUES (8, 13 )
INSERT INTO DishContains VALUES (31, 13 )
INSERT INTO DishContains VALUES (13, 14 )
INSERT INTO DishContains VALUES (25, 14 )
INSERT INTO DishContains VALUES (29, 14 )
INSERT INTO DishContains VALUES (12, 15 )
INSERT INTO DishContains VALUES (18, 15 )
INSERT INTO DishContains VALUES (31, 15 )
INSERT INTO DishContains VALUES (37, 15 )
INSERT INTO DishContains VALUES (26, 15 )
INSERT INTO DishContains VALUES (30, 16 )
INSERT INTO DishContains VALUES (35, 16 )
INSERT INTO DishContains VALUES (14, 16 )
INSERT INTO DishContains VALUES (25, 17 )
INSERT INTO DishContains VALUES (8, 17 )
INSERT INTO DishContains VALUES (18, 17 )
INSERT INTO DishContains VALUES (15, 18 )
INSERT INTO DishContains VALUES (8, 18 )
INSERT INTO DishContains VALUES (10, 18 )
INSERT INTO DishContains VALUES (7, 18 )
INSERT INTO DishContains VALUES (11, 18 )
INSERT INTO DishContains VALUES (47, 18 )
INSERT INTO DishContains VALUES (47, 19 )
INSERT INTO DishContains VALUES (35, 19 )
INSERT INTO DishContains VALUES (20, 19 )
INSERT INTO DishContains VALUES (45, 19 )
INSERT INTO DishContains VALUES (25, 19 )
INSERT INTO DishContains VALUES (4, 20 )
INSERT INTO DishContains VALUES (9, 20 )
INSERT INTO DishContains VALUES (25, 20 )
INSERT INTO DishContains VALUES (25, 21 )
INSERT INTO DishContains VALUES (28, 21 )
INSERT INTO DishContains VALUES (43, 21 )
INSERT INTO DishContains VALUES (28, 22 )
INSERT INTO DishContains VALUES (10, 22 )
INSERT INTO DishContains VALUES (18, 22 )
INSERT INTO DishContains VALUES (5, 23 )
INSERT INTO DishContains VALUES (10, 23 )
INSERT INTO DishContains VALUES (18, 23 )
INSERT INTO DishContains VALUES (25, 23 )
INSERT INTO DishContains VALUES (1, 24 )
INSERT INTO DishContains VALUES (8, 24 )
INSERT INTO DishContains VALUES (18, 24 )
INSERT INTO DishContains VALUES (31, 24 )
INSERT INTO DishContains VALUES (10, 25 )
INSERT INTO DishContains VALUES (12, 25 )
INSERT INTO DishContains VALUES (17, 25 )
INSERT INTO DishContains VALUES (18, 25 )

INSERT INTO Booking VALUES (1, 1, 1, 12, 8, '2/13/2022 18:00', 'Pending', 1, 1, 1 )
INSERT INTO Booking VALUES (2, 1, 0, 14, 10, '1/6/2022', 'Completed', 2, 2, 2 )
INSERT INTO Booking VALUES (3, 1, 1, 12, 8, '2/13/2022 18:00', 'Pending', 3, 1, 1 )
INSERT INTO Booking VALUES (4, 1, 0, null, null, '12/30/2021 12:00', 'Completed', 4, 4, 4 )
INSERT INTO Booking VALUES (5, 1, 0, 13, 8, '1/17/2022 18:00', 'Pending', 5, 5, 5 )
INSERT INTO Booking VALUES (6, 2, 0, null, null, '1/16/2022 15:00', 'Completed', 6, 6, 6 )
INSERT INTO Booking VALUES (7, 1, 1, 5, 10, '1/10/2022 18:00', 'Completed', 7, 7, 7 )
INSERT INTO Booking VALUES (8, 2, 3, 10, 15, '1/14/2022 13:00 pm', 'Pending', 8, 8, 8 )
INSERT INTO Booking VALUES (9, 4, 0, 9, null, '1/1/2022 18:00', 'Completed', 9, 9, 9 )
INSERT INTO Booking VALUES (10, 1, 2, 14, 10, '1/1/2022 10:00', 'Pending', 10, 10, 10 )
INSERT INTO Booking VALUES (11, 2, 1, null, null, '2/5/2022 10:00', 'Pending', 3, 11, 11 )
INSERT INTO Booking VALUES (12, 1, 0, null, null, '2/3/2022 23:00 pm', 'Pending', 11, 12, 12 )
INSERT INTO Booking VALUES (13, 1, 0, 8, 5, '1/7/2022 13:00 pm', 'Completed', 4, 13, 13 )
INSERT INTO Booking VALUES (14, 2, 0, 5, null, '1/20/2022 16:00 pm', 'Completed', 5, 14, 14 )
INSERT INTO Booking VALUES (15, 1, 0, 10, null, '1/1/2022 16:00 pm', 'Completed', 12, 15, 15 )
INSERT INTO Booking VALUES (16, 1, 0, 13, 8, '1/19/2022 16:00 pm', 'Completed', 13, 19, 5 )
INSERT INTO Booking VALUES (17, 2, 1, 14, 10, '1/13/2022 15:00 pm', 'Completed', 14, 16, 2 )
INSERT INTO Booking VALUES (18, 2, 0, 13, 7, '2/9/2022 18:00 pm', 'Pending', 15, 17, 3 )
INSERT INTO Booking VALUES (19, 2, 0, null, null, '1/25/202 14:00 pm', 'Completed', 16, 20, 6 )
INSERT INTO Booking VALUES (20, 1, 1, 10, 5, '2/10/2022 12:00', 'Completed', 17, 7, 7 )

INSERT INTO DishCategory VALUES (4, 1 )
INSERT INTO DishCategory VALUES (3, 2 )
INSERT INTO DishCategory VALUES (2, 3 )
INSERT INTO DishCategory VALUES (4, 4 )
INSERT INTO DishCategory VALUES (3, 5 )
INSERT INTO DishCategory VALUES (5, 4 )
INSERT INTO DishCategory VALUES (1, 10 )
INSERT INTO DishCategory VALUES (7, 2 )
INSERT INTO DishCategory VALUES (8, 7 )
INSERT INTO DishCategory VALUES (6, 6 )
INSERT INTO DishCategory VALUES (3, 8 )
INSERT INTO DishCategory VALUES (4, 9 )
INSERT INTO DishCategory VALUES (4, 11 )
INSERT INTO DishCategory VALUES (10, 12 )
INSERT INTO DishCategory VALUES (2, 13 )
INSERT INTO DishCategory VALUES (1, 14 )
INSERT INTO DishCategory VALUES (3, 15 )
INSERT INTO DishCategory VALUES (3, 16 )
INSERT INTO DishCategory VALUES (10, 17 )
INSERT INTO DishCategory VALUES (4, 18 )
INSERT INTO DishCategory VALUES (1, 19 )
INSERT INTO DishCategory VALUES (3, 20 )
INSERT INTO DishCategory VALUES (11, 21 )
INSERT INTO DishCategory VALUES (11, 22 )
INSERT INTO DishCategory VALUES (3, 23 )
INSERT INTO DishCategory VALUES (3, 24 )
INSERT INTO DishCategory VALUES (3, 25 )

INSERT INTO CsDish VALUES (1, 15 )
INSERT INTO CsDish VALUES (2, 20 )
INSERT INTO CsDish VALUES (3, 11 )
INSERT INTO CsDish VALUES (4, 15 )
INSERT INTO CsDish VALUES (5, 10 )
INSERT INTO CsDish VALUES (6, 10 )
INSERT INTO CsDish VALUES (7, 7 )
INSERT INTO CsDish VALUES (8, 13 )
INSERT INTO CsDish VALUES (9, 5 )
INSERT INTO CsDish VALUES (10, 7 )
INSERT INTO CsDish VALUES (11, 11.5 )
INSERT INTO CsDish VALUES (12, 10 )
INSERT INTO CsDish VALUES (13, 20 )
INSERT INTO CsDish VALUES (14, 5 )
INSERT INTO CsDish VALUES (15, 15 )
INSERT INTO CsDish VALUES (16, 5 )
INSERT INTO CsDish VALUES (17, 5 )
INSERT INTO CsDish VALUES (18, 3 )
INSERT INTO CsDish VALUES (19, 7.5 )
INSERT INTO CsDish VALUES (20, 10 )
INSERT INTO CsDish VALUES (21, 10 )
INSERT INTO CsDish VALUES (22, 11 )
INSERT INTO CsDish VALUES (23, 15 )
INSERT INTO CsDish VALUES (24, 8 )
INSERT INTO CsDish VALUES (25, 10 )

INSERT INTO Dish VALUES (1, 'Carbonara', 'Creamy spaghetti with ham', 1, 5 )
INSERT INTO Dish VALUES (2, 'Prime Sirloin Steak', 'Beautiful piece of steak with chips as', 2, 5 )
INSERT INTO Dish VALUES (3, 'Cheeseburger', 'Beatiful beef patties with cheese between two', 3, 2 )
INSERT INTO Dish VALUES (4, 'Chicken Rice', 'Chicken slices with a bowl of rice and soup', 4, 4 )
INSERT INTO Dish VALUES (5, 'Spicy Fried Chicken', 'Fried chicken that is marinated in dif', 3, 1 )
INSERT INTO Dish VALUES (6, 'Salmon Sashimi', 'Fresh slices of salmon with a drizzle of lemon juice', 8, 10 )
INSERT INTO Dish VALUES (7, 'Tom Yum Soup', 'Sweet and sour soup with seafood', 10, 6 )
INSERT INTO Dish VALUES (8, 'Kebabs', 'It is a deliciously cooked meat', 9, 7 )
INSERT INTO Dish VALUES (9, 'Pastitsio', 'Greek lasagna that has a mix or meat pasta bechamel and tomato sauce topped with melted cheese', 6, 9 )
INSERT INTO Dish VALUES (10, 'Pizza', 'Varieties of pizzas available', 7, 3 )
INSERT INTO Dish VALUES (11, 'Fajitas', 'Grilled meat with peppers and onion', 12, 13 )
INSERT INTO Dish VALUES (12, 'Key Lime Pie', 'Lime flavoured pie with meringue', 3, 11 )
INSERT INTO Dish VALUES (13, 'Hash Browns', 'Fried chopped potatoes', 3, 2 )
INSERT INTO Dish VALUES (14, 'Cobb Salad', 'Salad greens with meat and eggs', 3, 15 )
INSERT INTO Dish VALUES (15, 'Pot Roast', 'Slow cooked beef', 3, 5 )
INSERT INTO Dish VALUES (16, 'Pad krapow moo', 'Stir-fried basil and pork', 10, 12 )
INSERT INTO Dish VALUES (17, 'Menemen', 'Scrambled eggs with spices and onions and pepper', 9, 14 )
INSERT INTO Dish VALUES (18, 'Sweet Roll', 'Wheat bun with almond paste', 15, 8 )
INSERT INTO Dish VALUES (19, 'Som Tum', 'Spicy green papaya salad', 10, 15 )
INSERT INTO Dish VALUES (20, 'Warak Enab', 'Ground beef in brined grape leaves', 13, 13 )
INSERT INTO Dish VALUES (21, 'Cioppino', 'Seafood stew with tomatoes and wine', 1, 6 )
INSERT INTO Dish VALUES (22, 'Clam Chowder', 'Clam soup with potatoes and onions', 3, 5 )
INSERT INTO Dish VALUES (23, 'Chicken Makhani', 'Chicken with spiced tomato sauce', 11, 12 )
INSERT INTO Dish VALUES (24, 'Meatballs', 'Ground meat rolled into balls', 15, 7 )
INSERT INTO Dish VALUES (25, 'Chicken Bastilla', 'Chicken with spices in a pastry', 14, 13 )

----------------------------

Select * from Passenger
Select * from PassengerContact
Select * from EventType
Select * from Event
Select * from Eatery
Select * from Cuisine
Select * from Dish
Select * from FoodCategory
Select * from Reservation
Select * from EventSession
Select * from PassengerOrders
Select * from Ingredient
Select * from DishContains
Select * from Booking
Select * from DishCategory
Select * from CsDish

*/
/*
--Shahid
--1: What are the dishes with beef that passengers have ordered?
Select d.DishName, OrderQty as 'Number of dishes ordered' from PassengerOrders PO inner join Dish d on d.DishID = PO.DishID where
PO.DishID in (Select dc.dishid from dishcontains dc inner join ingredient i on i.IngredID = dc.IngredID where i.IngredName = 'Beef') 

--2: Are they any eateries and events on the same deck so people can enjoy a meal before or after an event happens?
select Count(Distinct EatyName) as 'Number of eateries', EatyLoc, EventName as 'Number of events' from eatery ea inner join event ev on ea.EatyLoc = ev.EventLoc 
inner join Booking b on b.EventID = ev.EventID where BookStatus = 'Pending' group by EatyLoc,eventname 

--3: What are the most popular food categories based on the total price spent on each category?
select FcName, sum(OrderPrice) as 'Total amount spent per category' from FoodCategory fc inner join DishCategory dc 
on fc.FcID = dc.FcID inner join dish d on d.DishID = dc.DishID inner join PassengerOrders po on po.DishID = d.dishid group by FcName order by sum(orderprice) desc 

--Jevan
--QUESTION 1 What is the revenue generated for each dish--
SELECT Dish.DishID, DishName, sum(OrderPrice * OrderQty) AS 'Revenue for each dish' FROM PassengerOrders
INNER JOIN Dish ON PassengerOrders.DishID = Dish.DishID
GROUP BY Dish.DishID, DishName 
--QUESTION 2 What is the total amount spent by a passenger on a cruise ship--
SELECT Passenger.PgrID, PgrName, sum(NoOfAdultTicket * AdultSalesPrice + NoOfChildTicket * ChildSalesPrice + OrderPrice*OrderQty) AS 'Total Spent On Cruise Ship'FROM Passenger
INNER JOIN Booking ON Passenger.PgrID = Booking.PgrID
INNER JOIN PassengerOrders ON Passenger.PgrID = PassengerOrders.PgrID
GROUP BY Passenger.PgrID, PgrName
--QUESTION 3What is the dishes that have a higher than average price?--
SELECT Dish.DishID, DishName, Price FROM Dish 
INNER JOIN CSDish ON Dish.DishID = CSDish.DishID
WHERE CSDish.Price> (SELECT AVG(price) FROM CSDish)
*/

/*

select eventname as 'Event name', eventdatetime as 'Event Date Time', sum(NoOfChildTicket) as 'Total Number of Tickets' from Event e inner join eventsession es on es.EventID = e.EventID inner join 
booking b on b.SessionNo = es.SessionNo group by eventname, eventdatetime

select dishname as 'Dish Name', dishdescr as 'Dish Description', price as 'Price' from dish d inner join csdish cd on cd.dishid = d.dishid where
d.dishid not in (select d.dishid from dish d inner join passengerorders po on po.DishID = d.DishID where orderqty >0)

select fcname, count(distinct eatyid) as 'Num eateries' from foodcategory fc inner join DishCategory dc on 
dc.FcID = fc.FcID inner join dish d on d.DishID = dc.DishID group by fcname

*/