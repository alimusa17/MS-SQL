SELECT 
DISTINCT[DepartmentID],
        [Salary]
     AS [ThirdHighestRank]
   FROM (
            SELECT [DepartmentID],
                   [Salary],	
            	   DENSE_RANK() OVER(PARTITION BY [DepartmentID] ORDER BY[Salary] DESC)
                AS [SalaryRank]
              FROM [Employees]
        )
     AS [SalaryRankingQuery]
  WHERE [SalaryRank] = 3