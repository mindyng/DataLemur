-- Marketing Touch Streak [Snowflake SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Hard

-- Snowflake
-- Background: Marketing touches, also known as touch points, are a brand's point of contact with its customers.

-- As a Data Analyst on Snowflake's Marketing Analytics team, you're examining customer relationship management (CRM) data to find contacts that meet 2 conditions:

-- Had a marketing touch for 3 or more weeks in a row
-- At least one of their marketing touches was a 'trial_request' type
-- List all the emails for these contacts.

-- marketing_touches Table:
-- Column Name	Type
-- event_id	integer
-- contact_id	integer
-- event_type	string ('webinar', 'conference_registration', 'trial_request')
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
-- crm_contacts Table:
-- Column Name	Type
-- contact_id	integer
-- email	string
-- crm_contacts Example Input:
-- contact_id	email
-- 1	andy.markus@att.net
-- 2	rajan.bhatt@capitalone.com
-- 3	lissa_rogers@jetblue.com
-- 4	kevinliu@square.com
-- Example Output:
-- email
-- andy.markus@att.net
-- Explanation:
-- Contact ID 1 (andy.markus@att.net) is the only one who fulfilled both conditions - one of their event types was trial_request, and the marketing touch points happened consecutively for 3 weeks

-- Meanwhile, user 2 can't be included because their touch points happened in the same week.

--get weeks of event_date
--get lag and lead of current even_date
--join marketing events to contacts
--filter on lead and lag that have 1 wk separation from current as well as event_type = trial_request
--output email address

WITH weeks AS (
SELECT contact_id
, event_type
, LAG(EXTRACT(WEEK FROM event_date), 1) OVER (PARTITION BY contact_id ORDER BY event_date) AS prev_event_wk
, EXTRACT(WEEK FROM event_date) AS current_event_wk
, LEAD(EXTRACT(WEEK FROM event_date), 1) OVER (PARTITION BY contact_id ORDER BY event_date) AS next_event_wk
FROM marketing_touches
)

SELECT DISTINCT email
FROM weeks JOIN crm_contacts ON weeks.contact_id = crm_contacts.contact_id
WHERE prev_event_wk = current_event_wk - 1
OR next_event_wk = current_event_wk + 1 --OR is used to capture 2 touches in either direction separated by 1 wk
AND event_type = 'trial_request' --rows are added that fulfill above but also have trial request
