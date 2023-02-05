--7 Create Table People

CREATE TABLE [People]
(
	         [Id] INT PRIMARY KEY IDENTITY,
	         [Name] NVARCHAR(200) NOT NULL,
	         [Picture] VARBINARY(MAX),
	         CHECK (DATALENGTH([Picture]) <= 2000000),
	         [Height] DECIMAL(3,2),
	         [Weight] DECIMAL(5,2),
	         [Gender] CHAR(1) NOT NULL,
	         CHECK ([Gender] = 'm' OR [GENDER] = 'f'),
	         [Birthdate] DATE NOT NULL,
	         [Biography] NVARCHAR(MAX)
)

 INSERT INTO 
             [People] 
			 [Name], 
			 [Height], 
			 [Weight], 
			 [Gender], 
			 [Birthdate]
	  VALUES
             ('Pesho', 1.77, 75.2, 'm', '1998-05-25'),
             ('Gosho', NULL, NULL, 'm', '1977-11-05'),
             ('Maria', 1.65, 45.2, 'f', '1998-06-27'),
             ('Viki', NULL, NULL, 'f', '1986-02-02'),
             ('Ivan', 1.69, 77.8, 'm', '1999-03-03')