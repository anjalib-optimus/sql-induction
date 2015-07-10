USE organisation;
--61 Create a function that takes input as year(integer) and returns a string that display 'leap year' & Non-leap year' 
CREATE FUNCTION LeapYear(@InputYear INT)
RETURNS VARCHAR(20)
AS
BEGIN
DECLARE @Output VARCHAR(20)
SET @Output= CASE WHEN ((@InputYear%100=0 AND @InputYear%400=0) OR @InputYear%4=0) THEN 'LEAP YEAR' ELSE 'NOT LEAP YEAR'
END
RETURN @Output
END;

BEGIN
PRINT dbo.LeapYear(1996);
END;

--62  Create a stored procedure that takes input as 'employeid' and return the complete information regarding; personnel information, department information & salary information.Note: the tables used will be Employee, Department, & Emp_Salary.

CREATE PROCEDURE Information(@Id INT)
AS
SELECT * FROM ((department INNER JOIN employee ON department.id=employee.depID) INNER JOIN EmployeeSalary ON employee.id=EmployeeSalary.Id) WHERE employee.ID=@Id
GO

EXEC Information @Id=11


--Create a sample procedure having exception handles in it.
CREATE PROCEDURE Try(@A INT,@B INT)
AS
BEGIN TRY
DECLARE @num INT, @msg varchar(200)
SET @num = @A/@B
PRINT 'This will execute'
END TRY
BEGIN CATCH
PRINT 'Error occured that is'
set @msg=(SELECT ERROR_MESSAGE())
print @msg;
END CATCH
GO 

EXEC Try @A=5,@B=0