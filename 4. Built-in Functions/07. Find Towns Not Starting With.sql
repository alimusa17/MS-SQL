--07. Find Towns Not Starting With

--Method 1

 SELECT *
    FROM [Towns]
   WHERE LEFT([Name], 1) NOT IN ('R', 'B', 'D')
ORDER BY [Name]

--Method 2

 SELECT *
    FROM [Towns]
   WHERE [Name] NOT LIKE '[!RBD]%'
ORDER BY [Name]