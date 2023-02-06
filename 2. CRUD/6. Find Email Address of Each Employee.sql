--6. Find Email Address of Each Employee

SELECT CONCAT([FirstName], '.', [LastName], '@', 'softuni.bg')
    AS [Full Email Address]
  FROM Employees