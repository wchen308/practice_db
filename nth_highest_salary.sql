CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  SET N = N - 1;
  RETURN (
      # Write your MySQL query statement below.
      SELECT DISTINCT Salary
      FROM Employee
      ORDER BY Salary Desc
      LIMIT 1 OFFSET N
  );
END

/*
LIMIT: limit selection, choose how many obs
OFFSET: skip selection, skip how many obs
*/