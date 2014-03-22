
--DROP TABLE Estimates;

-- GLOBAL AVERAGE = 3.67452543988905

SELECT	R.Review_id
	, R.User_id
	, R.Stars AS RevStars
	, B.Stars AS BizStars
	, 0.7338835485
	- 0.0696170097 * (CASE WHEN C.CityBias IS NULL THEN 0 ELSE C.CityBias END)
	+ 0.0000710016 * B.review_count
	+ 0 * (CASE WHEN CH.Checkin_count IS NULL THEN 0 ELSE CH.Checkin_count END)
	+ 0.0230642039 * AVG(CASE WHEN CAT.CategoryBias IS NULL THEN 0 ELSE CAT.CategoryBias END)
	+ 0.8108838924 * (CASE WHEN U.User_id IS NULL THEN 0 ELSE (U.average_stars-3.67452543988905) END)
	+ 0.1176726667 * (CASE WHEN OE.OpenBias IS NULL THEN 0 ELSE OE.OpenBias END)
	+ 0.7848090311 * B.stars
	+ 0 * (CASE LonLat.avgBias WHEN NULL THEN 0 ELSE LonLat.avgBias END) 
	 AS eStars
	 
INTO TEMP Estimates
FROM	tbl_train_review AS R LEFT JOIN
	vw_business AS B 
		ON (R.business_id = B.business_Id) LEFT JOIN 
	tbl_city_bias AS C 
		ON (B.City = C.City) LEFT JOIN
	tbl_train_business_cat AS CATid 
		ON (CATid.business_id = B.business_id) LEFT JOIN
	tbl_category_bias AS CAT 
		ON (CATid.category = CAT.category) LEFT JOIN
	tbl_train_user AS U ON 
		(R.user_id = U.user_id) LEFT JOIN
	tbl_open_bias AS OE ON 
		(B.open = OE.open) LEFT JOIN 
	tbl_train_checkin AS CH ON
		(B.business_id = CH.business_id) LEFT JOIN
	tbl_neigh2_bias AS LonLat ON 
		(round(B.latitude,2) = LonLat.RoundLat
		AND -round(B.longitude,2) = LonLat.RoundLon)
		
GROUP BY r.review_id, c.cityBias, b.review_count
	, b.stars, u.user_id, oe.openbias, ch.checkin_count
	, lonlat.avgbias
;		

--SELECT BizStars, RevStars FROM Estimates

Select SQRT(SUM((
	(CASE 	WHEN eStars <= 1 THEN 1 
		WHEN eStars >= 5 THEN 5 
		ELSE ROUND(eStars::numeric,2) END)
		- RevStars) ^ 2)/count(Review_id)) AS RMSE
	, (229907 - SUM(CASE WHEN eStars IS NULL THEN 0 ELSE 1 END)) AS Errors
FROM Estimates;
