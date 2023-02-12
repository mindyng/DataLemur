-- Top Rated Businesses [Yelp SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Easy

-- Yelp
-- This is the same question as problem #27 in the SQL Chapter of Ace the Data Science Interview!

-- Assume you are given the table below containing information on user reviews. Write a query to obtain the number and percentage of businesses that are top rated. A top-rated busines is defined as one whose reviews contain only 4 or 5 stars.

-- Output the number of businesses and percentage of top rated businesses rounded to the nearest integer.

-- Assumption:

-- Each business has only one review (which is the business' average rating).
-- P.S. It's an Easy question, so keep your solution simple and short! 😉

-- reviews Table:
-- Column Name	Type
-- business_id	integer
-- review_id	integer
-- review_stars	integer
-- review_date	datetime
-- reviews Example Input:
-- business_id	review_id	review_stars	review_date
-- 532	1234	5	07/13/2022 12:00:00
-- 824	1452	3	07/13/2022 12:00:00
-- 819	2341	5	07/13/2022 12:00:00
-- 716	1325	4	07/14/2022 12:00:00
-- 423	1434	2	07/14/2022 12:00:00
-- Example Output:
-- business_count	top_rated_pct
-- 3	60
-- Explanation: There are 3 business with the rating at least 4 - business ids 532;819;716. The total count of the businesses is 5, resulting in a percentage of 3/5 = 60%.

-- The dataset you are querying against may have different input & output - this is just an example!

SELECT SUM(CASE WHEN review_stars IN (4,5) THEN 1 ELSE 0 END) AS business_cnt
, ROUND(SUM(CASE WHEN review_stars IN (4,5) THEN 1 ELSE 0 END) * 1.0/COUNT(*) * 100) AS top_rated_pct
FROM reviews
