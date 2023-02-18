-- Follow-Up Airpod Percentage [Apple SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Hard

-- Apple
-- The Apple retention team needs your help to investigate buying patterns. Write a query to determine the percentage of buyers who bought AirPods directly after they bought iPhones. Round your answer to a percentage (i.e. 20 for 20%, 50 for 50) with no decimals.

-- Clarifications:

-- The users were interested in buying iPhones and then AirPods, with no intermediate purchases in between.
-- Users who buy iPhones and AirPods at the same time, with the iPhone logged first, can still be counted.
-- Tip:

-- Multiply by 100 before you perform the rounding to make sure you get the same answer we did :)
-- transactions Table:
-- Column Name	Type
-- transaction_id	integer
-- customer_id	integer
-- product_name	varchar
-- transaction_timestamp	datetime
-- transactions Example Input:
-- transaction_id	customer_id	product_name	transaction_timestamp
-- 1	101	iPhone	08/08/2022 00:00:00
-- 2	101	AirPods	08/08/2022 00:00:00
-- 5	301	iPhone	09/05/2022 00:00:00
-- 6	301	iPad	09/06/2022 00:00:00
-- 7	301	AirPods	09/07/2022 00:00:00
-- Example Output:
-- follow_up_percentage
-- 50
-- Of the two users, only user 101 bought AirPods after buying an iPhone.

-- Note that we still count user 101, even though they bought both an iPhone and AirPods in the same transaction. We can't count customer 301 since they bought an iPad in between their iPhone and AirPods.

-- Therefore, 1 out of 2 users fit the problem's criteria. For this example, the follow-up percentage would be 50%.

--use LAG(product_name, 1) PARTITION BY user order by transaction time to get which prod bought before each tx
--key is to group by customer_id, product_name and transaction_timestamp
--get flag to see if airpods follow iphone
--count distinct these buyers and divide distinct buyers from all buyers who bought
-- *100 and round to nearest number
WITH cust_tx_order AS (
SELECT customer_id
, product_name
, transaction_timestamp
, LAG(product_name, 1) OVER (PARTITION BY customer_id ORDER BY transaction_timestamp) AS last_prod_purch
FROM transactions
GROUP BY 1, 2, 3
-- ORDER BY 1
-- , 3
)

SELECT ROUND(SUM(CASE WHEN lower(product_name) = 'airpods'  AND lower(last_prod_purch) = 'iphone' THEN 1 ELSE 0 END) * 1.0/(SELECT COUNT(DISTINCT customer_id) FROM transactions) *100) AS follow_up_percentage
FROM cust_tx_order
