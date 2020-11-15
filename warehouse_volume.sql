/* logic
each product calculate total volume
group by warehouse name, sum volume

avoid subquery to be faster
*/

SELECT w.name AS warehouse_name, SUM(p.Width * p.Length * p.Height * w.units) AS volume
FROM Warehouse AS w LEFT JOIN Products AS p
ON w.product_id = p.product_id
GROUP BY w.name
;