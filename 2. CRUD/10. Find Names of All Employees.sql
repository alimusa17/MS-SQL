--10. Find Names of All Employees

 SELECT CONCAT([FirstName], ' ', [MiddleName], ' ', [LastName])
    AS [Full name]
  FROM [Employees]
 WHERE [Salary] IN (25000, 14000, 12500, 23600)