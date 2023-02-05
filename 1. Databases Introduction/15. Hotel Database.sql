--15 Hotel Database

CREATE TABLE [Employees]
(
	        Id INT PRIMARY KEY,
	        FirstName NVARCHAR(100) NOT NULL,
	        LastName NVARCHAR(100) NOT NULL,
	        Title NVARCHAR(50),
	        Notes NVARCHAR(MAX)
)

INSERT INTO Employees (Id, FirstName, LastName, Title, Notes)
   	 VALUES 
		   (1, 'Gosho', 'Gogov', 'a', 'c'),
		   (2, 'Petar', 'Petrov', 'b', 'b'),
		   (3, 'Ivan', 'Ivanov', 'c', 'a')

CREATE TABLE [Customers]
(
	        AccountNumber INT PRIMARY KEY,
	        FirstName NVARCHAR(100) NOT NULL,
	        LastName NVARCHAR(100) NOT NULL,
	        PhoneNumber CHAR(10) NOT NULL,
	        EmergencyName NVARCHAR(100) NOT NULL,
	        EmergencyNumber CHAR(10) NOT NULL,
	        Notes NVARCHAR(MAX)
)

INSERT INTO Customers(AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber)
   	 VALUES 
		   (1, 'Gosho', 'Gogov', 0123456789, 'a', 123),
		   (2, 'Petar', 'Petrov', 0987654321, 'b', 234),
		   (3, 'Ivan', 'Ivanov', 0111222333, 'c', 345)
		  
CREATE TABLE [RoomStatus]
(
	        RoomStatus NVARCHAR(10) NOT NULL,
	        Notes NVARCHAR(MAX)
)

INSERT INTO RoomStatus(RoomStatus, Notes)
	 VALUES
		   ('Good', 'a'),
		   ('Good', 'a+'),
		   ('Good', 'a++')

CREATE TABLE [RoomTypes]
(
	RoomType NVARCHAR(10) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO RoomTypes(RoomType, Notes)
	 VALUES
		   ('Good', 'a'),
		   ('Good', 'a+'),
		   ('Good', 'a++')

CREATE TABLE [BedTypes]
(
	        BedType NVARCHAR(10) NOT NULL,
	        Notes NVARCHAR(MAX)
)

INSERT INTO BedTypes(BedType, Notes)
     VALUES
		   ('Good', 'a'),
		   ('Good', 'a+'),
		   ('Good', 'a++')

CREATE TABLE [Rooms]
(
	        RoomNumber INT PRIMARY KEY,
	        RoomType NVARCHAR(10) NOT NULL,
	        BedType NVARCHAR(10) NOT NULL,
	        Rate TINYINT,
	        RoomStatus NVARCHAR(10) NOT NULL,
	        Notes NVARCHAR(MAX)
)

INSERT INTO Rooms(RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes)
	 VALUES
		   (1, 'a', 'a', '10', 'a+', 'ok'),
		   (2, 'b', 'b', '10', 'a+', 'ok'),
		   (3, 'c', 'c', '10', 'a++', 'ok')

CREATE TABLE [Payments]
(
	        Id INT PRIMARY KEY,
	        EmployeeId INT NOT NULL,
	        PaymentDate DATETIME2,
	        AccountNumber INT,
	        FirstDateOccupied DATETIME2,
	        LastDateOccupied DATETIME2,
	        TotalDays TINYINT,
	        AmountCharged DECIMAL(15,2),
	        TaxRate INT,
	        TaxAmount DECIMAL(15,2),
	        PaymentTotal DECIMAL(15,2),
	        Notes NVARCHAR(MAX)
)

INSERT INTO Payments(Id, EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes)
	VALUES
		 (1, 1, '2023-01-17', 1, '2023-01-17', '2023-01-20', '3', '100.00', 5, '10.00', '110.00', 'a'),
		 (2, 2, '2023-01-20', 2, '2023-01-20', '2023-01-26', '6', '200.00', 7, '20.00', '220.00', 'a'),
		 (3, 3, '2023-01-15', 3, '2023-01-15', '2023-01-24', '9', '300.00', 10, '30.00', '330.00', 'a')

CREATE TABLE [Occupancies]
(
	        Id INT PRIMARY KEY,
	        EmployeeId INT NOT NULL,
	        DateOccupied DATETIME2,
	        AccountNumber INT,
	        RoomNumber INT,
	        RateApplied INT,
	        PhoneCharged DECIMAL,
	        Notes NVARCHAR(MAX)
)

INSERT INTO Occupancies(Id, EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharged, Notes)
	VALUES
		  (1, 1, '2023-01-17', 1, 10, 10, '100', 'a+'),
		  (2, 2, '2023-01-20', 2, 17, 10, '99', 'a+'),
		  (3, 3, '2023-01-15', 3, 27, 10, '90', 'a+')