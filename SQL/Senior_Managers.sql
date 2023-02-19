-- Senior Managers [Google SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Hard

-- Google
-- Assume we have a table of Google employees with their corresponding managers.

-- A manager is an employee with a direct report. A senior manager is an employee who manages at least one manager, but none of their direct reports is senior managers themselves. Write a query to find the senior managers and their direct reports.

-- Output the senior manager's name and the count of their direct reports. The senior manager with the most direct reports should be the first result.

-- Assumption:

-- An employee can report to two senior managers.
-- employees Table:
-- Column Name	Type
-- emp_id	integer
-- manager_id	integer
-- manager_name	string
-- employees Example Input:
-- emp_id	manager_id	manager_name
-- 1	101	Duyen
-- 101	1001	Rick
-- 103	1001	Rick
-- 1001	1008	John
-- Example Output:
-- manager_name	direct_reportees
-- Rick	1
-- Rick is a senior manager who has one manager directly reporting to him, which is employee id 101.

--self join table to get managers reports and then sr managers reports
--1st manager ID is manager, 2nd manager ID is sr manager and 3rd manager ID is director
--based on these IDs, use 2nd manager name and count distinct manager table's emp ID to get distinct direct reports
--order by direct reports in DESC order

SELECT managers.manager_name
, COUNT(DISTINCT managers.emp_id) AS direct_reports
FROM employees --employees
JOIN employees AS managers --managers
ON employees.manager_id = managers.emp_id
JOIN employees AS senior_managers --senior managers
ON managers.manager_id = senior_managers.emp_id
GROUP BY 1
ORDER BY 2 DESC
