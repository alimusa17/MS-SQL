  SELECT [ContinentCode],
         [CurrencyCode],
  	     COUNT(*)
      AS [CurrencyUsage]
    FROM [Countries]
GROUP BY [ContinentCode], [CurrencyCode]
  HAVING COUNT(*) > 1