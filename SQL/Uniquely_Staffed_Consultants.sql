-- Uniquely Staffed Consultants [Accenture SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Hard

-- Accenture
-- As a Data Analyst on the People Operations team at Accenture, you are tasked with understanding how many consultants are staffed to each client, and how many consultants are exclusively staffed to a single client.

-- Write a query that outputs the client name, the number of uniquely staffed consultants, and the number of exclusively staffed consultants.

-- Tip:

-- Order the dataset by client name!
-- employees Table:
-- Column Name	Type
-- employee_id	integer
-- engagement_id	integer
-- employees Example Input:
-- employee_id	engagement_id
-- 1001	1
-- 1001	2
-- 1002	1
-- 1003	3
-- 1004	4
-- consulting_engagements Table:
-- Column Name	Type
-- engagement_id	integer
-- project_name	string
-- client_name	string
-- consulting_engagements Example Input:
-- engagement_id	project_name	client_name
-- 1	SAP Logistics Modernization	Department of Defense
-- 2	Oracle Cloud Migration	Department of Education
-- 3	Trust & Safety Operations	Google
-- 4	SAP IoT Cloud Integration	Google
-- Example Output:
-- client_name	total_staffed	exclusive_staffed
-- Department of Defense	2	1
-- Department of Education	1	0
-- Google	2	2
-- Explanation:
-- The Department of Defense has only 1 project, which is staffed by employees 1001 and 1002. However, employee 1001 is also working on project 2. So, in total, there are 2 employees working on the project, but only 1 is exclusively working with the Department of Defense.

--join consulting_engagements to employees table
--get window function to calculate numnber of clients per employee
--get count of total employees and sum of employees who just have 1 client
--order clients in alpha order


WITH num_clients AS (
SELECT ce.client_name
, e.employee_id
, COUNT(ce.engagement_id) OVER (PARTITION BY e.employee_id) AS num_clients
FROM consulting_engagements ce
JOIN employees e
ON ce.engagement_id = e.engagement_id
)

SELECT client_name
, COUNT(employee_id) AS total_staffed
, SUM(CASE WHEN num_clients = 1 THEN 1 ELSE 0 END) AS exclusive_staffed
FROM num_clients
GROUP BY 1
ORDER BY 1
