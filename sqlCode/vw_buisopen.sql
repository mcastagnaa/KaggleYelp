-- View: vw_buisopen

DROP VIEW vw_buisopen;

CREATE OR REPLACE VIEW vw_buisopen AS 
SELECT	BU.Open
	, AVG(BU.stars) AS AvgOpStars
	, COUNT(BU.stars) AS CountOpStars
	, STDDEV(BU.stars) AS StDevOpStars
FROM	tbl_train_business AS BU 
GROUP BY BU.Open
;

ALTER TABLE vw_buisopen
  OWNER TO mcastagnaa;
