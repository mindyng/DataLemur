-- Mean, Median, Mode [Microsoft SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Medium

-- Microsoft
-- You are given a list of numbers representing how many emails each Microsoft Outlook user has in their inbox. Before the Product Management team can work on features related to inbox zero or bulk-deleting email, they simply want to know what the mean, median, and mode are for the number of emails.

-- Output the median, median and mode (in this order). Round the mean to the the closest integer and assume that there are no ties for mode.

-- inbox_stats Table:
-- Column Name	Type
-- user_id	integer
-- email_count	integer
-- inbox_stats Example Input:
-- user_id	email_count
-- 123	100
-- 234	200
-- 345	300
-- 456	200
-- 567	200
-- Example Output:
-- mean	median	mode
-- 200	200	200
-- Explanation
-- The mean is 200 which is calculated by taking the total number of emails as 1,000 (100 + 200 + 300 + 200 + 200) divided by 5 users.

-- The mode is 200, as there are 3 instances of this email count, meaning it is the most frequent instance.

-- The median is also 200 since if we order the dataset by email count, it is the value that separates higher half from the lower half of the values.

SELECT ROUND(AVG(email_count)) AS mean
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY email_count) AS median
, MODE() WITHIN GROUP (ORDER BY email_count)  AS mode
FROM inbox_stats
