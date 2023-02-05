--13 Movies Database

CREATE TABLE [Directors]
(
		  Id INT PRIMARY KEY,
		  DirectorName NVARCHAR(50) NOT NULL,
		  Notes NVARCHAR(MAX)
)

INSERT INTO Directors(Id, DirectorName, Notes)
	 VALUES
	      (1, 'Cristopher Nolan', 'British'),
		  (2, 'Charlie Brooker', 'British'),
		  (3, 'David Fincher', 'American'),
		  (4, 'Quentin Tarantino', 'American'),
		  (5, 'Martin Scorsese', 'American')

CREATE TABLE [Genres]
(
			Id INT PRIMARY KEY,
			GenreName NVARCHAR(50) NOT NULL,
			Notes NVARCHAR(MAX)
)

INSERT INTO Genres(Id, GenreName, Notes)
	 VALUES
		  (1, 'Action', 'Sci-Fi'),
		  (2, 'Drama', 'Mystery'),
		  (3, 'Drama', 'Crime'),
		  (4, 'Crime', 'Thriller'),
		  (5, 'Crime', 'Drama')

CREATE TABLE [Categories]
(
			Id INT PRIMARY KEY,
			CategoryName NVARCHAR(50) NOT NULL,
			Notes NVARCHAR(MAX)
)

INSERT INTO Categories(Id, CategoryName, Notes)
	 VALUES
	       (1, 'a++', NULL),
		   (2, 'a++', NULL),
		   (3, 'a+', NULL),
		   (4, 'a', NULL),
		   (5, 'a', NULL)

CREATE TABLE [Movies]
(
			Id INT PRIMARY KEY,
			Title NVARCHAR(50),
			DirectorId INT,
			CopyrightYear CHAR(4) NOT NULL,
			[Length] DECIMAL(15,2) NOT NULL,
			GenreId INT,
			CategoryId INT,
			Rating DECIMAL(15,2),
			Notes NVARCHAR(MAX)
)

INSERT INTO Movies(Id, Title, DirectorId, CopyrightYear, [Length], GenreId, CategoryId, Rating, Notes)
	 VALUES
		   (1, 'TENET', 1, '2020', 150, 1, 1, 10, NULL),
		   (2, 'Black Mirror', 2, '2011', 60, 2, 2, 10, NULL),
		   (3, 'House of Cards', 3, '2013', 60, 3, 3, 10, NULL),
		   (4, 'Reservoir Dogs', 4, '1992', 120, 4, 4, 9, NULL),
		   (5, 'The Irishman', 5, '2019', 180, 5, 5, 9, NULL)