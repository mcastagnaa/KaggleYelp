SELECT 	B.category
	, count(B.business_id) AS numCount
	, AVG(Bu.stars) AS AvgBuStars
	, STDDEV(Bu.stars) AS StDevBuStars
FROM 	tbl_train_business_cat AS B LEFT JOIN
	tbl_train_business AS Bu ON (
		B.business_id = Bu.Business_id
		)
GROUP BY category
ORDER BY category