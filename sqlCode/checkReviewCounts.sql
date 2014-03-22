SELECT	BU.business_id
	, BU.stars
	, BU.review_count
	, COUNT(RE.business_id) AS countfromreviews
	, BU.review_count - COUNT(RE.business_id) AS Difference
/*	, SUM(REV.funny) AS countfunny
	, SUM(REV.useful) AS countuseful
	, SUM(REV.cool) AS countcool*/
FROM	tbl_train_business AS BU LEFT JOIN
	tbl_train_review AS RE ON 
		(BU.business_id = RE.business_id) LEFT JOIN
	tbl_train_review_votes AS REV ON 
		(RE.review_id = REV.review_id)

GROUP BY BU.business_id, BU.stars, BU.review_count
HAVING BU.review_count <> COUNT(RE.business_id)
ORDER BY ABS(BU.review_count - COUNT(RE.business_id)) DESC