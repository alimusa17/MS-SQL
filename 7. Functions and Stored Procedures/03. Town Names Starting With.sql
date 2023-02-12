CREATE OR ALTER PROCEDURE [usp_GetTownsStartingWith] (@townName VARCHAR(20))
              AS
		   BEGIN
		         SELECT [Name]
				   FROM [Towns]
				  WHERE SUBSTRING([Name], 1, LEN(@townName)) = @townName
		     END
EXEC [dbo].[usp_GetTownsStartingWith] 'dul'