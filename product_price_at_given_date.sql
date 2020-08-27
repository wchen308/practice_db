/*
Write an SQL query to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

The query result format is in the following example:

Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+

Result table:
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+
*/

# Write your MySQL query statement below
/* logic
before/on 2019-08-16: show price
null? price = 10
*/

WITH latest_price AS (SELECT product_id, new_price
                      FROM Products
                      WHERE (product_id, change_date) IN (SELECT product_id, max(change_date)
                                                          FROM Products
                                                          WHERE change_date <= '2019-08-16'
                                                          GROUP BY product_id)
),
distinct_product AS (SELECT DISTINCT product_id FROM Products)

SELECT d.product_id AS product_id, IFNULL(l.new_price, 10) AS price
FROM distinct_product AS d LEFT JOIN latest_price AS l 
ON d.product_id = l.product_id
;