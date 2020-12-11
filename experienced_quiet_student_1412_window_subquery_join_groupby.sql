/*
A "quite" student is the one who took at least one exam and didn't score neither the high score nor the low score.

Write an SQL query to report the students (student_id, student_name) being "quiet" in ALL exams.

Don't return the student who has never taken any exam. Return the result table ordered by student_id.

The query result format is in the following example.

 

Student table:
+-------------+---------------+
| student_id  | student_name  |
+-------------+---------------+
| 1           | Daniel        |
| 2           | Jade          |
| 3           | Stella        |
| 4           | Jonathan      |
| 5           | Will          |
+-------------+---------------+

Exam table:
+------------+--------------+-----------+
| exam_id    | student_id   | score     |
+------------+--------------+-----------+
| 10         |     1        |    70     |
| 10         |     2        |    80     |
| 10         |     3        |    90     |
| 20         |     1        |    80     |
| 30         |     1        |    70     |
| 30         |     3        |    80     |
| 30         |     4        |    90     |
| 40         |     1        |    60     |
| 40         |     2        |    70     |
| 40         |     4        |    80     |
+------------+--------------+-----------+

Result table:
+-------------+---------------+
| student_id  | student_name  |
+-------------+---------------+
| 2           | Jade          |
+-------------+---------------+
*/

/* 
logic
1. take at least one exam
2. not in MAX score
3. not in MIN score
*/
WITH experienced_student AS (
    SELECT student_id 
    FROM Exam 
    GROUP BY student_id 
    HAVING COUNT(*) >=1)
    ,
    
    top_student AS (
    SELECT e.student_id 
    FROM Exam AS e, (SELECT exam_id, MAX(score) AS score FROM Exam 
                     GROUP BY exam_id ) AS t 
    WHERE e.exam_id = t.exam_id 
    AND e.score = t.score)
    ,
    
    bottom_student AS (
    SELECT e.student_id 
    FROM Exam AS e, (SELECT exam_id, MIN(score) AS score FROM Exam 
                     GROUP BY exam_id ) AS t 
    WHERE e.exam_id = t.exam_id 
    AND e.score = t.score)
                
SELECT student_id, student_name
FROM Student
WHERE student_id IN (SELECT student_id FROM experienced_student)
AND student_id NOT IN (SELECT student_id FROM top_student)
AND student_id NOT IN (SELECT student_id FROM bottom_student)
;

/*
WINDOW FUNCTION, RANK BY EACH EXAM ASC AND DESC
SUBSET IF RANK = 1
LEFT JOIN Student table, get student_id and student_name
*/

WITH highest_score AS (SELECT exam_id, student_id, RANK() OVER(PARTITION BY exam_id ORDER BY score DESC) AS rnk
                       FROM Exam)
,
lowest_score AS (SELECT exam_id, student_id, RANK() OVER(PARTITION BY exam_id ORDER BY score ASC) AS rnk
                 FROM Exam)
,
exclude_student AS (SELECT student_id
                    FROM highest_score
                    WHERE rnk = 1
                    
                    UNION
                    
                    SELECT student_id
                    FROM lowest_score
                    WHERE rnk = 1)
,
quiet_student AS (SELECT DISTINCT student_id
                  FROM Exam
                  WHERE student_id NOT IN (SELECT student_id FROM exclude_student))
                  
SELECT q.student_id, s.student_name
FROM quiet_student AS q LEFT JOIN Student AS s
ON q.student_id = s.student_id
ORDER BY q.student_id
;