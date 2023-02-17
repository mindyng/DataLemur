-- Compensation Outliers [Accenture SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Medium

-- Accenture
-- Your team at Accenture is helping a Fortune 500 client revamp their compensation and benefits program. The first step in this analysis is to manually review employees who are potentially overpaid or underpaid.

-- An employee is considered to be potentially overpaid if they earn more than 2 times the average salary for people with the same title. Similarly, an employee might be underpaid if they earn less than half of the average for their title. We'll refer to employees who are both underpaid and overpaid as compensation outliers for the purposes of this problem.

-- Write a query that shows the following data for each compensation outlier: employee ID, salary, and whether they are potentially overpaid or potentially underpaid (refer to Example Output below).

-- employee_pay Table:
-- Column Name	Type
-- employee_id	integer
-- salary	integer
-- title	varchar
-- employee_pay Example Input:
-- employee_id	salary	title
-- 101	80000	Data Analyst
-- 102	90000	Data Analyst
-- 103	100000	Data Analyst
-- 104	30000	Data Analyst
-- 105	120000	Data Scientist
-- 106	100000	Data Scientist
-- 107	80000	Data Scientist
-- 108	310000	Data Scientist
-- Example Output:
-- employee_id	salary	status
-- 104	30000	Underpaid
-- 108	310000	Overpaid
-- Explanation
-- In this example, 2 employees qualify as compensation outliers. Employee 104 is a Data Analyst, and the average salary for this position is $75,000. Meanwhile, the salary of employee 104 is less than $37,500 (half of $75,000); therefore, they are underpaid.

--get the outlier bands by getting average of diff titles
--create condional CASE WHEN statements to classify employee as under/over paid or neither
--output in desired format
WITH job_av AS (
SELECT title
, AVG(salary) AS avg_salary
FROM employee_pay
GROUP BY 1
)

SELECT employee_pay.employee_id
, CASE WHEN salary > 2*avg_salary THEN 'overpaid'
WHEN salary < 0.5*avg_salary THEN 'underpaid'
ELSE NULL END AS status
FROM employee_pay
JOIN job_avg
ON employee_pay.title = job_avg.title
WHERE (CASE WHEN salary > 2*avg_salary THEN 'overpaid'
WHEN salary < 0.5*avg_salary THEN 'underpaid'
ELSE NULL END) IS NOT NULL
