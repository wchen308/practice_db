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


/*
SELECT buyers IN s8 buyer NOT IN iphone buyer
*/

WITH s8_buyer AS (SELECT DISTINCT s.buyer_id
                  FROM Sales AS s LEFT JOIN Product AS p
                  ON s.product_id = p.product_id
                  WHERE p.product_name = 'S8')
                  
SELECT buyer_id
FROM s8_buyer
WHERE buyer_id NOT IN (SELECT DISTINCT s.buyer_id 
                       FROM Sales  AS s 
                       LEFT JOIN Product AS p
                       ON s.product_id = p.product_id
                       WHERE p.product_name = 'iPhone')
;
