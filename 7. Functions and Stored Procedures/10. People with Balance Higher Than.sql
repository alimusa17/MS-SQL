CREATE PROCEDURE [usp_GetHoldersWithBalanceHigherThan] (@Number DECIMAL(18,4))
              AS
           BEGIN
		         SELECT 
				        [FirstName],
						[LastName]
				   FROM [AccountHolders]
				     AS [h]
                   JOIN [Accounts]
				     AS [a]
				     ON [h].[Id] = [a].[AccountHolderId]
			   GROUP BY [FirstName],
						[LastName]
				 HAVING SUM([a].[Balance]) > @Number
			   ORDER BY [FirstName],
						[LastName]
		     END

EXEC [dbo].[usp_GetHoldersWithBalanceHigherThan]