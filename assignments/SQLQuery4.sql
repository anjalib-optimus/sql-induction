USE FIRM;
--Create required table format
SELECT t_user_master.User_Name,t_product_master.Product_Name,
SUM(CASE WHEN Transaction_Type='order' THEN Transaction_Amount ELSE 0.0 END) AS Ordered_Quantity,
SUM(CASE WHEN Transaction_Type='Payment' THEN Transaction_Amount ELSE 0.0 END) AS Amount_Paid,
MAX(Transaction_Date) AS Last_Transaction_Date,
SUM(CASE WHEN Transaction_Type='order' THEN Transaction_Amount ELSE 0.0 END)*Cost_Per_Item-SUM(CASE WHEN Transaction_Type='Payment' THEN Transaction_Amount ELSE 0.0 END) AS Balance
FROM ((t_product_master INNER JOIN t_transaction ON t_product_master.Product_ID=t_transaction.Product_ID) INNER JOIN t_user_master ON t_user_master.User_ID=t_transaction.User_ID) GROUP BY User_Name,Product_Name,Cost_Per_Item;

