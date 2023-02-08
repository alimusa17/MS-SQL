--1. Find Names of All Employees by First Name

--Method 1

SELECT [FirstName],
	   [LastName]
  FROM [Employees]
 WHERE LEFT([FirstName], 2) = 'Sa'

--Method 2

SELECT [FirstName],
	   [LastName]
  FROM [Employees]
 WHERE [FirstName] LIKE 'Sa%'