SELECT 	C.checkin_count
	, count(Bu.business_id) AS numCount
	, AVG(Bu.stars) AS AvgCheckinStars
	, STDDEV(Bu.stars) AS StDevCheckinStars
FROM 	tbl_train_checkin AS C LEFT JOIN
	tbl_train_business AS Bu ON (
		C.business_id = Bu.Business_id
		)

GROUP BY C.Checkin_count
ORDER BY C.Checkin_count