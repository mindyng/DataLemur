-- Subject Matter Experts [Accenture SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Easy

-- Accenture
-- You are trying to identify all Subject Matter Experts at Accenture. An employee is a subject matter expert if they have 8 or more years of work experience in a given domain, or if they have 12 or more years of experience across 2 different domains.

-- Write a query to return the employee id of all the subject matter experts.

-- Notes:

-- Question only asks for years of work experience across either 1 or 2 domains. You may disregard cases where an employee has years of experience in more than 2 domains.
-- employee_expertise Table:
-- Column Name	Type
-- employee_id	integer
-- domain	string
-- years_of_experience	integer
-- users Example Input:
-- employee_id	domain	years_of_experience
-- 101	Digital Transformation	9
-- 102	Supply Chain	6
-- 102	IoT	7
-- 103	Change Management	4
-- 104	DevOps	5
-- 104	Cloud Migration	5
-- 104	Agile Transformation	5
-- Example Output:
-- employee_id
-- 101
-- 102
-- Explanation
-- Don't print out 103 because they only have 4 years experience. Don't print out 104 because even though they have 15 years of experience in total, it's across 3 different domains.

-- The dataset you are querying against may have different input & output - this is just an example!

--aggregate domains
--filter on <= 2 domains and number of years based on domain number
WITH agg AS (
SELECT employee_id
, COUNT(domain) AS domain_cnt
, SUM(years_of_experience) AS total_years_experience
FROM employee_expertise
GROUP BY 1
)

SELECT employee_id
FROM agg
WHERE domain_cnt <=2
AND (domain_cnt = 1 AND total_years_experience >=8) OR 
(domain_cnt = 2 AND total_years_experience >=12)
