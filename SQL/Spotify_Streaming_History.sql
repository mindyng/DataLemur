-- Spotify Streaming History [Spotify SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Medium

-- Spotify
-- You're given two tables on Spotify users' streaming data. songs_history table contains the historical streaming data and songs_weekly table contains the current week's streaming data.

-- Write a query to output the user id, song id, and cumulative count of song plays as of 4 August 2022 sorted in descending order.

-- Definitions:

-- song_weekly table currently holds data from 1 August 2022 to 7 August 2022.
-- songs_history table currently holds data up to to 31 July 2022. The output should include the historical data in this table.
-- Assumption:

-- There may be a new user or song in the songs_weekly table not present in the songs_history table.
-- songs_history Table:
-- Column Name	Type
-- history_id	integer
-- user_id	integer
-- song_id	integer
-- song_plays	integer
-- songs_history Example Input:
-- history_id	user_id	song_id	song_plays
-- 10011	777	1238	11
-- 12452	695	4520	1
-- song_plays: Refers to the historical count of streaming or song plays by the user.

-- songs_weekly Table:
-- Column Name	Type
-- user_id	integer
-- song_id	integer
-- listen_time	datetime
-- songs_weekly Example Input:
-- user_id	song_id	listen_time
-- 777	1238	08/01/2022 12:00:00
-- 695	4520	08/04/2022 08:00:00
-- 125	9630	08/04/2022 16:00:00
-- 695	9852	08/07/2022 12:00:00
-- Example Output:
-- user_id	song_id	song_plays
-- 777	1238	12
-- 695	4520	2
-- 125	9630	1
-- As of 4 August 2022,

-- User 777 has listened to the song_id 1238 for 12 times which is 11 times historically and 1 time within the week.
-- User 695's streaming of the song_id 9852 is excluded from the output because the streaming date on 8 August 2022 is out of the question requirement.

--big idea: per user get historial and current wks song count of songs up to 8.4.22
--COUNT weekly songs per user only up to 8.4.22
--union ALL (historical and weekly count of song/user can be the same) both tables
--SUM song counts per user

WITH cte AS (
SELECT user_id
, song_id
, song_plays
FROM songs_history
UNION ALL
(SELECT user_id
, song_id
, COUNT(song_id) AS song_plays 
FROM songs_weekly 
WHERE listen_time <= '08/04/2022 23:59:59'
GROUP BY 1
, 2)
)

SELECT user_id
, song_id
, SUM(song_plays) AS song_plays
FROM cte 
GROUP BY 1
, 2
ORDER BY 3 DESC
