-- Photoshop Revenue Analysis [Adobe SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Medium

-- Adobe
-- For every customer that bought Photoshop, return a list of the customers, and the total spent on all the products except for Photoshop products.

-- Sort your answer by customer ids in ascending order.

-- adobe_transactions Table:
-- Column Name	Type
-- customer_id	integer
-- product	string
-- revenue	integer
-- adobe_transactions Example Input:
-- customer_id	product	revenue
-- 123	Photoshop	50
-- 123	Premier Pro	100
-- 123	After Effects	50
-- 234	Illustrator	200
-- 234	Premier Pro	100
-- Example Output:
-- customer_id	revenue
-- 123	150
-- Explanation: User 123 bought Photoshop, Premier Pro + After Effects, spending $150 for those products. We don't output user 234 because they didn't buy Photoshop.

--get customers who bought Photoshop (use as CTE or lookup table)
--join Photoshop customers to tx on customer_id and product != 'Photoshop'

WITH photo_cust AS (
SELECT customer_id
, product
FROM adobe_transactions
WHERE product = 'Photoshop'
)

SELECT photo_cust.customer_id
, SUM(revenue) AS revenue
FROM photo_cust
JOIN adobe_transactions 
ON photo_cust.customer_id = adobe_transactions.customer_id
AND photo_cust.product != adobe_transactions.product
GROUP BY 1
ORDER BY 1
