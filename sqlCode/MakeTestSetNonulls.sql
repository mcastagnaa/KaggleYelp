
--DROP TABLE averages;
SELECT 	AVG(avgblkstars) AS avgBlkStars
	, AVG(chkStars) AS avgChkStars
	, AVG(catStars) AS avgCatStars
	, ROUND(AVG(checkin_count::numeric), 0) AS avgCheckinCount

INTO TEMP averages
FROM tbl_test_starset
;


UPDATE tbl_test_starset
SET catStars = COALESCE(catStars, (SELECT avgcatStars FROM averages))
, userReview_count = COALESCE(userReview_count, -1) 	-- No in train
, chkStars = COALESCE(chkStars, (SELECT avgChkStars FROM averages))
, checkin_count = COALESCE(checkin_count, -1)
, avgblkStars = COALESCE(avgblkstars, 
		(SELECT avgBlkStars FROM averages)) 	-- No in train
, businblk = COALESCE(businblk, -1)	 		-- No in train
, busStars = COALESCE(busStars, -1)			-- No in train
, avgusStars = COALESCE(avgusStars,-1)			-- No in train
, ustotalrevrates = COALESCE(ustotalrevrates, -1)	-- No in train
, ustotalrevfunny = COALESCE(ustotalrevfunny, 0)
, ustotalrevuseful = COALESCE(ustotalrevuseful, 0)
, ustotalrevcool = COALESCE(ustotalrevcool, 0)
--, revCountStars = (SELECT avgrevCountStars FROM averages)
;

