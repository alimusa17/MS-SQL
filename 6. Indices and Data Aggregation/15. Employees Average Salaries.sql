SELECT *
  INTO [MoreThan30000]
  FROM [Employees]
 WHERE [Salary] > 30000

DELETE
  FROM [MoreThan30000]
 WHERE [ManagerID] = 42

UPDATE
       [MoreThan30000]
   SET [Salary] += 5000
 WHERE [DepartmentID] = 1

  SELECT
         [DepartmentID],
         AVG([Salary])
	  AS [AverageSalary]
    FROM [MoreThan30000]
GROUP BY [DepartmentID]