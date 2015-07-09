USE organisation;
--49(1) show top 5 highest paid employees 
SELECT * FROM (SELECT ID,firstName,salary,RANK() OVER (ORDER BY salary DESC) AS rnk FROM employee)AS pay WHERE rnk<=5;
--OR
SELECT TOP 5 * FROM employee ORDER BY salary DESC;


--49(2) show  top 5 alternate  highest paid employees
SELECT * FROM (SELECT ID,firstName,salary,RANK() OVER (ORDER BY salary DESC) AS rnk FROM employee)AS pay WHERE rnk<=10 AND rnk%2!=0;


--50 build a query using CTE 
WITH EmpCte(Id,Salary,Department) AS (SELECT employee.ID,salary,dept FROM employee,department WHERE employee.depID=department.id)
SELECT Department,SUM(Salary) FROM EmpCte  GROUP BY Department;


--51 use "with rollup" and "with cube " on employee salary column.
SELECT dept,desig,SUM(salary) AS SalarySum FROM ((employee INNER JOIN department ON employee.depID=department.id) INNER JOIN designation ON employee.desigID=designation.DID) GROUP BY dept,desig WITH ROLLUP;

SELECT dept,desig,SUM(salary) AS SalarySum FROM ((employee INNER JOIN department ON employee.depID=department.id) INNER JOIN designation ON employee.desigID=designation.DID) GROUP BY dept,desig WITH CUBE;


--52 select all those employees who are only freshers (<6 months exp)
SELECT * FROM employee EXCEPT (SELECT * FROM employee WHERE dateOfJoin<DATEADD(DAY,-180,GETDATE()));

--53 use corelated subquery to find out top 3 employees(order by empid asc)
SELECT TOP 3 * FROM employee E1 WHERE ID NOT IN (SELECT ID FROM employee E2 WHERE E2.ID>E1.ID);

--54 use Running Aggregate on employee salary column.
SELECT ID,salary,SUM(salary) OVER (PARTITION BY depId ORDER BY dateOfJoin) FROM employee;

--56 Create a cluster index on employee_id column in the employee table.
ALTER TABLE	employee DROP CONSTRAINT PK__employee__B8D62693C9EAA55D;
CREATE CLUSTERED INDEX IndexName on employee(ID);

--57 Create a non cluster index on department_id column in the employee table.
CREATE NONCLUSTERED INDEX IndexName1 on employee(depID);

--58 E.g. Suppose employee_salary table, having column basic, HR & DA and Gross salary. By default Gross salary is empty. Use trigger to update the gross salary column as (Basic+HRA+DA)*12, whenever records are entered in the employee_salary table.
CREATE TABLE EmployeeSalary(
	BasicSalary Decimal(20,2) NOT NULL,
	 HR Decimal(10,2) NOT NULL,
	 DA Decimal(10,2) NOT NULL,
	 GrossSalary Decimal(10,2),
	 Id INT REFERENCES employee(ID));

CREATE TRIGGER BasicTrigger ON EmployeeSalary FOR INSERT,UPDATE AS UPDATE EmployeeSalary SET GrossSalary=(BasicSalary+HR+DA)*12;

INSERT INTO EmployeeSalary(BasicSalary,HR,DA,Id) VALUES(2000,200,300,1);

SELECT * FROM EmployeeSalary;


--59 Create a procedure having a cursor which fetch complete list of employee and update any one field of the employee table. E.g. Suppose employee_salary table, having column basic, HR & DA and Gross salary. By default Gross salary is empty. Use cursors and update the gross salary column as (Basic+HRA+DA)*12
DROP TRIGGER BasicTrigger;

DECLARE @Basic Decimal(20,2)
DECLARE @Hr Decimal(20,2)
DECLARE @Da Decimal(20,2)
DECLARE @Id INT

DECLARE @MyCursor CURSOR
SET @MyCursor = CURSOR FAST_FORWARD
FOR
SELECT BasicSalary,HR,DA,Id FROM EmployeeSalary
OPEN @MyCursor
FETCH NEXT FROM @MyCursor
INTO @Basic,@Hr,@Da,@Id
WHILE @@FETCH_STATUS = 0
BEGIN
UPDATE EmployeeSalary SET GrossSalary=(BasicSalary+HR+DA)*12 WHERE Id=@Id
FETCH NEXT FROM @MyCursor
INTO @Basic,@Hr,@Da,@Id
END
CLOSE @MyCursor
DEALLOCATE @MyCursor 