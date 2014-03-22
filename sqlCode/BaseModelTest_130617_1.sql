DROP TABLE CityEffect;
DROP TABLE Results;
--DROP TABLE CategoryEffect;

-- GLOBAL AVERAGE = 3.67452543988905

SELECT	city
	, avg(stars-3.67452543988905) AS CityBias
--	, count(stars)
INTO TEMP CityEffect
FROM tbl_train_business
GROUP BY city
HAVING count(stars) > 1;
--ORDER BY avg(stars)

/*SELECT	C.Category
	, avg(B.stars-3.67452543988905) AS CategoryBias
--	, count(B.stars)
INTO TEMP CategoryEffect
FROM 	tbl_train_business_cat AS C LEFT JOIN
	tbl_train_business AS B ON (
		C.Business_id = B.Business_id
		)
GROUP BY C.Category
HAVING count(stars) > 1
*/

SELECT	R.id
	, R.User_id
	, R.Business_id
	, (CASE WHEN B.stars >= 0 THEN B.stars
		WHEN B.stars IS NULL THEN (
		3.67452543988905 
		+ (CASE WHEN C.CityBias IS NULL THEN 0 ELSE C.CityBias END)
		+ ((3.6766639432 + 0.0009885431 * 
			(CASE WHEN B.review_count IS NULL THEN TB.review_count ELSE B.review_count END)
			) - 3.67452543988905) 
		--+ SUM(CASE WHEN CAT.CategoryBias IS NULL THEN 0 ELSE CAT.CategoryBias END)*0
		+ (CASE WHEN U.User_id IS NULL THEN 0 ELSE (U.average_stars-3.67452543988905) END)
		) END ) AS Stars
INTO TEMP Results
FROM	tbl_test_review AS R LEFT JOIN
	tbl_train_user AS U ON (
		R.user_id = U.user_id
		) LEFT JOIN
	tbl_train_business AS B ON (
		R.business_id = B.business_Id
		) LEFT JOIN
	CityEffect AS C ON (
		B.City = C.City
		) LEFT JOIN
	tbl_test_business AS TB ON (
		R.business_id = TB.business_Id
		)
;

SELECT	User_id
	, Business_id
	, (CASE WHEN stars > 5 THEN 5
		WHEN stars < 0 THEN 0 
		ELSE stars END) AS stars
FROM Results
ORDER BY Id ASC;	
