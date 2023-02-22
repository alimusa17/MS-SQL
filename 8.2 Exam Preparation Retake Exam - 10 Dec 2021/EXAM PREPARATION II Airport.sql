CREATE DATABASE Airport

GO 

USE Airport

GO

-- Section 1. DDL (30 pts)

CREATE TABLE Passengers
(
             Id INT PRIMARY KEY IDENTITY,
			 FullName VARCHAR(100) UNIQUE NOT NULL,
			 Email VARCHAR(50) NOT NULL
)

CREATE TABLE Pilots
(
             Id INT PRIMARY KEY IDENTITY,
			 FirstName VARCHAR(30) UNIQUE NOT NULL,
			 LastName VARCHAR(30) UNIQUE NOT NULL,
			 Age TINYINT NOT NULL CHECK(Age >= 21 AND Age <= 62),
			 Rating FLOAT NULL CHECK(Rating >= 0.0 AND Rating <= 10.0)
)

CREATE TABLE AircraftTypes
(
             Id INT PRIMARY KEY IDENTITY,
			 TypeName VARCHAR(30) UNIQUE NOT NULL
)

CREATE TABLE Aircraft
(
             Id INT PRIMARY KEY IDENTITY,
			 Manufacturer VARCHAR(25) UNIQUE NOT NULL,
			 Model VARCHAR(30) UNIQUE NOT NULL,
			 [Year] INT NOT NULL,
			 FlightHours INT NULL,
			 Condition CHAR NOT NULL,
			 TypeId INT FOREIGN KEY REFERENCES AircraftTypes(Id) NOT NULL
)

CREATE TABLE PilotsAircraft
(
             AircraftId INT FOREIGN KEY REFERENCES Aircraft(Id) NOT NULL,
			 PilotId INT FOREIGN KEY REFERENCES Pilots(Id) NOT NULL,
			 PRIMARY KEY (AircraftId, PilotId)
)

CREATE TABLE Airports
(
             Id INT PRIMARY KEY IDENTITY,
			 AirportName VARCHAR(70) UNIQUE NOT NULL,
			 Country VARCHAR(100) UNIQUE NOT NULL
)

CREATE TABLE FlightDestinations
(
             Id INT PRIMARY KEY IDENTITY,
			 AirportId INT FOREIGN KEY REFERENCES Airports(Id) NOT NULL,
			 [Start] DATETIME NOT NULL,
			 AircraftId INT FOREIGN KEY REFERENCES Aircraft(Id) NOT NULL,
			 PassengerId INT FOREIGN KEY REFERENCES Passengers(Id) NOT NULL,
			 TicketPrice DECIMAL(18,2) DEFAULT 15 NOT NULL
)

-- Section 2. DML (10 pts)

-- 2. Insert

INSERT INTO Passengers (FullName, Email)
     SELECT 
	        CONCAT(FirstName, ' ', LastName),
			CONCAT(FirstName, LastName, '@gmail.com')
	   FROM Pilots
	  WHERE Id > 5 AND Id <= 15

-- 3. Update

UPDATE Aircraft SET Condition = 'A'
 WHERE 
       (Condition = 'B' OR Condition = 'C')
	   AND (FlightHours IS NULL OR FlightHours <= 100)
	   AND [Year] >= 2013

-- 4. Delete

DELETE 
  FROM Passengers
 WHERE LEN(FullName) <= 10

-- Section 3. Querying (40 pts)

-- 5. Aircraft

  SELECT 
         Manufacturer,
  	     Model,
  	     FlightHours,
  	     Condition 
    FROM Aircraft
ORDER BY FlightHours DESC

-- 6. Pilots and Aircraft

  SELECT 
         p.FirstName,
		 p.LastName,
		 a.Manufacturer,
		 a.Model,
		 a.FlightHours
	FROM Pilots
	  AS p
	JOIN PilotsAircraft
	  AS pa
	  ON p.Id = pa.PilotId
	JOIN Aircraft
	  AS a
	  ON a.Id = pa.AircraftId
   WHERE a.FlightHours IS NOT NULL AND FlightHours < 304
ORDER BY a.FlightHours DESC,
         p.FirstName

-- 7. TOP 20 Flight Destinations

  SELECT 
 TOP(20)
         fd.Id
	  AS DestinationId,
	     fd.[Start],
		 p.FullName,
		 a.AirportName,
		 fd.TicketPrice
	FROM FlightDestinations
	  AS fd
	JOIN Passengers
	  AS p
	  ON fd.PassengerId = p.Id
	JOIN Airports
	  AS a
	  ON fd.AirportId = a.Id
   WHERE DATEPART(DAY, fd.Start) % 2 = 0
