-- Webinar Popularity [Snowflake SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Easy

-- Snowflake
-- As a Data Analyst on Snowflake's Marketing Analytics team, you're analyzing the CRM to determine what percent of marketing touches were of type "webinar" in April 2022. Round your percentage to the nearest integer.

-- Did you know? Marketing touches, also known as touch points are the brand's (Snowflake's) point of contact with the customers, from start to finish.

-- marketing_touches Table:
-- Column Name	Type
-- event_id	integer
-- contact_id	integer
-- event_type	string
-- event_date	date
-- marketing_touches Example Input:
-- event_id	contact_id	event_type	event_date
-- 1	1	webinar	4/17/2022
-- 2	1	trial_request	4/23/2022
-- 3	1	whitepaper_download	4/30/2022
-- 4	2	handson_lab	4/19/2022
-- 5	2	trial_request	4/23/2022
-- 6	2	conference_registration	4/24/2022
-- 7	3	whitepaper_download	4/30/2022
-- 8	4	trial_request	4/30/2022
-- 9	4	webinar	5/14/2022
-- Example Output:
-- webinar_pct
-- 13
-- Explanation:
-- In April 2022, there is 1 webinar out of a total of 8 marketing events. Thus, the ratio is 1/8 = 12.5% ~ 13%.

-- The dataset you are querying against may have different input & output - this is just an example!

SELECT ROUND(COUNT(*) * 1.0/(SELECT COUNT(*) FROM marketing_touches WHERE EXTRACT(MONTH FROM event_date) = 4) *100) AS webinar_pct
FROM marketing_touches
WHERE EXTRACT(MONTH FROM event_date) = 4
AND event_type = 'webinar'
