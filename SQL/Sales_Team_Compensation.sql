-- Sales Team Compensation [Oracle SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Medium

-- Oracle
-- As Oracle’s Sales Operations analyst, you are helping the VP of Sales determine the final compensation each salesperson earned for the year.

-- Each salesperson earns a fixed base salary and a percentage of commission on their total deals. Also, if they beat their quota, any sales after that receive an accelerator, which is just a higher commission rate applied to their commissions after they hit the quota.

-- Write a query to calculate the total compensation earned by each salesperson. Output the employee id and total compensation in descending order. Where there are ties, sort the employee id in ascending order.

-- Assumptions:

-- Hitting a target (quota) means the amount of total deals is equivalent to or higher than the target.
-- When a salesperson did not hit the target (quota), the employee receives a fixed base salary and a commission on the total deals.
-- When a salesperson hits the target (quota), the compensation package includes:
-- a fixed base salary,
-- a commission on target (quota), and
-- a commission and accelerated commission on the balance of the total deals (total deals - quota) (see example output & explanation below).
-- employee_contract Table:
-- Column Name	Type
-- employee_id	integer
-- base	integer
-- commission	double
-- quota	integer
-- accelerator	double
-- employee_contract Example Input:
-- employee_id	base	commission	quota	accelerator
-- 101	60000	0.1	500000	1.5
-- 102	50000	0.1	400000	1.5
-- deals Table:
-- Column Name	Type
-- employee_id	integer
-- deal_size	integer
-- deals Example Input:
-- employee_id	deal_size
-- 101	400000
-- 101	400000
-- 102	100000
-- 102	200000
-- Example Output:
-- employee_id	total_compensation
-- 101	155000
-- 102	80000
-- Explanation
-- ID 101: 60,000 + 50,000 (this is 10% of their 500k since they hit the quota) + 45,000 (they did 300k over quota * 10% commission * 1.5 accelerator).

-- ID 102: 50,000 (base) + 30,000 (commission on 300,000 of total deals)

--aggregate total deal size by employee
--if hit quota, then take base + quota * commission rate + diff from quota * commission rate *1.5
--if quota not hit, then base + deal size * commission rate

WITH deal_sizes AS (
SELECT employee_id
, SUM(deal_size) AS deal_size
FROM deals
GROUP BY 1
)

SELECT deal_sizes.employee_id
, ROUND(CASE WHEN deal_size >= quota THEN base + quota*commission + (deal_size-quota)*commission*1.5
ELSE base + deal_size*commission END) AS total_compensation
FROM deal_sizes
JOIN employee_contract
ON deal_sizes.employee_id = employee_contract.employee_id
ORDER BY 2 DESC,
1
