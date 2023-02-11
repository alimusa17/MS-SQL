CREATE PROCEDURE [usp_GetTownsStartingWith] @townName VARCHAR(50)
              AS
		   BEGIN
		         SELECT [Name]
				   FROM [Towns]
				  WHERE [Name] LIKE 'b%'
		     END
EXEC [dbo].[usp_GetTownsStartingWith] 'b'