-- Section 1. DDL (30 pts)
CREATE DATABASE Zoo
 
GO
 
USE Zoo
 
GO

CREATE TABLE Owners
(
             Id INT PRIMARY KEY IDENTITY,
			 [Name] VARCHAR(50) NOT NULL,
			 PhoneNumber VARCHAR(15) NOT NULL,
			 [Address] VARCHAR(50),
)

CREATE TABLE AnimalTypes
(
             Id INT PRIMARY KEY IDENTITY,
			 AnimalType VARCHAR(30) NOT NULL
)

CREATE TABLE Cages
(
             Id INT PRIMARY KEY IDENTITY,
			 AnimalTypeId INT FOREIGN KEY REFERENCES AnimalTypes (Id) NOT NULL
)

CREATE TABLE Animals
(
             Id INT PRIMARY KEY IDENTITY,
			 [Name] VARCHAR(30) NOT NULL,
			 BirthDate Date NOT NULL,
			 OwnerId INT FOREIGN KEY REFERENCES Owners (Id),
			 AnimalTypeId INT FOREIGN KEY REFERENCES AnimalTypes (Id) NOT NULL
)

CREATE TABLE AnimalsCages
(
             CageId INT FOREIGN KEY REFERENCES Cages (Id),
			 AnimalId INT FOREIGN KEY REFERENCES Animals (Id),
			 PRIMARY KEY (CageId, AnimalId)
)

CREATE TABLE VolunteersDepartments
(
             Id INT PRIMARY KEY IDENTITY,
			 DepartmentName VARCHAR(30) NOT NULL
)

CREATE TABLE Volunteers
(
			 Id INT PRIMARY KEY IDENTITY,
			 [Name] VARCHAR(50) NOT NULL,
			 PhoneNumber VARCHAR(15) NOT NULL,
			 [Address] VARCHAR(50),
			 AnimalId INT FOREIGN KEY REFERENCES Animals (Id),
			 DepartmentId INT FOREIGN KEY REFERENCES VolunteersDepartments (Id) NOT NULL
)

-- Section 2. DML (10 pts)

-- 2. Insert

INSERT INTO Animals
            ([Name], BirthDate, OwnerId, AnimalTypeId)
     VALUES 
	        ('Giraffe', '2018-09-21', 21, 1),
			('Harpy Eagle', '2015-04-17', 15, 3),
			('Hamadryas Baboon', '2017-11-02', NULL, 1),
			('Tuatara', '2021-06-30', 2, 4)
						
INSERT INTO Volunteers
            ([Name], PhoneNumber, [Address], AnimalId, DepartmentId)
	 VALUES 
	        ('Anita Kostova', '0896365412', 'Sofia, 5 Rosa str.', 15, 1),
			('Dimitur Stoev', '0877564223', NULL, 42, 4),
			('Kalina Evtimova', '0896321112', 'Silistra, 21 Breza str.', 9, 7),
			('Stoyan Tomov', '0898564100', 'Montana, 1 Bor str.', 18, 8),
			('Boryana Mileva', '0888112233', NULL, 31, 5)
			
-- 3. Update 


UPDATE Animals
   SET OwnerId = 4
WHERE OwnerId IS NULL

-- 4. DELETE

SELECT *
  FROM VolunteersDepartments
 WHERE DepartmentName = 'Education program assistant'

SELECT * 
  FROM Volunteers
 WHERE DepartmentId = 2
 
DELETE 
  FROM Volunteers
 WHERE DepartmentId = (
                       SELECT Id
					     FROM VolunteersDepartments
						WHERE DepartmentName = 'Education program assistant'
                      )

DELETE 
  FROM VolunteersDepartments
 WHERE DepartmentName = 'Education program assistant'

 -- Section 3. Querying (40 pts)

-- 5. Volunteers

  SELECT [Name],
         PhoneNumber,
		 [Address],
		 AnimalId,
		 DepartmentId
    FROM Volunteers
ORDER BY [Name],
         AnimalId,
		 DepartmentId

-- 6. Animals Data

    SELECT a.[Name],
	       [at].AnimalType,
		   FORMAT(a.BirthDate, 'dd.MM.yyy')
      FROM Animals
        AS a
INNER JOIN AnimalTypes
        AS [at]
		ON a.AnimalTypeId = [at].Id
  ORDER BY a.[Name]

