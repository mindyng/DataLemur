-- Unique Money Transfer Relationships [PayPal SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Medium

-- PayPal
-- You are given a table of PayPal payments showing the payer, the recipient, and the amount paid. A two-way unique relationship is established when two people send money back and forth. Write a query to find the number of two-way unique relationships in this data.

-- Assumption:

-- A payer can send money to the same recipient multiple times.
-- payments Table:
-- Column Name	Type
-- payer_id	integer
-- recipient_id	integer
-- amount	integer
-- payments Example Input:
-- payer_id	recipient_id	amount
-- 101	201	30
-- 201	101	10
-- 101	301	20
-- 301	101	80
-- 201	301	70
-- Example Output:
-- unique_relationships
-- 2
-- Explanation
-- There are 2 unique two-way relationships between:

-- ID 101 and ID 201
-- ID 101 and ID 301

-- goal: for each payer to recipient check to see if recipient is also a payer to est 2-way unique rel
--join recipient to table with reverse relationship
--count unique relationship and dividing by 2 to get rid of duplicated relationships with same individuals
SELECT COUNT(DISTINCT(CONCAT(p1.payer_id, p1.recipient_id)))/2 AS unique_relationships --2 is to dedup same pairs
FROM payments p1 
JOIN payments p2
ON p1.payer_id = p2.recipient_id
AND p1.recipient_id = p2.payer_id
