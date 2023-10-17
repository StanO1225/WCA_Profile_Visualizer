-- Gets rankings for all events for cubers that are in the top 1000 for 3x3 avg.
SELECT a.personID, a.eventId, a.worldRank AS world_avg, s.worldRank as world_single
FROM ranksaverage as a
JOIN rankssingle as s
ON a.personID = s.personID AND a.eventId = s.eventId
WHERE a.personID IN (SELECT personID 
					   FROM ranksaverage
                       WHERE eventID = '333' AND worldRank <= 1000)
ORDER BY personID ASC;