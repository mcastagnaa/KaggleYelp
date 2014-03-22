--DROP TABLE cityNeibStars;
DROP TABLE tbl_neigh2_bias;

SELECT 	round(latitude,2) AS roundLat
	, round(abs(longitude), 2) AS roundLon
	, stars
INTO TEMP cityNeibStars
from tbl_train_business
;

SELECT roundLat
	, roundLon
	, (avg(stars) - 3.67452543988905) AS avgBias
	, count(stars)
	, stddev(stars)
INTO tbl_neigh2_bias
FROM cityNeibStars
GROUP BY roundLat, roundLon
--HAVING count(stars) > 1
--ORDER BY stddev(stars) DESC
;

ALTER TABLE tbl_neigh2_bias
  ADD CONSTRAINT "PK_LocBias" PRIMARY KEY(roundLon,roundLat);
