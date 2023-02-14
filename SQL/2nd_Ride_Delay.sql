-- 2nd Ride Delay [Uber SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Medium

-- Uber
-- As a data analyst at Uber, it's your job to report the latest metrics for specific groups of Uber users. Some riders create their Uber account the same day they book their first ride; the rider engagement team calls them "in-the-moment" users.

-- Uber wants to know the average delay between the day of user sign-up and the day of their 2nd ride. Write a query to pull the average 2nd ride delay for "in-the-moment" Uber users. Round the answer to 2-decimal places.

-- Tip:

-- You don't need to use date operations to get the answer! You're welcome to, but it's not necessary.
-- users Table:
-- Column Name	Type
-- user_id	integer
-- registration_date	date
-- users Example Input:
-- user_id	registration_date
-- 1	08/15/2022
-- 2	08/21/2022
-- rides Table:
-- Column Name	Type
-- ride_id	integer
-- user_id	integer
-- ride_date	date
-- rides Example Input:
-- ride_id	user_id	ride_date
-- 1	1	08/15/2022
-- 2	1	08/16/2022
-- 3	2	09/20/2022
-- 4	2	09/23/2022
-- Example Output:
-- average_delay
-- 1
-- Explanation:
-- We do not include user 2 in the calculation because the user was not created on the same date as the first ride.
-- For user 1, the difference between the first and second rides was 1 day; thus, the overall average is 1 day.

--get in the moment users (1st ride same day as new account)
--time diff between 2nd ride day and day account made (get ride number and get previous ride date)
--filter on 2nd ride only
--get average of this time diff
--round to 2 decimal places

WITH moment_users AS 
(
SELECT DISTINCT users.user_id
, registration_date
FROM users
JOIN rides
ON users.user_id = rides.user_id
AND users.registration_date = rides.ride_date
)

, rides_cte AS (
SELECT moment_users.user_id
, registration_date
, ride_date
, ROW_NUMBER() OVER (PARTITION BY moment_users.user_id ORDER BY ride_date) AS ride_num
, LAG(ride_date, 1) OVER (PARTITION BY moment_users.user_id ORDER BY ride_date) AS prev_ride_date
--, (NTH_VALUE(ride_date, 2) OVER (PARTITION BY rides.user_id ORDER BY ride_date) - registration_date) AS second_ride_from_reg_daydiff
FROM moment_users
LEFT JOIN rides
ON moment_users.user_id = rides.user_id
)

SELECT ROUND(AVG(ride_date - prev_ride_date), 2) AS average_delay
FROM rides_cte
WHERE ride_num = 2
