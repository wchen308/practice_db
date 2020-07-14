/*
Write an SQL query to find the average selling price for each product.

average_price should be rounded to 2 decimal places.

The query result format is in the following example:

Prices table:
+------------+------------+------------+--------+
| product_id | start_date | end_date   | price  |
+------------+------------+------------+--------+
| 1          | 2019-02-17 | 2019-02-28 | 5      |
| 1          | 2019-03-01 | 2019-03-22 | 20     |
| 2          | 2019-02-01 | 2019-02-20 | 15     |
| 2          | 2019-02-21 | 2019-03-31 | 30     |
+------------+------------+------------+--------+
 
UnitsSold table:
+------------+---------------+-------+
| product_id | purchase_date | units |
+------------+---------------+-------+
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |
+------------+---------------+-------+

Result table:
+------------+---------------+
| product_id | average_price |
+------------+---------------+
| 1          | 6.96          |
| 2          | 16.96         |
+------------+---------------+
*/

/*
avg selling price: sum(price * units)/sum(units)\
round(value, 2)

join price on unitsold table so that we know
product_id, units, price
*/

SELECT u.product_id, ROUND(SUM(u.units * p.price) / SUM(u.units), 2) AS average_price
FROM UnitsSold AS u, Prices AS p
WHERE u.product_id = p.product_id
AND u.purchase_date >= p.start_date AND u.purchase_date <= p.end_date
GROUP BY u.product_id
;