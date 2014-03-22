DROP TABLE CityEffect;
DROP TABLE Results;
DROP TABLE CategoryEffect;
DROP TABLE OpenEffect;

-- GLOBAL AVERAGE = 3.67452543988905

SELECT open
	, AVG(stars-3.67452543988905) AS OpenBias
	--, stddev(stars)
INTO TEMP OpenEffect
FROM tbl_train_business
GROUP BY open
;

SELECT	city
	, AVG(stars-3.67452543988905) AS CityBias
INTO TEMP CityEffect
FROM tbl_train_business
GROUP BY city
HAVING count(stars) > 1
;

SELECT	C.Category
	, AVG(B.stars-3.67452543988905) AS CategoryBias
INTO TEMP CategoryEffect
FROM 	tbl_train_business_cat AS C LEFT JOIN
	tbl_train_business AS B ON (C.Business_id = B.Business_id)
GROUP BY C.Category
HAVING count(stars) > 1
;

SELECT	R.id
	, R.User_id
	, R.Business_id
	, (3.67452543988905 
	+ (CASE WHEN C.CityBias IS NULL THEN 0 ELSE C.CityBias END)
	+ ((3.6766639432 + 0.0009885431 * B.review_count) - 3.67452543988905)
	+ (CASE WHEN N.stars IS NULL THEN 0 ELSE (N.stars-3.67452543988905) END) 
	+ (CASE WHEN CH.checkin_count IS NULL THEN 0 ELSE 
		((3.6887788888 + 0.0001212259 * CH.checkin_count) - 3.67452543988905)
		END)
	+ AVG(CASE WHEN CAT.CategoryBias IS NULL THEN 0 ELSE CAT.CategoryBias END)
	+ (CASE WHEN U.User_id IS NULL THEN 0 
		ELSE (U.average_stars - 3.67452543988905) END )
	+ (CASE WHEN OE.OpenBias IS NULL THEN 0 ELSE OE.OpenBias END) 	
	+ (CASE WHEN B.stars IS NULL THEN 0 ELSE (B.stars -3.67452543988905) END)
		) AS Stars

INTO TEMP Results
FROM	tbl_test_review AS R LEFT JOIN
	tbl_train_user AS U ON 
		(R.user_id = U.user_id) LEFT JOIN
	vw_business AS B ON 
		(R.business_id = B.business_Id) LEFT JOIN
	CityEffect AS C ON 
		(B.City = C.City) LEFT JOIN
	tbl_train_business_cat AS CATid ON 
		(CATid.business_id = B.business_id) LEFT JOIN
	CategoryEffect AS CAT ON 
		(CATid.category = CAT.category) LEFT JOIN
	OpenEffect AS OE ON 
		(B.open = OE.open) LEFT JOIN
	vw_checkin AS CH ON 
		(B.business_id = CH.business_id) LEFT JOIN 
	tbl_city_neighb AS N ON 
	(N.roundedLatitude = B.nlatitude AND N.roundedLongitude = B.nlongitude)

GROUP BY r.id, r.business_id, c.cityBias, b.review_count, b.stars, u.user_id, oe.openbias
	, CH.checkin_count, n.stars
;

SELECT	User_id
	, Business_id
	, (CASE WHEN stars > 5 THEN 5
		WHEN stars < 0 THEN 0 
		ELSE stars END) AS stars
FROM Results
--WHERE stars is null
ORDER BY Id ASC;	
