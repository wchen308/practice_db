/*
Write an SQL query that reports the buyers who have bought S8 but not iPhone. 
Note that S8 and iPhone are products present in the Product table.

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
| 2         | 1          | 3        | 2019-06-02 | 1        | 800   |
| 3         | 3          | 3        | 2019-05-13 | 2        | 2800  |
+-----------+------------+----------+------------+----------+-------+

Result table:
+-------------+
| buyer_id    |
+-------------+
| 1           |
+-------------+
*/

/* logic
id IN S8 buyers
id NOT IN iPhone buyers
*/

SELECT DISTINCT buyer_id
FROM Sales S LEFT JOIN Product P ON S.product_id = P.product_id
WHERE product_name = 'S8'
AND buyer_id NOT IN (SELECT buyer_id 
                     FROM Sales S LEFT JOIN Product P
                     ON S.product_id = P.product_id
                     WHERE product_name = 'iPhone')
;