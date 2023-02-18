-- Monthly Merchant Balance [Visa SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Hard

-- Visa
-- Say you have access to all the transactions for a given merchant account. Write a query to print the cumulative balance of the merchant account at the end of each day, with the total balance reset back to zero at the end of the month. Output the transaction date and cumulative balance.

-- transactions Table:
-- Column Name	Type
-- transaction_id	integer
-- type	string ('deposit', 'withdrawal')
-- amount	decimal
-- transaction_date	timestamp
-- transactions Example Input:
-- transaction_id	type	amount	transaction_date
-- 19153	deposit	65.90	07/10/2022 10:00:00
-- 53151	deposit	178.55	07/08/2022 10:00:00
-- 29776	withdrawal	25.90	07/08/2022 10:00:00
-- 16461	withdrawal	45.99	07/08/2022 10:00:00
-- 77134	deposit	32.60	07/10/2022 10:00:00
-- Example Output:
-- transaction_date	balance
-- 07/08/2022 12:00:00	106.66
-- 07/10/2022 12:00:00	205.16
-- To get cumulative balance of 106.66 on 07/08/2022 12:00:00, we take the deposit of 178.55 and minus against two withdrawals 25.90 and 45.99.

--create new column with + sign for deposits and - sign for withdrawals
--get sum on a daily level of newly made column of deposits and withdrawals
--window function for cumulative sum partitioned by month

WITH daily_balances AS (
SELECT DATE_TRUNC('day', transaction_date) AS transaction_day
, DATE_TRUNC('month', transaction_date) AS transaction_month
, SUM(CASE WHEN type = deposit THEN amount ELSE -1*amount END AS new_amount) AS balance
FROM transactions
GROUP BY 1
, 2
)

SELECT transaction_day
, SUM(balance) OVER (PARTITION BY transaction_month) AS balance
FROM daily_balances
ORDER BY 1
