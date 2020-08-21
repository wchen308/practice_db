/*
Table request_accepted

+--------------+-------------+------------+
| requester_id | accepter_id | accept_date|
|--------------|-------------|------------|
| 1            | 2           | 2016_06-03 |
| 1            | 3           | 2016-06-08 |
| 2            | 3           | 2016-06-08 |
| 3            | 4           | 2016-06-09 |
+--------------+-------------+------------+
This table holds the data of friend acceptance, while requester_id and accepter_id both are the id of a person.
 

Write a query to find the the people who has most friends and the most friends number under the following rules:

It is guaranteed there is only 1 people having the most friends.
The friend request could only been accepted once, which mean there is no multiple records with the same requester_id and accepter_id value.
For the sample data above, the result is:

Result table:
+------+------+
| id   | num  |
|------|------|
| 3    | 3    |
+------+------+
*/

# Write your MySQL query statement below
/* logic
count requester_id by requester_id
+
count accepter_id by accepter_id
union all then count
union will eliminate duplicate
*/

SELECT user_id as id, COUNT(user_id) AS num
FROM (SELECT requester_id AS user_id FROM request_accepted 
      UNION ALL
      SELECT accepter_id AS user_id FROM request_accepted) AS total_table 
GROUP BY user_id
ORDER BY num DESC
LIMIT 1
;