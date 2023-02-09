--Method 1

  SELECT [CountryCode],  
         COUNT([MountainId])
      AS [MountainRanges]
    FROM [MountainsCountries] 
   WHERE [CountryCode] IN (   
                             SELECT [CountryCode]
                             FROM [Countries]
                            WHERE [CountryName] IN ('United States', 'Russia', 'Bulgaria')
                          )
GROUP BY [CountryCode] 

--Method 2

  SELECT 
         [c].[CountryCode],
  	     COUNT([m].[MountainRange])
      AS [MountainRanges]
    FROM [Countries]
      AS [c]
    JOIN [MountainsCountries]
      AS [mc]
  	  ON [c].[CountryCode] = [mc].[CountryCode]
    JOIN [Mountains]
      AS [m]
  	  ON [mc].[MountainId] = [m].[Id]
   WHERE [c].[CountryName] IN ('United States', 'Russia', 'Bulgaria')
GROUP BY [c].[CountryCode]