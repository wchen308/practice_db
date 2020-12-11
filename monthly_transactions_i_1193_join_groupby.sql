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

/*
where state = 'approved'
group by each month, country: use SUBSTRING to get month
count (*), SUM(amount)
*/

WITH total_transaction AS (SELECT SUBSTRING(trans_date, 1, 7) AS month, country, COUNT(*) AS trans_count, SUM(amount) AS trans_total_amount
                           FROM Transactions
                           GROUP BY month, country)
,
approved_transaction AS (SELECT SUBSTRING(trans_date, 1, 7) AS month, country, COUNT(*) AS approved_count, SUM(amount) AS approved_total_amount
                         FROM Transactions
                         WHERE state = 'approved'
                         GROUP BY month, country)
                         

SELECT t.month, t.country, t.trans_count, IFNULL(a.approved_count, 0) AS approved_count, t.trans_total_amount, IFNULL(a.approved_total_amount, 0) AS approved_total_amount
FROM total_transaction AS t LEFT JOIN approved_transaction AS a
ON t.month = a.month AND t.country = a.country
;

