CREATE PROCEDURE [usp_DeleteEmployeesFromDepartment] (@departmentId INT)
              AS
           BEGIN 		         
				 DECLARE @employeesToDelete TABLE ([Id] INT)
				 INSERT INTO @employeesToDelete
				             SELECT [EmployeeID]
							   FROM [Employees]
							  WHERE [DepartmentID] = @departmentId
				 DELETE
				   FROM [EmployeesProjects]
				  WHERE [EmployeeID] IN (
				                             SELECT *
											   FROM @employeesToDelete
				                        )
                    UPDATE [Employees]
					   SET [ManagerID] = NULL
					 WHERE [ManagerID] IN (
					                         SELECT *
											   FROM @employeesToDelete
					                      )										                     
					DELETE 
					  FROM [Employees]
					 WHERE [DepartmentID] = @departmentId

					 DELETE 
					   FROM [Departments]
                      WHERE [DepartmentID] = @departmentId

           END

EXEC [dbo].[usp_DeleteEmployeesFromDepartment] 7