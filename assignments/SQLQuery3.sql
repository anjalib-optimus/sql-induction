--Create database
CREATE DATABASE FIRM;
USE FIRM;
GO
--Create table t_product_master
CREATE TABLE t_product_master(
	Product_ID VARCHAR(4) NOT NULL,
	Product_Name VARCHAR(30) NOT NULL,
	Cost_Per_Item DECIMAL(10,2),
	PRIMARY KEY (Product_ID));
GO
--Insert values into table t_product_master
INSERT INTO t_product_master VALUES('P1','PEN',10.0);
INSERT INTO t_product_master VALUES('P2','Scale',15.0);
INSERT INTO t_product_master VALUES('P3','NoteBook',25.0);
GO
--Create table t_user_master
CREATE TABLE t_user_master(
	User_ID VARCHAR(4) NOT NULL,
	User_Name VARCHAR(40) NOT NULL,
	PRIMARY KEY(User_ID));
GO
--Insert values into table t_transaction
INSERT INTO t_user_master VALUES('U1','Alfred Lawrence');
INSERT INTO t_user_master VALUES('U2','William Paul');
INSERT INTO t_user_master VALUES('U3','Edward Fillip');
GO
--Create table t_transaction
CREATE TABLE t_transaction(
	User_ID VARCHAR(4) NOT NULL REFERENCES t_user_master(User_ID),
	Product_ID VARCHAR(4) NOT NULL REFERENCES t_product_master(Product_ID),
	Transaction_Date DATE,
	Transaction_Type VARCHAR(30),
	Transaction_Amount DECIMAL(20,2) NOT NULL);
GO
--Insert into table t_transaction
INSERT INTO t_transaction VALUES('U1','P1',CONVERT(DATE,'25-10-2010',105),'Order',150.0);
INSERT INTO t_transaction VALUES('U1','P1',CONVERT(DATE,'20-11-2010',105),'Payment',750.0);
INSERT INTO t_transaction VALUES('U1','P1',CONVERT(DATE,'20-11-2010',105),'Order',200.0);
INSERT INTO t_transaction VALUES('U1','P3',CONVERT(DATE,'25-11-2010',105),'Order',50.0);
INSERT INTO t_transaction VALUES('U3','P2',CONVERT(DATE,'26-11-2010',105),'Order',100.0);
INSERT INTO t_transaction VALUES('U2','P1',CONVERT(DATE,'15-12-2010',105),'Order',75.0);
INSERT INTO t_transaction VALUES('U3','P2',CONVERT(DATE,'15-01-2011',105),'Payment',250.0);
GO
