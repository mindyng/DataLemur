-- User Concurrent Sessions [Pinterest SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Hard

-- Pinterest
-- This is the same question as problem #26 in the SQL Chapter of Ace the Data Science Interview!

-- Assume you are given the table containing information on user sessions, including their start and end times. Write a query to obtain the user session that is concurrent with the other user sessions.

-- Output the session id and number of concurrent user sessions in descending order.

-- Assumptions:

-- Sessions with the same start and end time are not considered concurrent sessions.
-- Concurrent sessions are defined as overlapping sessions:
-- If session 1 starts first, then session 2's start time is greater than or lesser than session 1’s end time.
-- If session 2 starts first, then session 1’s end time is greater than or lesser than session 2’s start time.
-- sessions Table:
-- Column Name	Type
-- session_id	integer
-- start_time	datetime
-- end_time	datetime
-- sessions Example Input:
-- session_id	start_time	end_time
-- 746382	01/02/2022 12:00:00	02/01/2022 16:48:00
-- 143145	01/02/2022 14:25:00	02/01/2022 15:05:00
-- 134514	01/02/2022 15:23:00	02/01/2022 18:15:00
-- 242354	01/02/2022 21:34:00	03/01/2022 00:11:00
-- 143256	01/06/2022 06:55:00	01/06/2022 09:05:00
-- Example Output:
-- session_id	concurrent_sessions
-- 746382	2
-- 143256	1
-- Explanation
-- Session 746382 has 2 concurrent sessions which are session_id 134514 and 242354.

-- Session 746382's end time, 02/01/2022 16:48:00, is before session 134514's end time of 02/01/2022 18:15:00.
-- Session 746382's end time, 02/01/2022 16:48:00, is before session 242354's end time of 03/01/2022 00:11:00.

--use join to define session 2 start time falling in between session 1 start and end time
--count session 2 session ID's by session 1 id
--order by concurrent sessions in descending order

SELECT s1.session_id
, COUNT(s2.session_id) AS concurrent_sessions
FROM sessions s1
JOIN sessions s2
ON s1.session_id != s2.session_id
AND s2.start_time BETWEEN s1.start_time AND s1.end_time
GROUP BY 1
ORDER BY 2 DESC
