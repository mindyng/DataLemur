-- First Transaction [Etsy SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Medium

-- Etsy
-- This is the same question as problem #9 in the SQL Chapter of Ace the Data Science Interview!

-- Assume you are given the table below on user transactions. Write a query to obtain the list of customers whose first transaction was valued at $50 or more. Output the number of users.

-- Clarification:

-- Use the transaction_date field to determine which transaction should be labeled as the first for each user.
-- Use a specific function (we can't give too much away!) to account for scenarios where a user had multiple transactions on the same day, and one of those was the first.
-- user_transactions Table:
-- Column Name	Type
-- transaction_id	integer
-- user_id	integer
-- spend	decimal
-- transaction_date	timestamp
-- user_transactions Example Input:
-- transaction_id	user_id	spend	transaction_date
-- 759274	111	49.50	02/03/2022 00:00:00
-- 850371	111	51.00	03/15/2022 00:00:00
-- 615348	145	36.30	03/22/2022 00:00:00
-- 137424	156	151.00	04/04/2022 00:00:00
-- 248475	156	87.00	04/16/2022 00:00:00
-- Example Output:
-- users
-- 1
-- Explanation: Only user 156 has a first transaction valued over $50.

--get users first transaction
--see if this transaction is >= $50
--count table rows' user_id
WITH first_transaction AS (
SELECT *
FROM (SELECT user_id
, spend
, ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date ASC) AS tx_num
FROM user_transactions
) AS sub
WHERE tx_num = 1
)

SELECT COUNT(user_id) AS users
FROM first_transaction
WHERE spend >= 50