-- 7. Owners and their Animals

   SELECT
   TOP(5) o.[Name]
       AS [Owner],
	      COUNT(a.Id)
	   AS CountOfAnimals
     FROM Owners
       AS o
LEFT JOIN Animals
       AS a
	   ON o.Id = a.OwnerId
 GROUP BY o.[Name]
 ORDER BY CountOfAnimals DESC,
          [Owner]

-- 8. Owners, Animals and Cages

    SELECT CONCAT(o.[Name], '-', a.[Name])
	    AS OwnersAnimals,
		   o.PhoneNumber,
		   ac.CageId
      FROM Owners
        AS o
INNER JOIN Animals
        AS a
		ON o.Id = a.OwnerId
INNER JOIN AnimalTypes
        AS [at]
		ON a.AnimalTypeId = [at].[Id]
INNER JOIN AnimalsCages
        AS ac
		ON a.Id = ac.AnimalId
	 WHERE [at].AnimalType = 'Mammals'
  ORDER BY o.[Name],
           a.[Name] DESC

-- 9. Volunteers in Sofia

    SELECT v.[Name],
	       v.PhoneNumber,
		   LTRIM(REPLACE(REPLACE(v.[Address], 'Sofia', ''), ',', ''))
        AS [Address]
      FROM Volunteers
        AS v
INNER JOIN VolunteersDepartments
        AS vd 
		ON v.DepartmentId = vd.Id
	 WHERE vd.DepartmentName = 'Education program assistant' AND 
	       v.[Address] LIKE '%Sofia%'
  ORDER BY v.[Name]

-- 10. Animals for Adoption

    SELECT a.[Name],
	       DATEPART(YEAR, a.BirthDate)
        AS BirthYear,
		   [at].AnimalType
      FROM Animals
	    AS a
INNER JOIN AnimalTypes
        AS [at]
		ON a.AnimalTypeId = [at].Id
     WHERE OwnerId IS NULL AND 
	       DATEDIFF(YEAR, a.BirthDate, '01/01/2022') < 5 AND
		   [at].AnimalType <> 'Birds'
  ORDER BY a.[Name]

-- Section 4. Programmability (20 pts)

-- 11. All Volunteers in a Department

CREATE FUNCTION udf_GetVolunteersCountFromADepartment (@VolunteersDepartment VARCHAR(30)) 
    RETURNS INT 
	         AS
		  BEGIN
		       DECLARE @departmentId INT;
				   SET @departmentId = (
				                        SELECT Id
										  FROM VolunteersDepartments
										 WHERE DepartmentName = @VolunteersDepartment
				                       )
			   DECLARE @departmentVolunteersCount INT;
				   SET @departmentVolunteersCount = (
				                                     SELECT COUNT(*)
				                                       FROM Volunteers
				                                      WHERE DepartmentId = @departmentId
				                                    )
				RETURN @departmentVolunteersCount
		        
		    END
GO

SELECT dbo.udf_GetVolunteersCountFromADepartment ('Education program assistant')
SELECT dbo.udf_GetVolunteersCountFromADepartment ('Guest engagement')
SELECT dbo.udf_GetVolunteersCountFromADepartment ('Zoo events')

-- ALTERNATIVE

CREATE FUNCTION udf_GetVolunteersCountFromADepartment (@VolunteersDepartment VARCHAR(30)) 
    RETURNS INT 
	      BEGIN
		 RETURN (
		            SELECT
				           COUNT(*)
				      FROM Volunteers
				        AS v
				 LEFT JOIN VolunteersDepartments
				        AS vd
						ON v.DepartmentId = vd.Id
					 WHERE vd.DepartmentName = @VolunteersDepartment
		        )
			END

-- 12. Animals with Owner or Not

CREATE PROCEDURE usp_AnimalsWithOwnersOrNot (@AnimalName VARCHAR(30)) 
              AS
		   BEGIN
		         SELECT a.[Name],
				        ISNULL(o.[Name], 'For adoption')
					 AS OwnersName
				   FROM	Animals	
				     AS a
			  LEFT JOIN Owners
			         AS o
					 ON a.OwnerId = o.Id
				  WHERE a.[Name] = @AnimalName
					                  
		     END 

GO 

EXEC usp_AnimalsWithOwnersOrNot 'Pumpkinseed Sunfish'
EXEC usp_AnimalsWithOwnersOrNot 'Hippo'
EXEC usp_AnimalsWithOwnersOrNot 'Brown bear'