--14 Car Rental Database

CREATE TABLE [Categories] 
(
		    Id INT PRIMARY KEY, --IDENTITY,
		    CategoryName VARCHAR(50) NOT NULL,
			DailyRate DECIMAL (10,2) NOT NULL,
			WeeklyRate DECIMAL (10,2) NOT NULL,
			MonthlyRate DECIMAL (10,2) NOT NULL,
			WeekendRate DECIMAL (10,2) NOT NULL
)
INSERT INTO Categories(Id, CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
	 VALUES
		   (1, 'FisrtCategory', 2.7, 7.7, 27.7, 1.7),
		   (2, 'SecondCategory', 2.5, 5.5, 25.5, 1.5),
		   (3, 'ThirdCategory', 2.3, 5.3, 23.23, 1.3)

CREATE TABLE [Cars]
(
		    Id INT PRIMARY KEY,
			PlateNumber NVARCHAR(10) UNIQUE NOT NULL,
			Manufacturer NVARCHAR(20) NOT NULL,
			Model NVARCHAR(10) NOT NULL,
			CarYear DATE NOT NULL,
			CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
			Doors INT NOT NULL,
			Picture VARBINARY(MAX),
			Condition NVARCHAR(20),
			Available BIT NOT NULL
)
INSERT INTO Cars(Id, PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
	 VALUES
		   (1, 'CC0424CK', 'VW', 'Polo', '1994', 1, 4, NULL, NULL, 1),
		   (2, 'CC6042CC', 'KIA', 'Sorento', '2008', 2, 4, NULL, NULL, 1),
		   (3, 'CC4976CK', 'OPEL', 'Zafira', '2001', 3, 4, NULL, NULL, 0)

CREATE TABLE [Employees]
(
		    Id INT PRIMARY KEY,
		    FirstName NVARCHAR(50) NOT NULL,
		    LastName NVARCHAR(50) NOT NULL,
		    Title NVARCHAR(20),
		    Notes NVARCHAR(MAX)
)
INSERT INTO Employees(Id, FirstName, LastName, Title, Notes)
	 VALUES
	       (1, 'Gosho', 'Goshov', NULL, NULL),
		   (2, 'Pesho', 'Peshov', NULL, NULL),
		   (3, 'Tosho', 'Toshev', NULL, NULL)

CREATE TABLE [Customers]
(
		    Id INT PRIMARY KEY,
			DriverLicenseNumber INT UNIQUE NOT NULL,
			FullName NVARCHAR(50) NOT NULL,
			[Adress] NVARCHAR(50),
			City NVARCHAR(20),
			ZIPCode INT,
			Notes NVARCHAR(MAX)
)
INSERT INTO Customers(Id, DriverLicenseNumber, FullName, [Adress], City, ZIPCode, Notes)
	 VALUES
	       (1, '1234567', 'Gosho', NULL, NULL, NULL, NULL),
		   (2, '7777777', 'Pesho', NULL, NULL, NULL, NULL),
		   (3, '17171717', 'Tosho', NULL, NULL, NULL, NULL)

CREATE TABLE [RentalOrders]
(
			Id INT PRIMARY KEY,
			EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
			CustomerId INT FOREIGN KEY REFERENCES Customers(Id),
			CarId INT FOREIGN KEY REFERENCES Cars(Id),
			TankLevel INT NOT NULL,
			KilometrageStart INT NOT NULL,
			KilometrageEnd INT NOT NULL,
			TotalKilometrage INT NOT NULL,
			StartDate DATETIME2,
			EndDate DATETIME2,
			TotalDays INT NOT NULL,
			RateApplied DECIMAL(10,2),
			TaxRate DECIMAL(10,2),
			OrderStatus NVARCHAR(50),
			Notes NVARCHAR(MAX)
)
INSERT INTO RentalOrders(Id, EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays,    RateApplied, TaxRate, OrderStatus, Notes)
	 VALUES
	       (1, 1, 1, 1, 50, 0, 170, 117000, '2020-05-10', '2020-05-15', 5, NULL, NULL, NULL, NULL),
	       (2, 2, 2, 2, 60, 0, 270, 270000, '2021-11-15', '2021-11-21', 6, NULL, NULL, NULL, NULL),
	       (3, 3, 3, 3, 70, 0, 770, 170000, '2022-08-31', '2022-09-01', 1, NULL, NULL, NULL, NULL)