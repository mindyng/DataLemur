-- Matching Rental Amenities [Airbnb SQL Interview Question]
-- Description
-- Solution
-- Discussion
-- Submissions
-- Hard

-- Airbnb
-- The Airbnb Booking Recommendations team is trying to understand the "substitutability" of two rentals and whether one rental is a good substitute for another. They want you to write a query to find the unique combination of two Airbnb rentals with the same exact amenities offered.

-- Output the count of the unique combination of Airbnb rentals.

-- Assumptions:

-- If property 1 has a kitchen and pool, and property 2 has a kitchen and pool too, it is a good substitute and represents a unique matching rental.
-- If property 3 has a kitchen, pool and fireplace, and property 4 only has a pool and fireplace, then it is not a good substitute.
-- rental_amenities Table:
-- Column Name	Type
-- rental_id	integer
-- amenity	string
-- rental_amenities Example Input:
-- rental_id	amenity
-- 123	pool
-- 123	kitchen
-- 234	hot tub
-- 234	fireplace
-- 345	kitchen
-- 345	pool
-- 456	pool
-- Example Output:
-- matching_airbnb
-- 1
-- Explanation: The count of matching rentals is 1 as rentals 123 and 345 are a match as they both have a kitchen and a pool.

--aggregate column-wise by rental_id
--self join on amenities
--filter out identical rentals and duplicated rentals e.g. 1/3, 3/1
--output count of rental_id pairs
WITH amenities AS (SELECT rental_id
, ARRAY_AGG(amenity ORDER BY amenity) AS amenities --order by crucial to get apple to apple comparison between rentals
FROM rental_amenities
GROUP BY 1
)

SELECT COUNT(*) AS matching_airbnb
FROM amenities a1
JOIN amenities a2
ON a1.amenities = a2.amenities
WHERE a1.rental_id > a2.rental_id --gets rid of identical rentals and duplicated rentals e.g. 1/3, 3/1
