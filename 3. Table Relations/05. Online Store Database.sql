--05. Online Store Database

CREATE TABLE [ItemTypes]
(
			 [ItemTypeID] INT PRIMARY KEY IDENTITY,
			 [Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE [Items]
(
			 [ItemID] INT PRIMARY KEY IDENTITY,
			 [Name] NVARCHAR(50) NOT NULL,
			 [ItemTypeID] INT FOREIGN KEY REFERENCES [ItemTypes] ([ItemTypeID]) NOT NULL
)

CREATE TABLE [Cities]
(
			 [CityID] INT PRIMARY KEY IDENTITY,
			 [Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE [Customers]
(
			 [CustomerID] INT PRIMARY KEY IDENTITY,
			 [Name] NVARCHAR(50) NOT NULL,
			 [Birthday] DATETIME2 NOT NULL,
			 [CityID] INT FOREIGN KEY REFERENCES [Cities] ([CityID]) NOT NULL
)

CREATE TABLE [Orders]
(
			 [OrderID] INT PRIMARY KEY IDENTITY,
			 [CustomerID] INT FOREIGN KEY REFERENCES [Customers] ([CustomerID]) NOT NULL
)

CREATE TABLE [OrderItems]
(
			 [OrderID] INT FOREIGN KEY REFERENCES [Orders] ([OrderID]),
			 [ItemID] INT FOREIGN KEY REFERENCES [Items] ([ItemID]),
			 PRIMARY KEY ([OrderID], [ItemID])
)