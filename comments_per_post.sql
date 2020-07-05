/*
Write an SQL query to find number of comments per each post.

Result table should contain post_id and its corresponding number_of_comments, and must be sorted by post_id in ascending order.

Submissions may contain duplicate comments. You should count the number of unique comments per post.

Submissions may contain duplicate posts. You should treat them as one post.

The query result format is in the following example:

Submissions table:
+---------+------------+
| sub_id  | parent_id  |
+---------+------------+
| 1       | Null       |
| 2       | Null       |
| 1       | Null       |
| 12      | Null       |
| 3       | 1          |
| 5       | 2          |
| 3       | 1          |
| 4       | 1          |
| 9       | 1          |
| 10      | 2          |
| 6       | 7          |
+---------+------------+

Result table:
+---------+--------------------+
| post_id | number_of_comments |
+---------+--------------------+
| 1       | 3                  |
| 2       | 2                  |
| 12      | 0                  |
+---------+--------------------+

The post with id 1 has three comments in the table with id 3, 4 and 9. The comment with id 3 is repeated in the table, we counted it only once.
The post with id 2 has two comments in the table with id 5 and 10.
The post with id 12 has no comments in the table.
The comment with id 6 is a comment on a deleted post with id 7 so we ignored it.
*/

/* 
join table: post_id, comment_id
post_id: IN sub_id WHERE parent_id IS NULL
number of comment: unique (parent_id, sub_id)
*/

SELECT post_id, COUNT(DISTINCT post_id, comment_id) AS number_of_comments
FROM (SELECT DISTINCT sub_id AS post_id FROM Submissions WHERE parent_id IS NULL) t1 LEFT JOIN (SELECT parent_id, sub_id AS comment_id FROM Submissions) t2
ON t2.parent_id = t1.post_id
GROUP BY post_id
ORDER BY post_id