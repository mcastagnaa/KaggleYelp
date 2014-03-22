DROP TABLE Estimates;
DROP TABLE CityEffect;
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
	, avg(stars-3.67452543988905) AS CityBias
--	, count(stars)
INTO TEMP CityEffect
FROM tbl_train_business
GROUP BY city
HAVING count(stars) > 1
--ORDER BY avg(stars)
;

SELECT	C.Category
	, AVG(B.stars-3.67452543988905) AS CategoryBias
--	, count(B.stars)
INTO TEMP CategoryEffect
FROM 	tbl_train_business_cat AS C LEFT JOIN
	tbl_train_business AS B ON (
		C.Business_id = B.Business_id
		)
GROUP BY C.Category
HAVING count(stars) > 1
;

/*SELECT	review_count
	, ((3.6766639432 + 0.0009885431 * review_count) - 3.67452543988905) AS ReviewBias
	, count(review_count)
INTO TEMP ReviewCountEffect
FROM tbl_train_business
GROUP BY review_count
HAVING count(stars) > 1;
--ORDER BY avg(stars)*/

SELECT	R.Review_id
	, R.User_id
	, R.Stars
	, (3.67452543988905 
	+ (CASE WHEN C.CityBias IS NULL THEN 0 ELSE C.CityBias END)
	+ ((3.6766639432 + 0.0009885431 * B.review_count) - 3.67452543988905)
	--+ 0*((3.6887788888 + 0.0001212259 * 
	--	 ELSE CH.Checkin_count END)) - 3.67452543988905)
	+ AVG(CASE WHEN CAT.CategoryBias IS NULL THEN 0 ELSE CAT.CategoryBias END)
	+ (CASE WHEN U.User_id IS NULL THEN 0 ELSE 
		(U.average_stars-3.67452543988905) END)
	+ (CASE WHEN OE.OpenBias IS NULL THEN 0	ELSE OE.OpenBias END)
	--+ (CASE WHEN N.stars IS NULL THEN 0 ELSE (N.stars-3.67452543988905) END) 
	+ (B.stars-3.67452543988905)) AS eStars
INTO TEMP Estimates
FROM	tbl_train_review AS R LEFT JOIN
	vw_business AS B 
		ON (R.business_id = B.business_Id) LEFT JOIN 
	--tbl_city_neighb AS N 
	--	ON (N.roundedLatitude = B.nlatitude AND N.roundedLongitude = B.nlongitude) LEFT JOIN
	CityEffect AS C 
		ON (B.City = C.City) LEFT JOIN
	tbl_train_business_cat AS CATid 
		ON (CATid.business_id = B.business_id) LEFT JOIN
	CategoryEffect AS CAT 
		ON (CATid.category = CAT.category) LEFT JOIN
	tbl_train_user AS U ON 
		(R.user_id = U.user_id) LEFT JOIN
	OpenEffect AS OE ON 
		(B.open = OE.open) --LEFT JOIN 
	--vw_checkin AS CH ON 
		--(B.business_id = CH.business_id)
		
GROUP BY r.review_id, c.cityBias, b.review_count, b.stars, u.user_id, oe.openbias
--, ch.checkin_count
--, n.stars
;		

--SELECT *, ROUND(eStars::numeric,0) FROM Estimates WHERE eStars IS NULL;
Select SQRT(SUM((
	(CASE 	WHEN eStars <= 1 THEN 1 
		WHEN eStars >= 5 THEN 5 
		ELSE ROUND(eStars::numeric,2) END)
		- stars) ^ 2)/count(Review_id)) AS RMSE
	, (229907 - SUM(CASE WHEN eStars IS NULL THEN 0 ELSE 1 END)) AS Errors
FROM Estimates;

--DROP TABLE Estimate