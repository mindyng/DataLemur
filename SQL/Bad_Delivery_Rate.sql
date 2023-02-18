-- Bad Delivery Rate [DoorDash SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Hard

-- DoorDash
-- DoorDash's Growth Team is trying to make sure new users (those who are making orders in their first 14 days) have a great experience on all their orders in their 2 weeks on the platform.

-- Unfortunately, many deliveries are being messed up because:

-- the orders are being completed incorrectly (missing items, wrong order, etc.)
-- the orders aren't being received (wrong address, wrong drop off spot)
-- the orders are being delivered late (the actual delivery time is 30 minutes later than when the order was placed). Note that the estimated_delivery_timestamp is automatically set to 30 minutes after the order_timestamp.
-- Write a query to find the bad experience rate in the first 14 days for new users who signed up in June 2022. Output the percentage of bad experience rounded to 2 decimal places.

-- P.S. If you've read the Ace the Data Science Interview and liked it, consider writing us a review?

-- orders Table:
-- Column Name	Type
-- order_id	integer
-- customer_id	integer
-- trip_id	integer
-- status	string ('completed successfully', 'completed incorrectly', 'never received')
-- order_timestamp	timestamp
-- orders Example Input:
-- order_id	customer_id	trip_id	status	order_timestamp
-- 727424	8472	100463	completed successfully	06/05/2022 09:12:00
-- 242513	2341	100482	completed incorrectly	06/05/2022 14:40:00
-- 141367	1314	100362	completed incorrectly	06/07/2022 15:03:00
-- 582193	5421	100657	never_received	07/07/2022 15:22:00
-- 253613	1314	100213	completed successfully	06/12/2022 13:43:00
-- trips Table:
-- Column Name	Type
-- dasher_id	integer
-- trip_id	integer
-- estimated_delivery_timestamp	timestamp
-- actual_delivery_timestamp	timestamp
-- trips Example Input:
-- dasher_id	trip_id	estimated_delivery_timestamp	actual_delivery_timestamp
-- 101	100463	06/05/2022 09:42:00	06/05/2022 09:38:00
-- 102	100482	06/05/2022 15:10:00	06/05/2022 15:46:00
-- 101	100362	06/07/2022 15:33:00	06/07/2022 16:45:00
-- 102	100657	07/07/2022 15:52:00	-
-- 103	100213	06/12/2022 14:13:00	06/12/2022 14:10:00
-- customers Table:
-- Column Name	Type
-- customer_id	integer
-- signup_timestamp	timestamp
-- customers Example Input:
-- customer_id	signup_timestamp
-- 8472	05/30/2022 00:00:00
-- 2341	06/01/2022 00:00:00
-- 1314	06/03/2022 00:00:00
-- 1435	06/05/2022 00:00:00
-- 5421	06/07/2022 00:00:00
-- Example Output:
-- bad_experience_pct
-- 75.00
-- Order 727424 es excluded as the order is made after the first 14 days upon signing up. There are 4 orders, however, there are only 3 orders with bad experiences as one of the orders 253613 is completed successfully. So, 3 out of 4 orders are 75% bad experience.

--filter on users signed up in June 2022
--filter on orders that are within 14 days since sign up including sign up date
--discount completed successfully orders/account for completed incorrectly/never received
--account for delivery times that are >30 min
--also account for any null delivery times since orders failed to deliver
WITH orders_cte AS (SELECT customers.customer_id
, signup_timestamp
, order_id
, trip_id
, status
, order_timestamp
FROM customers
LEFT JOIN orders 
ON customers.customer_id = orders.customer_id
WHERE DATE(signup_timestamp) BETWEEN '06/01/2022' AND '06/30/2022'
AND order_timestamp <= DATE(signup_timestamp) + INTERVAL '14 day' 
)

SELECT ROUND(COUNT(*) * 1.0/(SELECT COUNT(*) FROM orders_cte) * 100, 2) AS bad_experience_pct
FROM orders_cte
JOIN trips
ON orders_cte.trip_id = trips.trip_id
WHERE status != 'completed successfully'
OR actual_delivery_timestamp > estimated_delivery_timestamp 
OR actual_delivery_timestamp IS NULL
