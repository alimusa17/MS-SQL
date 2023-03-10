  SELECT
TOP (50)
         [e].[EmployeeID],
  CONCAT([e].[FirstName], ' ', [e].[LastName])
	  AS [EmployeeName],
  CONCAT([ee].[FirstName], ' ', [ee].[LastName])
	  AS [ManagerName],
         [d].[Name] 
	  AS [DepartmentName]
    FROM [Employees]
      AS [e]
    JOIN [Employees]
      AS [ee]
      ON [e].[ManagerID] = [ee].[EmployeeID]
    JOIN [Departments]
      AS [d]
      ON [d].[DepartmentID] = [e].[DepartmentID]
ORDER BY [e].[EmployeeID]