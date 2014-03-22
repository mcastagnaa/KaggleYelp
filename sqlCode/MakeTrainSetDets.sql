/*-- TO DO: 

*/

DROP TABLE tbl_train_starset;

--DROP TABLE LatStars;
--DROP TABLE LonStars;

SELECT	ROUND(BU.Latitude, 4) AS RoundLat
	, AVG(BU.stars) AS AvgLatStars
	, COUNT(BU.stars) AS CountLatStars
	, STDDEV(BU.stars) AS StDevLatStars
INTO TEMP LatStars
FROM	tbl_train_business AS BU 
GROUP BY ROUND(BU.Latitude, 4)
ORDER BY STDDEV(BU.stars) DESC
;

SELECT	ROUND(BU.Longitude, 4) AS RoundLon
	, AVG(BU.stars) AS AvgLonStars
	, COUNT(BU.stars) AS CountLonStars
	, STDDEV(BU.stars) AS StDevLonStars
INTO TEMP LonStars
FROM	tbl_train_business AS BU 
GROUP BY ROUND(BU.Longitude, 4)
ORDER BY STDDEV(BU.stars) DESC
;

/*
SELECT	'LatSD', AVG(StDevLatStars) FROM LatStars
UNION
SELECT	'LonSD', AVG(StDevLonStars) FROM LonStars
UNION
SELECT	'BlkSD', AVG(StDevBlkStars) FROM BlkStars
;
*/

SELECT	RE.business_id
	, RE.review_id
	, RE.user_id
	, RE.stars::float AS stars_X
	, BU.stars::float AS BusStars
	, OP.AvgOpStars::float
	, CI.AvgCityStars::float
	, LA.AvgLatStars::float
	, LO.AvgLonStars::float
	, BK.AvgBlkStars::float
	, (CASE WHEN BU.checkin_count > 2000 THEN NULL
		ELSE 3.6435116493 + 0.0002650573 * BU.checkin_count END)::float AS ChkStars
	, 3.6766639432 + 0.0009885431 * BU.review_count::float AS RevCountStars
	, CA.CatStars::float
	, COALESCE(US.average_stars, USD.deravgstars)::float AS AvgUsStars
	, COALESCE(US.totrevrat, USD.dertotrevrat)::float AS ustotalrevrates
	, COALESCE(US.funnyperc, USD.derfunnyperc)::float AS ustotalrevfunny
	, COALESCE(US.usefulperc, USD.derusefulperc)::float AS ustotalrevuseful
	, COALESCE(US.coolperc, USD.dercoolperc)::float AS ustotalrevcool
	, BU.review_count::float
	, BU.checkin_count::float
	, (CASE BU.open WHEN TRUE then 1 WHEN FALSE then 0 ELSE NULL END)::float AS IsOpen
	, CI.cityid::float
	, LO.roundLon::float
	, LA.roundLat::float
	, COALESCE(US.review_count, USD.dercountstars)::float AS UserReview_count
	, CA.catno::float
	, BK.countblkstars::float AS BusInBlk
INTO	tbl_train_starset
	
FROM	tbl_train_review AS RE LEFT JOIN
	vw_business AS BU ON 
		(BU.business_id = RE.business_id) LEFT JOIN
	vw_buisopen AS OP ON 
		(OP.open = BU.open) LEFT JOIN
	vw_citystars AS CI ON
		(BU.city = CI.City) LEFT JOIN
	LonStars AS LO ON
		(BU.nlongitude = LO.roundLon) LEFT JOIN
	LatStars AS LA ON
		(BU.nlatitude = LA.roundLat) LEFT JOIN
	vw_blkstars AS BK ON 
		(BU.nlatitude = BK.roundLat AND BU.nlongitude = BK.roundLon) LEFT JOIN
	vw_avgstrcat AS CA ON (BU.business_id = CA.business_id) LEFT JOIN
	vw_user AS US ON (RE.user_id = US.user_id) LEFT JOIN
	vw_derived_user_votes AS USD ON (RE.user_id = USD.user_id)
WHERE RE.review_id <> 'smqH4bR-l29YZunwhGKtIQ'
;

ALTER TABLE tbl_train_starset
  ADD CONSTRAINT "Pk_tbl_train_set" PRIMARY KEY(review_id);


/*SELECT AVG(ChkStars) FROM  tbl_train_starset
SELECT AVG(CatStars) FROM  tbl_train_starset

UPDATE tbl_train_starset
SET CatStars = 3.61163268752831
WHERE CatStars IS NULL

UPDATE tbl_train_starset
SET ChkStars = 3.7200616837118925
WHERE ChkStars IS NULL*/

/*SELECT	max(user_id), max(business_id)
FROM tbl_train_review
GROUP BY user_id, business_id
HAVING COUNT(review_id) > 1

SELECT * FROM tbl_train_review
WHERE user_id = 'q9XgOylNsSbqZqF_SO3-OQ'
	AND business_id = 'jlH7V4ktlu_OyLqqTm2c1A'
		
SELECT * FROM tbl_train_review_votes
WHERE review_id = 'smqH4bR-l29YZunwhGKtIQ' OR review_id ='KPf0qikDOISdxkUUtgdWuQ'
*/
