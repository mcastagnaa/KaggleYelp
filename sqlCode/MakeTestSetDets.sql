DROP TABLE tbl_test_starset;

SELECT RE.review_id
	, RE.user_id
	, RE.business_id
	, NULL::float AS stars_x
	, BU.stars::float AS busStars
	, OP.avgOpstars::float 
	, CI.avgcitystars::float 
	, null::float as avglatstars
	, null::float as avglonstars
	, BLK.avgblkstars::float AS avgblkStars
	, (CASE WHEN BU.checkin_count > 2000 THEN NULL
		ELSE 3.6435116493 + 0.0002650573 * BU.checkin_count END)::float AS ChkStars
	, (3.6766639432 + 0.0009885431 * BU.review_count)::float AS revCountStars
	, CA.catstars::float AS catStars
	, COALESCE(US.average_stars,DUS.deravgstars)::float AS avgUsStars
	, COALESCE(US.totrevrat, DUS.dertotrevrat)::float AS ustotalrevrates
	, COALESCE(US.funnyperc, DUS.derfunnyperc)::float AS ustotalrevfunny
	, COALESCE(US.usefulperc, DUS.derusefulperc)::float AS ustotalrevuseful
	, COALESCE(US.coolperc, DUS.dercoolperc)::float AS ustotalrevcool
	, BU.review_count::float
	, BU.checkin_count::float
	, (CASE BU.open WHEN TRUE then 1 WHEN FALSE then 0 ELSE NULL END)::float 
		AS IsOpen
	, CI.cityid::float
	, BU.nLongitude::float AS roundLon 
	, BU.nLatitude::float AS roundLat
	, COALESCE(US.review_count, DUS.dercountstars)::float 
		AS UserReview_count
	, CA.catno::float
	, BLK.countblkstars::float AS BusInBlk
	, COALESCE(BU.set, 'Cold') AS businessSet
	, COALESCE(US.set, 'Cold') AS userSet

INTO tbl_test_starset

FROM	tbl_test_review AS RE LEFT JOIN
	vw_business AS BU ON
		(BU.business_id = RE.business_id) LEFT JOIN
	vw_user AS US ON
		(US.user_id = RE.user_id) LEFT JOIN
	vw_blkstars AS BLK ON 
		(BU.nlongitude = BLK.roundlon 
		AND BU.nlatitude = BLK.roundlat) LEFT JOIN
	vw_avgstrcat AS CA ON
		(BU.business_id = CA.business_id) LEFT JOIN
	vw_buisopen AS OP ON
		(BU.open = OP.open) LEFT JOIN
	vw_citystars AS CI ON 
		(BU.city = CI.city) LEFT JOIN
	vw_derived_user_votes AS DUS ON 
		(RE.user_id = DUS.user_id)
;

ALTER TABLE tbl_test_starset ADD PRIMARY KEY (review_id);