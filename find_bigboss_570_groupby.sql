/*
The Employee table holds all employees including their managers. 
Every employee has an Id, and there is also a column for the manager Id.

+------+----------+-----------+----------+
|Id    |Name 	  |Department |ManagerId |
+------+----------+-----------+----------+
|101   |John 	  |A 	      |null      |
|102   |Dan 	  |A 	      |101       |
|103   |James 	  |A 	      |101       |
|104   |Amy 	  |A 	      |101       |
|105   |Anne 	  |A 	      |101       |
|106   |Ron 	  |B 	      |101       |
+------+----------+-----------+----------+
Given the Employee table, 
write a SQL query that finds out managers with at least 5 direct report. 
For the above table, your SQL query should return:

+-------+
| Name  |
+-------+
| John  |
+-------+
*/

/*
logic
count ManagerId >= 5
look for Id and return Name
*/

WITH big_boss AS (SELECT ManagerId
                  FROM Employee
                  GROUP BY ManagerID
                  HAVING COUNT(*) >= 5)
                  
SELECT Name
FROM Employee
WHERE Id IN (SELECT ManagerId FROM big_boss)
;
