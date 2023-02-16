-- Average Deal Size (Part 2) [Salesforce SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Medium

-- Salesforce
-- Assume Salesforce customers pay on a per user basis (also referred to as per seat model). Given a table of contracts data, write a query to calculate the average annual revenue per Salesforce customer in the three market segments. Output the results as per the example output below.

-- Assumptions:

-- Yearly seat cost refers to the cost per seat.
-- Each customer represents one contract.
-- The market segments are:-
-- SMB (<100 employees)
-- Mid-Market (100-999 employees)
-- Enterprise (>=1000 employees)
-- contracts Table:
-- Column Name	Type
-- customer_id	integer
-- num_seats	integer
-- yearly_seat_cost	integer
-- contracts Example Input:
-- customer_id	num_seats	yearly_seat_cost
-- 2690	50	25
-- 4520	200	50
-- 4520	150	50
-- 4520	150	50
-- 7832	878	50
-- customers Table:
-- Column Name	Type
-- customer_id	integer
-- name	varchar
-- employee_count	integer (0-100,000)
-- customers Example Input:
-- customer_id	name	employee_count
-- 4520	DBT Labs	500
-- 2690	DataLemur	99
-- 7832	GitHub	878
-- Example Output:
-- smb_avg	mid_avg	enterprise_avg
-- 1250	43900	25000
-- Explanation: Datalemur is classified as the only SMB in the example data. They have only one contract including 50 seats with the price of 
-- 25each=1250.

--categorize customers into market segments
--get revenue per company
--convert result into desired output with smb_avg, mid_avg and enterprise_avg


WITH segment AS (
SELECT customer_id
, CASE WHEN employee_count < 100 THEN 'smb' 
WHEN employee_count BETWEEN 100 AND 999 THEN 'mid'
WHEN employee_count >=1000  THEN 'enterprise'
END AS segment
FROM customers
)

, final_rev AS (
SELECT segment
, SUM(num_seats*yearly_seat_cost)/COUNT(DISTINCT contracts.customer_id) AS rev_per_cust
FROM segment
JOIN contracts
ON segment.customer_id = contracts.customer_id
GROUP BY 1)

SELECT MAX(CASE WHEN segment = 'smb' THEN rev_per_cust END) AS smb_avg
, MAX(CASE WHEN segment = 'mid' THEN rev_per_cust END) AS mid_avg
, MAX(CASE WHEN segment = 'enterprise' THEN rev_per_cust END) AS enterprise_avg
FROM final_rev
