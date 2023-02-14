-- User Shopping Sprees [Amazon SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Medium

-- Amazon
-- In an effort to identify high-value customers, Amazon asked for your help to obtain data about users who go on shopping sprees. A shopping spree occurs when a user makes purchases on 3 or more consecutive days.

-- List the user IDs who have gone on at least 1 shopping spree in ascending order.

-- transactions Table:
-- Column Name	Type
-- user_id	integer
-- amount	float
-- transaction_date	timestamp
-- transactions Example Input:
-- user_id	amount	transaction_date
-- 1	9.99	08/01/2022 10:00:00
-- 1	55	08/17/2022 10:00:00
-- 2	149.5	08/05/2022 10:00:00
-- 2	4.89	08/06/2022 10:00:00
-- 2	34	08/07/2022 10:00:00
-- Example Output:
-- user_id
-- 2
-- Explanation
-- In this example, user_id 2 is the only one who has gone on a shopping spree.

--get all transaction times that are within one day of each other and total 3 days including first shopping day
--do this by using self-joins to order user transaction times by user_id (row-wise)
--get distinct users
SELECT DISTINCT t1.user_id
-- , t1.transaction_date AS time1
-- , t2.transaction_date AS time2
-- , t3.transaction_date AS time3
FROM transactions t1
JOIN transactions t2 
ON t1.user_id = t2.user_id
AND DATE(t2.transaction_date) = DATE(t1.transaction_date) + 1
JOIN transactions t3
ON DATE(t3.transaction_date) = DATE(t1.transaction_date) + 2
ORDER BY 1 
