-- User Session Activity [Twitter SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Medium

-- Twitter
-- This is the same question as problem #24 in the SQL Chapter of Ace the Data Science Interview!

-- Assume you are given the table containing Twitter user session activities.

-- Write a query that ranks users according to their total session durations (in minutes) in descending order for each session type between the start date (2022-01-01) and the end date (2022-02-01).

-- Output the user ID, session type, and the ranking of the total session duration.

-- sessions Table:
-- Column Name	Type
-- session_id	integer
-- user_id	integer
-- session_type	string ("like", "reply", "retweet")
-- duration	integer (in minutes)
-- start_date	timestamp
-- session Example Input:
-- session_id	user_id	session_type	duration	start_date
-- 6368	111	like	3	12/25/2021 12:00:00
-- 1742	111	retweet	6	01/02/2022 12:00:00
-- 8464	222	reply	8	01/16/2022 12:00:00
-- 7153	111	retweet	5	01/28/2022 12:00:00
-- 3252	333	reply	15	01/10/2022 12:00:00
-- Example Output:
-- user_id	session_type	ranking
-- 333	reply	1
-- 222	reply	2
-- 111	retweet	1
-- Explanation: User 333 is listed on the top due to the highest duration of 15 minutes. The ranking resets on 3rd row as the session type changes.

--get right time frame
--for each session_type, sum total duration
--rank by total duration in descending order

WITH ttl_duration AS (SELECT user_id
, session_type
, SUM(duration) AS total_duration
FROM sessions
WHERE start_date BETWEEN '2022-01-01' AND '2022-02-01'
GROUP BY 1
, 2
)

SELECT user_id
, session_type
, DENSE_RANK() OVER (PARTITION BY session_type ORDER BY total_duration DESC) as ranking
FROM ttl_duration
