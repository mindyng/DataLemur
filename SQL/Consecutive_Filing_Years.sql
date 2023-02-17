-- Consecutive Filing Years [Intuit SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Hard

-- Intuit
-- Intuit offers several tax filing products, such as TurboTax and QuickBooks, which come in multiple versions.

-- Write a query to find the user ids of everyone who filed their taxes with any version of TurboTax three or more years in a row. Display the output in the ascending order of user ids.

-- Assumption:

-- As reflected in the table, a user can only file taxes once a year using one product.
-- filed_taxes Table:
-- Column Name	Type
-- filing_id	integer
-- user_id	varchar
-- filing_date	datetime
-- product	varchar
-- filed_taxes Example Input:
-- filing_id	user_id	filing_date	product
-- 1	1	4/14/2019	TurboTax Desktop 2019
-- 2	1	4/15/2020	TurboTax Deluxe
-- 3	1	4/15/2021	TurboTax Online
-- 4	2	4/07/2020	TurboTax Online
-- 5	2	4/10/2021	TurboTax Online
-- 6	3	4/07/2020	TurboTax Online
-- 7	3	4/15/2021	TurboTax Online
-- 8	3	3/11/2022	QuickBooks Desktop Pro
-- 9	4	4/15/2022	QuickBooks Online
-- Example Output:
-- user_id
-- 1
-- Explanation
-- User 1 filed using TurboTax for consecutive 3 years. We do not include User 2 because they missed the filing in the third year and User 3 switched to QuickBooks in their third year.

--filter for Turbotax products used only
--do row_number() on all users
--output DISTINCT user_id from rows with row_num >=3

WITH cte AS (SELECT user_id
, filing_date
, ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY filing_date) AS filing_num
FROM filed_taxes
WHERE product LIKE '%TurboTax%'
)

SELECT DISTINCT user_id
FROM cte
WHERE filing_num >=3
ORDER BY 1
