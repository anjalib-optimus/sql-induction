--Write queries to create database
CREATE DATABASE organisation;
USE organisation;

--Write queries to create "Employee" table with Employee Id is numeric, first, Last names are string of maximum up to 50 characters, Sex is one character, Active status is Boolean.
CREATE TABLE employee (
	ID INT NOT NULL UNIQUE,
	firstName varchar(50) NOT NULL,
	lastName varchar(50) NOT NULL,
	sex varchar(1) NOT NULL,
	activeStatus bit NOT NULL DEFAULT 1,
	age INT CHECK(age>=18),
	salary DECIMAL(10,2),
	PRIMARY KEY (ID,firstName) 
	);

--Create a table of Designation and drop it
CREATE TABLE designation(
	DID INT NOT NULL,
	desig VARCHAR(20) NOT NULL,
	PRIMARY KEY(DID)); 
DROP TABLE designation;

--Create a unique index on the first name and last name  and a full text index on first name of the employee table
CREATE INDEX index1 ON employee(firstName,lastName);

--Alter the table employees. Modify designation column to take integer value and create a new table for designation which is related to employee by designation id
CREATE TABLE designation(
	DID INT NOT NULL,
	desig VARCHAR(10) NOT NULL,
	PRIMARY KEY(DID));
ALTER TABLE employee ADD desigID INT REFERENCES designation(DID);
ALTER TABLE employee ALTER COLUMN desigID INT NOT NULL; 

--Insert values into tables designation and employee
INSERT INTO designation VALUES(1,'ceo');
INSERT INTO designation VALUES(2,'manager');
INSERT INTO designation VALUES(3,'senior');
INSERT INTO designation VALUES(4,'set');
INSERT INTO employee VALUES(1,'ANJLALI','BHAWNANI','F',1,21,25000.00,4);
INSERT INTO employee VALUES(11,'ABHA','MISHRA','F',0,27,65000.00,2);
INSERT INTO employee VALUES(231,'ADIL','','M',1,31,26000.00,3);
INSERT INTO employee VALUES(56,'A','B','M',1,41,50000.00,2);

--Find Employee salary in a particular range using  In operator
SELECT ID,salary FROM employee WHERE salary IN (10000.00,250000.00,50000.00);

--Find Employee salary in a particular range using  Between operator
SELECT ID,salary FROM employee WHERE salary BETWEEN 24000.00 AND 34000.00;

--Display column using alias name from  Employee table
SELECT ID AS PID FROM employee WHERE lastName IS NULL;

--Display employee details using Join with employee slabs table.
SELECT employee.id,employee.firstName FROM employee INNER JOIN designation ON employee.desigID=designation.DID;

--Create a sample employee management system, having table Employee & Department. Employees are associated with some department, there are some employees exist which doesn't associated with any department yet. Display all the employees and their department information whether they are associated with some department or not.
CREATE TABLE department(
	id INT NOT NULL,
	dept VARCHAR(20),
	PRIMARY KEY(id)
	);
ALTER TABLE employee ADD depID INT REFERENCES department(id);
SELECT employee.id, employee.firstName, employee.depID FROM employee LEFT JOIN department ON employee.depID=department.id;

--Create a sample employee management system, having table Employee & Department. Employees are associated with some department, there are some employees exist which doesn't associated with any department yet. Display all the employees and their department information whether they are associated with some department or not.
SELECT employee.id, employee.firstName, employee.depID FROM employee RIGHT JOIN department ON employee.depID=department.id;

--Same case as above. Display all the employees and departments whether they are associated with each other or not.
SELECT employee.id, employee.firstName, employee.depID FROM employee FULL JOIN department ON employee.depID=department.id;

--Suppose a ERP system having multiple table for employees of different companies. Create tables for 3 companies such as "ABC", "LMN" & "XYZ" and display all the employees of all the companies.
CREATE TABLE employee1 (
	ID INT NOT NULL UNIQUE,
	firstName varchar(50) NOT NULL,
	lastName varchar(50) NOT NULL,
	sex varchar(1) NOT NULL,
	activeStatus bit NOT NULL DEFAULT 1,
	age INT CHECK(age>=18),
	salary DECIMAL(10,2),
	PRIMARY KEY (ID,firstName) 
	);
	
INSERT INTO employee1 VALUES(12,'ANJLALI','BHAWNANI','F',1,21,25000.00);
INSERT INTO employee1 VALUES(111,'ABHA','MISHRA','F',0,27,65000.00);
INSERT INTO employee1 VALUES(21,'ADIL','','M',1,31,26000.00);
INSERT INTO employee1 VALUES(6,'A','B','M',1,41,50000.00);
SELECT ID,firstName from employee UNION SELECT ID,firstName from employee1;


--Create a backup system where records are being saved in another table in different database. Write queries to insert data of "Employee" table "Employee_Backup" table in another database.
CREATE DATABASE back_up;
USE back_up;
CREATE TABLE employee_b (
	ID INT NOT NULL UNIQUE,
	firstName varchar(50) NOT NULL,
	lastName varchar(50) NOT NULL,
	sex varchar(1) NOT NULL,
	activeStatus bit NOT NULL DEFAULT 1,
	age INT CHECK(age>=18),
	salary DECIMAL(10,2),
	PRIMARY KEY (ID,firstName) 
	);
SELECT ID,firstName,lastName,sex,activeStatus,age,salary INTO employee_b from organisation.dbo.employee;

--increment the salary of all employee by 5000
USE organisation;
UPDATE employee SET salary=salary+5000;

--create a view with details of managers whose salary is more than 60000. Add a column date of joining in the employee table and display in view the joining date in the format specified in #1 of previous exercise
	ALTER TABLE employee ADD dateOfJoin DATE;
	CREATE VIEW managerView AS	
		SELECT * FROM employee WHERE desigID IN(
		 SELECT DID FROM designation WHERE desig='manager') AND salary>=60000;
	SELECT * FROM managerView;
	

--Get current date in the format specified in example -Mon  20th sep 10, 1:30 pm


--Count sum of a column in which one of the values is Null
SELECT SUM(ID) FROM employee WHERE depID IS NULL;

--get the details of the employee whose last name is null
SELECT * FROM employee WHERE lastName IS NULL;

--Calculate 12.75 % of salary as pf for all employees and display it in decimals with 2 digits after decimal point
SELECT CAST(ROUND(salary*12.75/100,2) AS NUMERIC(34,2)) AS pdf FROM employee;