ORDER BY fd.TicketPrice DESC,
         a.AirportName

-- 8. Number of Flights for Each Aircraft 

  SELECT 
         a.Id
	  AS AircraftId,
	     a.Manufacturer,
		 a.FlightHours,
	     COUNT(fd.Id)
	  AS FlightDestinationCount,
	     ROUND(AVG(fd.TicketPrice), 2)
	  AS AvgPrice
	FROM Aircraft 
	  AS a 
	JOIN FlightDestinations
	  AS fd
	  ON a.Id = fd.AircraftId
GROUP BY a.Id,
         a.Manufacturer,
		 a.FlightHours
  HAVING COUNT(fd.Id) >= 2
ORDER BY 4 DESC,
         1

-- 9. Regular Passengers

  SELECT
         p.FullName,
		 COUNT(a.Id)
	  AS CountOfAircraft,
	     SUM(fd.TicketPrice)
	  AS TotalPayed
	FROM Passengers
	  AS p
	JOIN FlightDestinations
	  AS fd
	  ON p.Id = fd.PassengerId
	JOIN Aircraft 
	  AS a 
	  ON fd.AircraftId = a.Id
   WHERE SUBSTRING(p.FullName, 2, 1) = 'a'
GROUP BY p.Id,
         p.FullName
  HAVING COUNT(a.Id) > 1
ORDER BY p.FullName

-- 10. Full Info for Flight Destinations 

  SELECT 
         ap.AirportName,
		 fd.[Start]
	  AS DayTime,
	     fd.TicketPrice
		 p.FullName,
		 a.Manufacturer,
		 a.Model
	FROM FlightDestinations
	  AS fd
	JOIN Passengers
	  AS p
	  ON fd.PassengerId = p.Id
	JOIN Aircraft
	  AS a
	  ON fd.AircraftId = a.Id
	JOIN Airports
	  AS ap
	  ON fd.AirportId = ap.Id
   WHERE CAST(fd.[Start] AS TIME) BETWEEN '06:00' AND '20:00'
         AND fd.TicketPrice > 2500
ORDER BY a.Model

-- Section 4. Programmability (20 pts)

-- 11. Find all Destinations by Email Address

CREATE FUNCTION udf_FlightDestinationsByEmail (@email VARCHAR(50))
RETURN INT AS
 BEGIN
       DECLARE @destinationsCount INT
	   SET @destinationsCount = (
	                             SELECT
								        COUNT(fd.Id)
								   FROM Passengers
								     AS p
								   JOIN FlightDestinations
								     AS fd
									 ON p.Id = fd.PassengerId
								  WHERE p.Email = @email
							   GROUP BY p.Id
	                            )
		 IF @destinationsCount IS NULL
		SET @destinationsCount = 0

		RETURN @destinationsCount
		END

--ALTERNATIVE

CREATE FUNCTION udf_FlightDestinationsByEmail (@email VARCHAR(50))
RETURN INT AS
 BEGIN
       RETURN ISNULL(
	                 (SELECT 
					        COUNT(fd.Id)
				 		    FROM Passengers
					        AS p
						    JOIN FlightDestinations
						    AS fd
						    ON p.Id = fd.PassengerId
						    WHERE p.Email = @email
						    GROUP BY p.Id), 0
	                )
		END

-- 12. Full Info for Airports

CREATE PROCEDURE usp_SearchByAirportName (@airportName VARCHAR(70))
AS
BEGIN
SELECT a.AirportName,
       p.FullName,
  CASE
       WHEN fd.TicketPrice <= 400 THEN 'Low'
	   WHEN fd.TicketPrice BETWEEN 401 AND 1500 THEN 'Medium'
	   ELSE 'High'
	   END
	AS LevelOfTicketPrice
	   ac.Manufacturer,
	   ac.Condition,
	   t.TypeName
  FROM Airports
    AS a
  JOIN FlightDestinations
    AS fd
	ON a.Id = fd.AirportId
  JOIN Passengers
    AS p
	ON fd.PassengerId = p.Id
  JOIN Aircraft
    AS ac
	ON fd.AircraftId = ac.Id
  JOIN AircraftTypes
    AS t
	ON ac.TypeId = t.Id
 WHERE a.AirportName = @airportName
ORDER BY ac.Manufacturer,
         p.FullName
END