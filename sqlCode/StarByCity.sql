SELECT 	Bu.city
	, count(Bu.business_id) AS numCount
	, AVG(Bu.stars) AS AvgCityStars
	, STDDEV(Bu.stars) AS StDevCityStars
FROM 	tbl_train_business AS Bu 

GROUP BY city
ORDER BY city