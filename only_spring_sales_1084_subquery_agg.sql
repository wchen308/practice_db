/*
Write an SQL query that reports the products that were only sold in spring 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.

The query result format is in the following example:

Product table:
+------------+--------------+------------+
| product_id | product_name | unit_price |
+------------+--------------+------------+
| 1          | S8           | 1000       |
| 2          | G4           | 800        |
| 3          | iPhone       | 1400       |
+------------+--------------+------------+

Sales table:
+-----------+------------+----------+------------+----------+-------+
| seller_id | product_id | buyer_id | sale_date  | quantity | price |
+-----------+------------+----------+------------+----------+-------+
| 1         | 1          | 1        | 2019-01-21 | 2        | 2000  |
| 1         | 2          | 2        | 2019-02-17 | 1        | 800   |
| 2         | 2          | 3        | 2019-06-02 | 1        | 800   |
| 3         | 3          | 4        | 2019-05-13 | 2        | 2800  |
+-----------+------------+----------+------------+----------+-------+

Result table:
+-------------+--------------+
| product_id  | product_name |
+-------------+--------------+
| 1           | S8           |
+-------------+--------------+
*/

SELECT product_id, product_name
FROM Product
WHERE product_id NOT IN (SELECT product_id 
                         FROM Sales 
                         WHERE sale_date < '2019-01-01' 
                         OR sale_date > '2019-03-31')
AND product_id IN (SELECT product_id 
                   FROM Sales 
                   WHERE sale_date >= '2019-01-01' 
                   AND sale_date <= '2019-03-31')
;

/* another solution
logic

for each product_id
if min sale_date >= 2019-01-01 and max sale_date <= 2019-03-31
concat to result
*/

WITH spring_only_id AS (SELECT product_id
                        FROM Sales
                        GROUP BY product_id
                        HAVING MIN(sale_date) >= '2019-01-01' AND MAX(sale_date) <= '2019-03-31')
             
SELECT s.product_id, p.product_name
FROM spring_only_id AS s LEFT JOIN Product AS p
ON s.product_id = p.product_id
;
