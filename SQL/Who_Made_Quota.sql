-- Who Made Quota? [Oracle SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Easy

-- Oracle
-- As a data analyst on the Oracle Sales Operations team, you are given a list of salespeople’s deals, and the annual quota they need to hit.

-- Write a query that outputs each employee id and whether they hit the quota or not ('yes' or 'no'). Order the results by employee id in ascending order.

-- Definitions:

-- deal_size: Deals acquired by a salesperson in the year. Each salesperson may have more than 1 deal.
-- quota: Total annual quota for each salesperson.
-- deals Table:
-- Column Name	Type
-- employee_id	integer
-- deal_size	integer
-- deals Example Input:
-- employee_id	deal_size
-- 101	400000
-- 101	300000
-- 201	500000
-- 301	500000
-- sales_quotas Table:
-- Column Name	Type
-- employee_id	integer
-- quota	integer
-- sales_quotas Example Input:
-- employee_id	quota
-- 101	500000
-- 201	400000
-- 301	600000
-- Example Output:
-- employee_id	made_quota
-- 101	yes
-- 201	yes
-- 301	no
-- Explanation:
-- User 101 had $700k in sales, beating their $500k quota. User 201 had $500k in sales, beating their $400k quota. User 301 had $500k in sales, but had a $600k quota, so they didn't hit their goal.

--join tables on employee_id
--create met quota flag
--join tables on employee_id
--aggregate deal_size by employee_id
--create met quota flag
WITH cte AS (
SELECT employee_id
, SUM(deal_size) AS total_deal
FROM deals
JOIN sales_quotas
ON deals.employee_id = sales_quotas.employee_id
GROUP BY 1
)

SELECT employee_id
CASE WHEN total_deal >= quota THEN 'yes' ELSE 'no' END AS made_quota
FROM cte 
ORDER BY 1
