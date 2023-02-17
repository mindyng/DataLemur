-- Average Post Hiatus (Part 2) [Facebook SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Hard

-- Facebook
-- You are given a table of Facebook posts from users who posted at least twice in 2021. Write a query to find the average number of days between each user’s posts during 2021.

-- Output the user id and the average number of the days between posts.

-- Assumptions:

-- A user can post several times a day.
-- When calculating the differences between dates, output the component of the time in the form of days. For example, 10 days or 5.5 days.
-- posts Table:
-- Column Name	Type
-- user_id	integer
-- post_id	integer
-- post_date	timestamp
-- post_content	text
-- posts Example Input:
-- user_id	post_id	post_date	post_content
-- 151652	599415	07/10/2021 12:00:00	Need a hug
-- 151652	994156	07/15/2021 12:00:00	Does anyone have an extra iPhone charger to sell?
-- 661093	624356	07/29/2021 13:00:00	Bed. Class 8-12. Work 12-3. Gym 3-5 or 6. Then class 6-10. Another day that's gonna fly by. I miss my girlfriend
-- 004239	784254	07/04/2021 11:00:00	Happy 4th of July!
-- 661093	442560	07/08/2021 14:00:00	Just going to cry myself to sleep after watching Marley and Me.
-- 151652	111766	07/12/2021 19:00:00	I'm so done with covid - need travelling ASAP!
-- Example Output:
-- user_id	days_between
-- 151652	2.5
-- 661093	21
-- Explanation: User 661903 had 2 days between the first and the second post; and 3 days between the second and the third post. Thus, the average is 2.5 days.

--get 2021 posts only
--get last post for each post
--get diff in days 
--get average hiatus per user_id
WITH cte AS (
SELECT user_id
, DATE_PART('DAY', post_date - LAG(post_date, 1) OVER (PARTITION BY user_id ORDER BY post_date)) AS days_between
FROM posts
WHERE EXTRACT(YEAR FROM post_date) = 2021
)

SELECT user_id
, AVG(days_between) AS days_between
FROM cte 
WHERE days_between IS NOT NULL
GROUP BY 1
