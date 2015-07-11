USE Department;
--first query
SELECT (CASE WHEN Emp_f_name IS NOT NULL THEN Emp_f_name ELSE '' END)+' '+
(CASE WHEN Emp_m_name IS NOT NULL THEN Emp_m_name ELSE '' END)+' '+
(CASE WHEN Emp_l_name IS NOT NULL THEN Emp_l_name ELSE '' END) AS Name,
Emp_DOB AS 'Date Of Birth' 
FROM t_emp WHERE CONVERT(VARCHAR(2),DATEPART(DAY, Emp_DOB))=CONVERT(VARCHAR(2),EOMONTH(Emp_DOB));

--second query
Select A.Emp_id,A.Full_Name,A.Increment,A.Previous_Salary,A.Current_Salary,
B.Total_Worked_Hours,B.Last_Worked_Activity,B.Hours_Worked_In_Last_Activity
FROM 
(SELECT E.EMP_ID,MAX(e.Emp_f_name+' '+e.Emp_m_name+' '+e.Emp_L_name ) AS Full_Name,
MAX(s.New_Salary) AS Current_Salary,
(SELECT MAX(t_salary.New_Salary) FROM t_salary WHERE t_salary.New_Salary NOT IN 
(SELECT MAX(t_salary.New_Salary) FROM t_salary)) AS Previous_Salary
,(MAX(s.New_Salary) -(SELECT MAX(t_salary.New_Salary)
 FROM t_salary WHERE t_salary.New_Salary NOT IN (SELECT MAX(t_salary.New_Salary) FROM t_salary))) AS Increment
FROM (t_emp e INNER JOIN t_salary s ON  e.Emp_Id= s.Emp_id) 
GROUP BY E.Emp_id)
AS a INNER JOIN 
(SELECT emp.Emp_Id,SUM(Atten_end_hrs) AS Total_Worked_Hours ,
(SELECT t_activity.Activity_description FROM
 t_atten_det INNER JOIN t_activity ON t_atten_det.Activity_id=t_activity.Activity_id
  WHERE Atten_start_datetime=MAX(ATT.Atten_start_datetime)) AS Last_Worked_Activity,
  (SELECT Atten_end_hrs FROM t_atten_det WHERE t_atten_det.Atten_start_datetime=MAX(ATT.Atten_start_datetime)) AS Hours_Worked_In_Last_Activity
FROM (t_atten_det att INNER JOIN t_emp emp ON att.Emp_id=emp.Emp_Id)
GROUP BY emp.Emp_Id) AS b ON A.Emp_Id=B.Emp_Id;