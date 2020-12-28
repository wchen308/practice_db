/*
Write a query to print the respective department name and number of students majoring in each department for all departments in the department table (even ones with no current students).

Sort your results by descending number of students; if two or more departments have the same number of students, then sort those departments alphabetically by department name.

The student is described as follow:

| Column Name  | Type      |
|--------------|-----------|
| student_id   | Integer   |
| student_name | String    |
| gender       | Character |
| dept_id      | Integer   |
where student_id is the student's ID number, student_name is the student's name, gender is their gender, and dept_id is the department ID associated with their declared major.

And the department table is described as below:

| Column Name | Type    |
|-------------|---------|
| dept_id     | Integer |
| dept_name   | String  |
where dept_id is the department's ID number and dept_name is the department name.

Here is an example input:
student table:

| student_id | student_name | gender | dept_id |
|------------|--------------|--------|---------|
| 1          | Jack         | M      | 1       |
| 2          | Jane         | F      | 1       |
| 3          | Mark         | M      | 2       |
department table:

| dept_id | dept_name   |
|---------|-------------|
| 1       | Engineering |
| 2       | Science     |
| 3       | Law         |
The Output should be:

| dept_name   | student_number |
|-------------|----------------|
| Engineering | 2              |
| Science     | 1              |
| Law         | 0              |
*/

WITH grouped_db AS (SELECT dept_id, COUNT(*) AS student_number
                    FROM student
                    GROUP BY dept_id)
                    
SELECT d.dept_name, IFNULL(g.student_number, 0) AS student_number
FROM department AS d LEFT JOIN grouped_db AS g
ON d.dept_id = g.dept_id
ORDER BY student_number DESC, d.dept_name
;

/* without subquery and ifnull
group by dept_id
count(student id)

output dept_name, count
order by count desc, dept_name
*/

SELECT d.dept_name, COUNT(DISTINCT student_id) AS student_number
FROM department AS d LEFT JOIN student AS s
ON d.dept_id = s.dept_id
GROUP BY d.dept_name
ORDER BY student_number DESC, d.dept_name
;