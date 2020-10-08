/*
Write an SQL query to recommend pages to the user with user_id = 1 using the pages that your friends liked. It should not recommend pages you already liked.

Return result table in any order without duplicates.

The query result format is in the following example:

Friendship table:
+----------+----------+
| user1_id | user2_id |
+----------+----------+
| 1        | 2        |
| 1        | 3        |
| 1        | 4        |
| 2        | 3        |
| 2        | 4        |
| 2        | 5        |
| 6        | 1        |
+----------+----------+
 
Likes table:
+---------+---------+
| user_id | page_id |
+---------+---------+
| 1       | 88      |
| 2       | 23      |
| 3       | 24      |
| 4       | 56      |
| 5       | 11      |
| 6       | 33      |
| 2       | 77      |
| 3       | 77      |
| 6       | 88      |
+---------+---------+

Result table:
+------------------+
| recommended_page |
+------------------+
| 23               |
| 24               |
| 56               |
| 33               |
| 77               |
+------------------+

*/

/* logic
find friend id of user1
return pages IN friend like NOT IN user1 like
*/
WITH Friend AS (
    SELECT user2_id AS frd_id
    FROM Friendship
    WHERE user1_id = 1
    
    UNION ALL
    
    SELECT user1_id AS frd_id
    FROM Friendship
    WHERE user2_id = 1)

SELECT DISTINCT page_id AS recommended_page
FROM Likes
WHERE user_id IN (SELECT frd_id FROM Friend)
AND page_id NOT IN (SELECT page_id FROM Likes WHERE user_id = 1)
;
