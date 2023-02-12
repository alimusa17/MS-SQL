CREATE PROCEDURE [usp_DeleteEmployeesFromDepartment] (@departmentId INT)
              AS
           BEGIN 		         
				 DECLARE @employeesToDelete TABLE ([Id] INT)
				 INSERT INTO @employeesToDelete
				             SELECT [EmployeeID]
							   FROM [Employees]
							  WHERE [DepartmentID] = @departmentId

							  ALTER TABLE [Departments]
							 ALTER COLUMN [ManagerID] INT NULL
				 DELETE
				   FROM [EmployeesProjects]
				  WHERE [EmployeeID] IN (
				                             SELECT [Id]
											   FROM @employeesToDelete
				                        )
                    UPDATE [Employees]
					   SET [ManagerID] = NULL
					 WHERE [ManagerID] IN (
					                         SELECT [Id]
											   FROM @employeesToDelete
					                      )	
										  
					UPDATE [Departments]
					   SET [ManagerID] = NULL
				     WHERE [ManagerID] IN (
					                         SELECT [Id]
											   FROM @employeesToDelete
					                      )	
					DELETE 
					  FROM [Employees]
					 WHERE [EmployeeID] IN (
					                         SELECT [Id]
											   FROM @employeesToDelete
					                      )	

					 DELETE 
					   FROM [Departments]
                      WHERE [DepartmentID] = @departmentId

					  SELECT
					         COUNT(*)
						  AS [Employees Count]
						FROM [Employees]
						  AS [e]
						JOIN [Departments]
						  AS [d]
						  ON [d].[DepartmentID] = [e].[DepartmentID]
					   WHERE [e].[DepartmentID] = @departmentId

           END

EXEC [dbo].[usp_DeleteEmployeesFromDepartment] 7