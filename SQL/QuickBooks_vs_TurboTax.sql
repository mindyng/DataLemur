-- QuickBooks vs TurboTax [Intuit SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Easy

-- Intuit
-- Intuit offers several tax filing products, such as TurboTax and QuickBooks, which come in multiple versions.

-- Write a query to find the total number of filings that used TurboTax, and the total number of filings that used QuickBooks.

-- Assumption:

-- As reflected in the table, a user can only file taxes once a year using one product.
-- If you like this question, try out a similar question, Laptop vs Mobile Viewers!

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
-- turbotax_total	quickbooks_total
-- 7	2
-- Explanation
-- There were 7 filings using TurboTax and 2 filings using QuickBooks.

-- The dataset you are querying against may have different input & output - this is just an example!

SELECT SUM(CASE WHEN product LIKE 'TurboTax%' THEN 1 ELSE 0 END) AS turbotax_total
, SUM(CASE WHEN product LIKE 'QuickBooks%' THEN 1 ELSE 0 END) AS quickbooks_total
FROM filed_taxes
