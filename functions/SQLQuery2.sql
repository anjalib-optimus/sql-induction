--List the employee list whose salary is greater than average employee salary
SELECT ID, firstName from employee where salary>(SELECT AVG(salary) FROM employee);

--List all the departments and respective employee count in it. Use Employee and department table.
insert into department values(1,'a');
insert into department values(2,'b');
insert into department values(3,'c');
insert into department values(4,'d');
select * from employee;
UPDATE employee SET depID=1 where desigID=4;
UPDATE employee SET depID=2 where desigID=2;
UPDATE employee SET depID=3 where desigID=3;
UPDATE employee SET depID=4 where desigID=1;
SELECT dept,COUNT(employee.ID) FROM employee,department WHERE employee.depID=department.id GROUP BY dept;

--List the employee list whose salary is lesser than highest employee salary.
SELECT * FROM employee WHERE salary<(SELECT MAX(salary) FROM employee);

--List the employee list whose salary is lesser than lowest employee salary.
SELECT * FROM employee WHERE salary<(SELECT MIN(salary) FROM employee);

--Display sum of all the employees salary.
SELECT SUM(salary) FROM employee;

--List all the departments and respective employee count in it. Use Employee and department table.
SELECT dept,COUNT(employee.ID) FROM employee,department WHERE employee.depID=department.id GROUP BY dept;

--List all the customers have a total order of less than 2000. Use Order table having OrderId, orderDate, order, customername.
CREATE TABLE customers(
	orderID INT NOT NULL,
	orderDate DATE,
	orderAmt DECIMAL(10,2),
	customerName VARCHAR(30),
	PRIMARY KEY(orderID)
	);
INSERT INTO customers VALUES(1,'DEC 12,1993',200.00,'ANUJ');
INSERT INTO customers VALUES(2,'DEC 12,1993',1200.00,'ANUJ');
INSERT INTO customers VALUES(3,'DEC 12,1993',1200.00,'ANUJ');
INSERT INTO customers VALUES(4,'DEC 12,1993',200.00,'ANJU');
SELECT customerName FROM customers GROUP BY customerName HAVING SUM(orderAmt)<2000;

--select the content of the "LastName" and "FirstName" columns from employee table, and convert the "LastName" column to uppercase
SELECT firstName,UPPER(lastName) from employee;

--select the content of the "LastName" and "FirstName" columns from employee table, and convert the "LastName" column to lowercase
SELECT firstName,LOWER(lastName) from employee;

--select the length of the values in the "Names" column in employee table.
SELECT firstName,LEN(firstName) FROM employee;

--Display the employee name and the salary rounded to the nearest integer from the employee_salary table.
SELECT firstName,CAST(ROUND(salary,0) AS INTEGER) FROM employee;

--Display list of all the employee with the current date information.
SELECT firstName FROM employee WHERE dateOfJoin=(SELECT GETDATE());

--Display the employee and salaries per today's date (with today's date displayed in the following format "DD-MM-YYYY"). Display multiple combination of day, month and year.
SELECT firstName,salary,FORMAT(SYSDATETIME(), 'Mon d yyyy h:mmtt') FROM employee;
SELECT firstName,salary, FORMAT(SYSDATETIME(), 'MM/dd/yy') AS [MM/DD/YY] FROM employee;
SELECT firstName,salary,FORMAT(SYSDATETIME(), 'MM/dd/yyyy') AS [MM/DD/YYYY] FROM employee;


--use cast() to change datatype of empid column to Varchar(10)
SELECT CAST(ID as varchar(10)) FROM employee;
