DROP TABLE Results;

-- GLOBAL AVERAGE = 3.67452543988905

SELECT	R.id
	, R.revCase
	, R.User_id
	, R.Business_id
	, (CASE R.revCase 
		WHEN 'F' THEN
			(0.7338835485
			- 0.0696170097 * (CASE WHEN C.CityBias IS NULL THEN 0 ELSE C.CityBias END)
			+ 0.0000710016 * B.review_count
			+ 0.0230642039 * AVG(CASE WHEN CAT.CategoryBias IS NULL THEN 0 ELSE CAT.CategoryBias END)
			+ 0.8108838924 * (CASE WHEN U.User_id IS NULL THEN 0 ELSE (U.average_stars-3.67452543988905) END)
			+ 0.7848090311 * B.stars
			+ 0.1176726667 * (CASE WHEN OE.OpenBias IS NULL THEN 0 ELSE OE.OpenBias END)
			)
		WHEN 'B' THEN 
			(0.24536103
			- 0.0044024615 * (CASE WHEN C.CityBias IS NULL THEN 0 ELSE C.CityBias END)
			+ 0.0000500704 * B.review_count
			+ 0.000007188 * (CASE WHEN CH.checkin_count IS NULL THEN 0 ELSE CH.checkin_count END)
			+ 0.0532671402 * AVG(CASE WHEN CAT.CategoryBias IS NULL THEN 0 ELSE CAT.CategoryBias END)
			+ 0.930912075 * B.stars
			+ 0.0276379328 * (CASE WHEN OE.OpenBias IS NULL THEN 0 ELSE OE.OpenBias END)
			+ 0.0270418533 * (CASE WHEN LonLat.avgBias IS NULL THEN 0 ELSE LonLat.avgBias END)
			)
		WHEN 'E' THEN
			(3.7025329202
			- 0.0044024615 * (CASE WHEN C.CityBias IS NULL THEN 0 ELSE C.CityBias END)
			+ 0.0011099835 * B.review_count
			+ 0.00003216756 * (CASE WHEN CH.checkin_count IS NULL THEN 0 ELSE CH.checkin_count END)
			+ 1.0723196384 * AVG(CASE WHEN CAT.CategoryBias IS NULL THEN 0 ELSE CAT.CategoryBias END)
			+ 0.5232829152 * (CASE WHEN OE.OpenBias IS NULL THEN 0 ELSE OE.OpenBias END)
			+ 0.5094130365 * (CASE WHEN LonLat.avgBias IS NULL THEN 0 ELSE LonLat.avgBias END)
			)
		WHEN 'U' THEN
			(3.64108945
			- 0.149097184 * (CASE WHEN C.CityBias IS NULL THEN 0 ELSE C.CityBias END)
			+ 0.0009361307 * B.review_count
			+ 0.8549660797 * AVG(CASE WHEN CAT.CategoryBias IS NULL THEN 0 ELSE CAT.CategoryBias END)
			+ 0.9238184234 * (CASE WHEN U.User_id IS NULL THEN 0 ELSE (U.average_stars-3.67452543988905) END)
			+ 0.0276379328 * (CASE WHEN OE.OpenBias IS NULL THEN 0 ELSE OE.OpenBias END)
			+ 0.0000316113 * (CASE WHEN CH.checkin_count IS NULL THEN 0 ELSE CH.checkin_count END)
			+ 0.392653542 * (CASE WHEN LonLat.avgBias IS NULL THEN 0 ELSE LonLat.avgBias END)
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
	vw_checkin AS CH ON 
		(B.business_id = CH.business_id) LEFT JOIN
	tbl_neigh2_bias AS LonLat ON 
		(round(B.latitude,2) = LonLat.RoundLat
		AND -round(B.longitude,2) = LonLat.RoundLon)

GROUP BY r.id, r.user_id, r.business_id, c.cityBias, b.stars, u.user_id, oe.openbias, lonlat.avgbias
	, CH.checkin_count
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
