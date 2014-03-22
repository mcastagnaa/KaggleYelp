-- View: vw_blkstars

-- DROP VIEW vw_blkstars;

CREATE OR REPLACE VIEW vw_blkstars AS

SELECT	ROUND(BU.Latitude, 4) AS RoundLat
	, ROUND(BU.Longitude, 4) AS RoundLon
	, AVG(BU.stars) AS AvgBlkStars
	, COUNT(BU.stars) AS CountBlkStars
	, STDDEV(BU.stars) AS StDevBlkStars
FROM	tbl_train_business AS BU 
GROUP BY ROUND(BU.Latitude, 4), ROUND(BU.Longitude, 4)
;
ALTER TABLE vw_blkstars
  OWNER TO mcastagnaa;



