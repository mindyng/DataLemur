-- Booking Referral Source [Airbnb SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Medium

-- Airbnb
-- The Airbnb marketing analytics team is trying to understand what are the most common marketing channels that lead users to book their first rental on Airbnb.

-- Write a query to find the top marketing channel and percentage of first rental bookings from the aforementioned marketing channel. Round the percentage to the closest integer. Assume there are no ties.

-- Assumptions:

-- Marketing channel with null values should be incorporated in the percentage of first bookings calculation, but the top channel should not be a null value. Meaning, we cannot have null as the top marketing channel.
-- To avoid integer division, multiple the percentage with 100.0 and not 100.
-- bookings Table:
-- Column Name	Type
-- booking_id	integer
-- user_id	integer
-- booking_date	datetime
-- bookings Example Input:
-- booking_id	user_id	booking_date
-- 1	1	01/01/2022 00:00:00
-- 2	1	01/06/2022 00:00:00
-- 6	2	01/06/2022 00:00:00
-- 8	3	01/06/2022 00:00:00
-- booking_attribution Table:
-- Column Name	Type
-- booking_id	integer
-- channel	string
-- booking_attribution Example Input:
-- booking_id	channel
-- 1	organic search
-- 2	
-- 3	organic search
-- 4	referral
-- 5	email
-- 6	organic search
-- 7	paid search
-- 8	
-- 9	paid search
-- 10	paid search
-- Example Output:
-- channel	first_booking_pct
-- organic search	67
-- Explanation:
-- We know that user 1's first booking was organic search, user 2's was organic search, and user 3's was null. Thus, 2 bookings via organic search / 3 total bookings = 67%.

--get all first rentals
--include null marketing channels
--divide count of marketing channels (using booking_id) by all first rentals (make sure num is decimal)
--round to nearest int

WITH booking_num AS (
SELECT booking_id
, user_id
, booking_date
, CASE WHEN booking_id = FIRST_VALUE(booking_id) OVER (PARTITION BY user_id ORDER BY booking_date) THEN 1 ELSE 0 END AS first_booking_flag
FROM bookings
)
SELECT channel
, ROUND(SUM(first_booking_flag)  * 1.0/(SELECT COUNT(*) FROM booking_num WHERE first_booking_flag = 1) * 100) AS first_booking_pct
FROM
(
SELECT booking_id
, user_id
, booking_date
, first_booking_flag
FROM booking_num
) bookings
JOIN
(
SELECT booking_id
, channel
FROM booking_attribution
) attribution
ON bookings.booking_id = attribution.booking_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
