/*
Write an SQL query that reports the most experienced employees in each project. In case of a tie, report all employees with the maximum number of experience years.

The query result format is in the following example:

Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+

Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 3                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+

Result table:
+-------------+---------------+
| project_id  | employee_id   |
+-------------+---------------+
| 1           | 1             |
| 1           | 3             |
| 2           | 1             |
+-------------+---------------+
Both employees with id 1 and 3 have the most experience among the employees of the first project. For the second project, the employee with id 1 has the most experience.
*/

# Write your MySQL query statement below
/* logic
for each project, group by, select max(experience_yaers)
if same, list both
*/

SELECT pr.project_id, pr.employee_id
FROM Project AS pr, Employee AS em, (SELECT p.project_id, MAX(e.experience_years) AS max_years
                                     FROM Project AS p, Employee AS e
                                     WHERE p.employee_id = e.employee_id
                                     GROUP BY p.project_id) AS ex
WHERE pr.project_id = ex.project_id
AND pr.employee_id = em.employee_id
AND em.experience_years = ex.max_years;