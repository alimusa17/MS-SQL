--06. Find Towns Starting With

--Method 1

 SELECT *
   FROM  [Towns]
   WHERE LEFT([Name], 1) IN ('M', 'K', 'B', 'E')
ORDER BY [Name]

--Method 2

  SELECT *
    FROM [Towns]
   WHERE [Name] LIKE '[MKBE]%'
ORDER BY [Name]