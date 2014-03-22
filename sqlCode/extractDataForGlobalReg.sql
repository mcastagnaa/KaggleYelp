SELECT	R.Stars AS X
	, B.Stars AS BizStars
	, (CASE WHEN C.CityBias IS NULL THEN 0 ELSE C.CityBias END) AS CityBias
	, B.review_count AS RevCount
	, (CASE WHEN CH.Checkin_count IS NULL THEN 0 ELSE CH.Checkin_count END) AS CheckCount
	, AVG(CASE WHEN CAT.CategoryBias IS NULL THEN 0 ELSE CAT.CategoryBias END) AS CatBias
	, (CASE WHEN U.User_id IS NULL THEN 0 ELSE (U.average_stars-3.67452543988905) END)::float AS UserBias
	, (CASE WHEN OE.OpenBias IS NULL THEN 0 ELSE OE.OpenBias END) AS OpenBias
	, (CASE LonLat.avgBias WHEN NULL THEN 0 ELSE LonLat.avgBias END) AS LonLatBias
	
FROM	tbl_train_review AS R LEFT JOIN
	tbl_train_business AS B 
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
