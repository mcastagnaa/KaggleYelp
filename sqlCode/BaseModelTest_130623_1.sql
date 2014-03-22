DROP TABLE Results;

-- GLOBAL AVERAGE = 3.67452543988905

SELECT	R.id
	, R.revCase
	, R.User_id
	, R.Business_id
	, 3.67452543988905 
		+ (CASE R.revCase 
		WHEN 'F' THEN
			(
			(B.stars-3.67452543988905) 
			+ (U.average_stars-3.67452543988905) 
			+ OE.OpenBias
			)
		WHEN 'B' THEN 
			(B.stars-3.67452543988905)
		WHEN 'E' THEN
			(
			0.5 * (CASE WHEN C.CityBias IS NULL THEN 0 ELSE C.CityBias END)
			+ ((3.6766639432 + 0.0009885431 * B.review_count) - 3.67452543988905)
			+ AVG(CASE WHEN CAT.CategoryBias IS NULL THEN 0 ELSE CAT.CategoryBias END)
			+ (CASE WHEN OE.OpenBias IS NULL THEN 0 ELSE OE.OpenBias END)
			+ 0.5 * (CASE WHEN LonLat.avgBias IS NULL THEN 0 ELSE LonLat.avgBias END)
			)
		WHEN 'U' THEN
			(
			0.5 * (CASE WHEN C.CityBias IS NULL THEN 0 ELSE C.CityBias END)
			+ AVG(CASE WHEN CAT.CategoryBias IS NULL THEN 0 ELSE CAT.CategoryBias END)
			+ (CASE WHEN OE.OpenBias IS NULL THEN 0 ELSE OE.OpenBias END)
			+ 0.5 * (CASE WHEN LonLat.avgBias IS NULL THEN 0 ELSE LonLat.avgBias END)
			+ (U.average_stars-3.67452543988905)
			)
		END) AS Stars

INTO TEMP Results
FROM	tbl_test_review AS R LEFT JOIN
	tbl_train_user AS U ON 
		(R.user_id = U.user_id) LEFT JOIN
	vw_business AS B ON 
		(R.business_id = B.business_Id) LEFT JOIN
	tbl_city_bias AS C ON 
		(B.City = C.City) LEFT JOIN
	tbl_train_business_cat AS CATid ON 
		(CATid.business_id = B.business_id) LEFT JOIN
	tbl_category_bias AS CAT ON 
		(CATid.category = CAT.category) LEFT JOIN
	tbl_open_bias AS OE ON 
		(B.open = OE.open) LEFT JOIN
	--vw_checkin AS CH ON 
	--	(B.business_id = CH.business_id) LEFT JOIN
	tbl_neigh2_bias AS LonLat ON 
		(round(B.latitude,2) = LonLat.RoundLat
		AND -round(B.longitude,2) = LonLat.RoundLon)

GROUP BY r.id, r.user_id, r.business_id, c.cityBias, b.stars, u.user_id, oe.openbias, lonlat.avgbias
	--, CH.checkin_count
	--, n.stars
	, b.review_count
;

SELECT	User_id
	--, revcase
	, Business_id
	, (CASE WHEN stars >= 5 THEN 5
		WHEN stars <= 1 THEN 1 
		ELSE round(stars::numeric, 2) END) AS stars
FROM Results
--WHERE stars is null
ORDER BY Id ASC;	
