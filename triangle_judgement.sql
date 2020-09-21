/*
Could you help Tim by writing a query to judge whether these three sides can form a triangle, assuming table triangle holds the length of the three sides x, y and z.
 

| x  | y  | z  |
|----|----|----|
| 13 | 15 | 30 |
| 10 | 20 | 15 |
For the sample data above, your query should return the follow result:
| x  | y  | z  | triangle |
|----|----|----|----------|
| 13 | 15 | 30 | No       |
| 10 | 20 | 15 | Yes      |
*/

SELECT x, y, z, CASE WHEN (x + y > z) AND (x + z > y) AND (y + z > x) 
                           THEN 'Yes' 
                           ELSE 'No' END AS 'triangle'
FROM triangle
;