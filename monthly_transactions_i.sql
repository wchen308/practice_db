/*
Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.

The query result format is in the following example:

Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 121  | US      | approved | 1000   | 2018-12-18 |
| 122  | US      | declined | 2000   | 2018-12-19 |
| 123  | US      | approved | 2000   | 2019-01-01 |
| 124  | DE      | approved | 2000   | 2019-01-07 |
+------+---------+----------+--------+------------+

Result table:
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+
*/

/* logic
group by month and country
count trans, approved trans, sum amount, sum approved amount
*/

WITH grouped_db AS (SELECT DATE_FORMAT(trans_date, '%Y-%m') as month, country, COUNT(*) AS trans_count, SUM(amount) AS trans_total_amount
                    FROM Transactions
                    GROUP BY month, country)
,
grouped_filtered_db AS (SELECT DATE_FORMAT(trans_date, '%Y-%m') as month, country, COUNT(*) AS approved_count, SUM(amount) AS approved_total_amount
                        FROM Transactions
                        WHERE state = 'approved'
                        GROUP BY month, country)

SELECT t1.month, t1.country, t1.trans_count, IFNULL(t2.approved_count, 0) AS approved_count, t1.trans_total_amount, IFNULL(t2.approved_total_amount, 0) AS approved_total_amount
FROM grouped_db AS t1 LEFT JOIN grouped_filtered_db AS t2
ON t1.month = t2.month AND t1.country = t2.country
;
