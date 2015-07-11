--Create database
CREATE DATABASE Department;
USE Department;
GO
--Create table t_emp
CREATE TABLE t_emp(
	Emp_id INT NOT NULL IDENTITY(1001,2),
	Emp_Code VARCHAR(30),
	Emp_f_name VARCHAR(20) NOT NULL,
	Emp_m_name VARCHAR(20),
	Emp_l_name VARCHAR(20),
	Emp_DOB DATE,
	Emp_DOJ DATE NOT NULL CHECK (DATEDIFF(YEAR,GETDATE(),Emp_DOJ)<18),
	PRIMARY KEY (Emp_id),
	);
DROP TABLE t_emp;
GO
--Insert values into table t_emp
INSERT INTO t_emp(Emp_Code,Emp_f_name,Emp_l_name,Emp_DOB,Emp_DOJ) VALUES('OPT20110105','Manmohan','Singh',CONVERT(DATE,'10-02-1983',105),CONVERT(DATE,'25-05-2010',105));
INSERT INTO t_emp(Emp_Code,Emp_f_name,Emp_m_name,Emp_l_name,Emp_DOB,Emp_DOJ) VALUES('OPT20100915','Alfred','Joseph','Lawrence',CONVERT(DATE,'28-02-1988',105),CONVERT(DATE,'25-05-2010',105));
GO

--Create table t_activity
CREATE TABLE t_activity(
	Activity_id INT NOT NULL PRIMARY KEY,
	Activity_description VARCHAR(30));
GO
--Insert values into table t_activity
INSERT INTO t_activity VALUES(1,'Code Analysis');
INSERT INTO t_activity VALUES(2,'Lunch');
INSERT INTO t_activity VALUES(3,'Coding');
INSERT INTO t_activity VALUES(4,'Knowledge Transition');
INSERT INTO t_activity VALUES(5,'Database');

--Create table t_atten_det
CREATE TABLE t_atten_det(
	Atten_id INT IDENTITY(1001,1) NOT NULL,
	Emp_id INT REFERENCES t_emp(Emp_id),
	Activity_id INT REFERENCES t_activity(Activity_id),
	Atten_start_datetime DATETIME,
	Atten_end_hrs INT
	);
GO
--Insert values into table t_atten_det
INSERT INTO t_atten_det(Emp_id,Activity_id,Atten_start_datetime,Atten_end_hrs) VALUES(1001,5,CONVERT(DATETIME,'2/13/2011 10:00:00',101),2);
INSERT INTO t_atten_det(Emp_id,Activity_id,Atten_start_datetime,Atten_end_hrs) VALUES(1001,1,CONVERT(DATETIME,'1/14/2011 10:00:00',101),3);
INSERT INTO t_atten_det(Emp_id,Activity_id,Atten_start_datetime,Atten_end_hrs) VALUES(1001,3,CONVERT(DATETIME,'1/14/2011 13:00:00',101),5);
INSERT INTO t_atten_det(Emp_id,Activity_id,Atten_start_datetime,Atten_end_hrs) VALUES(1003,5,CONVERT(DATETIME,'2/16/2011 10:00:00',101),8);
INSERT INTO t_atten_det(Emp_id,Activity_id,Atten_start_datetime,Atten_end_hrs) VALUES(1003,5,CONVERT(DATETIME,'2/17/2011 10:00:00',101),8);
INSERT INTO t_atten_det(Emp_id,Activity_id,Atten_start_datetime,Atten_end_hrs) VALUES(1003,5,CONVERT(DATETIME,'2/19/2011 10:00:00',101),7);
GO

--Create table t_salary
CREATE TABLE t_salary(
	Salary_id INT,
	Emp_id INT REFERENCES t_emp(Emp_id),
	Changed_Date DATE,
	New_Salary DECIMAL(10,2));
GO
INSERT INTO t_salary VALUES(1001,1003,CONVERT(DATE,'2/16/2011',101),20000.00);
INSERT INTO t_salary VALUES(1002,1003,CONVERT(DATE,'1/05/2011',101),25000.00);
INSERT INTO t_salary VALUES(1003,1001,CONVERT(DATE,'2/16/2011',101),26000.00);
GO