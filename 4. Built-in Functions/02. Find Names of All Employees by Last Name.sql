--02. Find Names of All Employees by Last Name

--Method 1

SELECT [FirstName],
       [LastName]
  FROM [Employees]
 WHERE CHARINDEX ('ei', [LastName]) > 0

--Method 2

SELECT [FirstName],
	   [LastName]
  FROM [Employees]
 WHERE [LastName] LIKE '%ei%'