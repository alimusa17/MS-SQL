--14. Find All Employees Except Marketing

SELECT [FirstName],
       [LastName]
  FROM [Employees]
 WHERE NOT [DepartmentID] = 4