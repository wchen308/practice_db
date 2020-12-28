/*
Write a SQL query to find the highest grade with its corresponding course for each student. In case of a tie, you should find the course with the smallest course_id. The output must be sorted by increasing student_id.

The query result format is in the following example:

Enrollments table:
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 2          | 2         | 95    |
| 2          | 3         | 95    |
| 1          | 1         | 90    |
| 1          | 2         | 99    |
| 3          | 1         | 80    |
| 3          | 2         | 75    |
| 3          | 3         | 82    |
+------------+-----------+-------+

Result table:
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 1          | 2         | 99    |
| 2          | 2         | 95    |
| 3          | 3         | 82    |
+------------+-----------+-------+f
*/

/* highest grade for each student
find max grade by each student
find corresponding course
*/

SELECT t1.student_id, MIN(course_id) AS course_id, max_grade AS grade
FROM (SELECT student_id, MAX(grade) as max_grade
      FROM Enrollments
      GROUP BY student_id) AS t1, Enrollments AS t2
WHERE t1.student_id = t2.student_id
AND t1.max_grade = t2.grade
GROUP BY t1.student_id, max_grade
ORDER BY t1.student_id
;

/* window function
group by student_id
rank grade
output course_id, grade
*/

WITH ranked_db AS (
    SELECT student_id, course_id, grade, ROW_NUMBER() OVER(PARTITION BY student_id ORDER BY grade DESC, course_id) AS rnk
    FROM Enrollments)
                   
SELECT student_id, course_id, grade
FROM ranked_db
WHERE rnk = 1
ORDER BY student_id
;
