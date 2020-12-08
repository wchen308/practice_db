/*
Write an SQL query to report the difference between number of apples and oranges sold each day.

Return the result table ordered by sale_date in format ('YYYY-MM-DD').

The query result format is in the following example:

 

Sales table:
+------------+------------+-------------+
| sale_date  | fruit      | sold_num    |
+------------+------------+-------------+
| 2020-05-01 | apples     | 10          |
| 2020-05-01 | oranges    | 8           |
| 2020-05-02 | apples     | 15          |
| 2020-05-02 | oranges    | 15          |
| 2020-05-03 | apples     | 20          |
| 2020-05-03 | oranges    | 0           |
| 2020-05-04 | apples     | 15          |
| 2020-05-04 | oranges    | 16          |
+------------+------------+-------------+

Result table:
+------------+--------------+
| sale_date  | diff         |
+------------+--------------+
| 2020-05-01 | 2            |
| 2020-05-02 | 0            |
| 2020-05-03 | 20           |
| 2020-05-04 | -1           |
+------------+--------------+
*/

/*
logic
for each day, use fruit = apples - fruit = oranges

SQL:
subset apples data, merge oranges data
*/

WITH apple_data AS (SELECT sale_date, sold_num
                    FROM Sales
                    WHERE fruit = 'apples')
,
orange_data AS (SELECT sale_date, sold_num
                FROM Sales
                WHERE fruit = 'oranges')
                
SELECT a.sale_date, a.sold_num - o.sold_num AS diff
FROM apple_data AS a LEFT JOIN orange_data AS o
ON a.sale_date = o.sale_date
ORDER BY a.sale_date
;
