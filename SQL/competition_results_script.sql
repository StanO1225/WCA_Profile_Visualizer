-- Fetches all rows from results where the competitor is between two bounds in the world for 3x3 avg currently, joins with competition info. 

WITH results_top1000 AS
	(WITH top1000 AS 
		(SELECT personID, worldRank 
	       FROM ranksaverage
	      WHERE eventID = '333' AND worldRank > 0 AND worldRank <= 1000)
	SELECT r.competitionId, r.personName, r.personID, r.eventId, 
			ROUND(r.best / 100,2) as best, ROUND(r.average/100,2) as average, ROUND(r.value1/100,2) as solve1, 
            ROUND(r.value2/100,2) as solve2, ROUND(r.value3/100,2) as solve3, ROUND(r.value4/100, 2) as solve4, ROUND(r.value5/100,2) as solve5
	FROM results AS r
	RIGHT JOIN top1000 AS t ON r.personID = t.personID)
SELECT r.*, c.cityName, c.countryId, c.year, c.month, c.day, c.latitude/1000000 as latitude, c.longitude/1000000 as longitude
FROM results_top1000 as r
JOIN competitions as c ON c.id = r.competitionId
ORDER BY personID ASC;
