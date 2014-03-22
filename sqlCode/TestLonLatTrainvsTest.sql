DROP TABLE BlkStars
;
SELECT	ROUND(BU.Latitude, 4) AS RoundLat
	, ROUND(BU.Longitude, 4) AS RoundLon
	, AVG(BU.stars) AS AvgBlkStars
	, COUNT(BU.stars) AS CountBlkStars
	, STDDEV(BU.stars) AS StDevBlkStars
INTO TEMP BlkStars
FROM	tbl_train_business AS BU 
GROUP BY ROUND(BU.Latitude, 4), ROUND(BU.Longitude, 4)
--ORDER BY STDDEV(BU.stars) DESC
;

SELECT ROUND(TE.Latitude, 4) AS RoundLatT
	, ROUND(TE.Longitude, 4) AS RoundLonT
	, TR.RoundLat
	, TR.RoundLon
FROM	tbl_test_business AS TE JOIN
	BlkStars AS TR ON (
		TR.RoundLat = ROUND(TE.Latitude, 4)
		AND TR.RoundLon = ROUND(TE.Longitude, 4)
		)
--WHERE TR.RoundLat IS NULL OR TR.RoundLon IS NULL