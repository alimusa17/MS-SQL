--04. Find All Employees Except Engineers

--Method 1

SELECT [FirstName],
       [LastName]
  FROM [Employees]
 WHERE CHARINDEX ('engineer', [JobTitle]) = 0

--Method 2

SELECT [FirstName],
	   [LastName]
  FROM [Employees]
 WHERE [JobTitle] NOT LIKE '%engineer%'