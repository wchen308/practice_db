/*
Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places.

The query result format is in the following example:

Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 5           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-11                  |
| 4           | 3           | 2019-08-24 | 2019-08-26                  |
| 5           | 4           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
+-------------+-------------+------------+-----------------------------+

Result table:
+----------------------+
| immediate_percentage |
+----------------------+
| 33.33                |
+----------------------+
The orders with delivery id 2 and 3 are immediate while the others are scheduled.
*/

/*
calculate immediate_percentage: count(immediate_order) / count(all_order)
immediate_order: order_date = delivery_date
round result to 2 decimal using round(val, 2)

py: create a new binary feature 0/1 then sum/count
*/

SELECT ROUND(SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) / COUNT(DISTINCT (delivery_id)) * 100, 2) AS immediate_percentage
FROM Delivery;