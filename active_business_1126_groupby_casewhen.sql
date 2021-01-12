/*
Write an SQL query to find all active businesses.

An active business is a business that has more than one event type with occurences greater than the average occurences of that event type among all businesses.

The query result format is in the following example:

Events table:
+-------------+------------+------------+
| business_id | event_type | occurences |
+-------------+------------+------------+
| 1           | reviews    | 7          |
| 3           | reviews    | 3          |
| 1           | ads        | 11         |
| 2           | ads        | 7          |
| 3           | ads        | 6          |
| 1           | page views | 3          |
| 2           | page views | 12         |
+-------------+------------+------------+

Result table:
+-------------+
| business_id |
+-------------+
| 1           |
+-------------+ 
*/

/* logic
filter out rows that are greater than avg
group by business id and count if more than 1...
*/

WITH avg_db AS (SELECT event_type, AVG(occurences) AS avg_occurences
                FROM Events
                GROUP BY event_type)
,
filtered_db AS (SELECT e.business_id
                FROM Events AS e LEFT JOIN avg_db AS a
                ON e.event_type = a.event_type
                WHERE e.occurences > a.avg_occurences)

SELECT business_id
FROM filtered_db
GROUP BY business_id
HAVING COUNT(business_id) > 1
;

/*
or use case when to calculate the success of each row
*/
WITH global_avg AS (
    SELECT event_type, AVG(occurences) AS average
    FROM Events
    GROUP BY event_type)
,
activeness_db AS (
    SELECT e.business_id, CASE WHEN e.occurences > a.average THEN 1 ELSE 0 END AS activeness
    FROM Events AS e JOIN global_avg AS a
    ON e.event_type = a.event_type)

SELECT business_id
FROM activeness_db
GROUP BY business_id
HAVING SUM(activeness) > 1
;