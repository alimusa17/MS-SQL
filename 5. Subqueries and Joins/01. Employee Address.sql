   SELECT 
  TOP (5) [e].[EmployeeId],
          [e].[JobTitle],
	      [e].[AddressId],
	      [a].[AddressText]
     FROM [Employees]
       AS [e]
LEFT JOIN [Addresses]
       AS [a]
	   ON [e].[AddressID] = [a].[AddressID]
 ORDER BY [e].[AddressID]