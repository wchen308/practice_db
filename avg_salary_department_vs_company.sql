/*
Table: salary
| id | employee_id | amount | pay_date   |
|----|-------------|--------|------------|
| 1  | 1           | 9000   | 2017-03-31 |
| 2  | 2           | 6000   | 2017-03-31 |
| 3  | 3           | 10000  | 2017-03-31 |
| 4  | 1           | 7000   | 2017-02-28 |
| 5  | 2           | 6000   | 2017-02-28 |
| 6  | 3           | 8000   | 2017-02-28 |
 

The employee_id column refers to the employee_id in the following table employee.
 

| employee_id | department_id |
|-------------|---------------|
| 1           | 1             |
| 2           | 2             |
| 3           | 2             |
 

So for the sample data above, the result is:
 

| pay_month | department_id | comparison  |
|-----------|---------------|-------------|
| 2017-03   | 1             | higher      |
| 2017-03   | 2             | lower       |
| 2017-02   | 1             | same        |
| 2017-02   | 2             | same        |
*/

WITH company_avg AS(SELECT SUBSTRING(pay_date, 1, 7) AS pay_month, AVG(amount) AS avg_salary 
                    FROM salary GROUP BY pay_month)
,
department_avg AS (SELECT SUBSTRING(s.pay_date, 1, 7) AS pay_month, e.department_id, AVG(amount) AS avg_salary
                   FROM salary AS s LEFT JOIN employee AS e
                   ON s.employee_id = e.employee_id
                   GROUP BY pay_month, e.department_id)

SELECT d.pay_month, d.department_id, CASE 
    WHEN d.avg_salary > c.avg_salary THEN 'higher'
    WHEN d.avg_salary < c.avg_salary THEN 'lower'
    ELSE 'same'
    END AS comparison
FROM department_avg AS d LEFT JOIN company_avg AS c
ON d.pay_month = c.pay_month
;