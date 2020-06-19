/* 
Mary is a teacher in a middle school and she has a table seat storing students' names and their corresponding seat ids.

The column id is continuous increment.
 

Mary wants to change seats for the adjacent students.
 

Can you write a SQL query to output the result for Mary?
 

+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Abbot   |
|    2    | Doris   |
|    3    | Emerson |
|    4    | Green   |
|    5    | Jeames  |
+---------+---------+
For the sample input, the output is:
 

+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Doris   |
|    2    | Abbot   |
|    3    | Green   |
|    4    | Emerson |
|    5    | Jeames  |
+---------+---------+
Note:
If the number of students is odd, there is no need to change the last one's seat.
*/

/* Logic
select odd number rows
union
select even number rows
*/

# EVEN CASE
SELECT s1.id -1 AS id, s1.student
FROM seat s1
WHERE s1.id % 2 = 0

UNION

# ODD CASE
SELECT s2.id + 1 AS id, s2.student
FROM seat s2
WHERE s2.id % 2 = 1 AND s2.id != (SELECT MAX(id) FROM seat)

UNION

# ODD MAX CASE
SELECT s3.id AS id, s3.student
FROM seat s3
WHERE s3.id % 2 = 1 AND s3.id = (SELECT MAX(id) FROM seat)

# ORDER RESULTS
ORDER BY id ASC;
