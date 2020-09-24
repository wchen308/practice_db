/*
Write a query to find the shortest distance between two points in these points.
 

| x   |
|-----|
| -1  |
| 0   |
| 2   |
 

The shortest distance is '1' obviously, which is from point '-1' to '0'. So the output is as below:
 

| shortest|
|---------|
| 1       |
*/

SELECT MIN(ABS(p1.x - p2.x)) AS shortest
FROM Point AS p1 JOIN Point AS p2 ON p1.x != p2.x
;