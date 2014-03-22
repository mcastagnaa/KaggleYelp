-- View: vw_citystars

DROP VIEW vw_citystars;

CREATE OR REPLACE VIEW vw_citystars AS 
SELECT bu.city
	, C.cityid
	, avg(bu.stars) AS avgcitystars
	, count(bu.stars) AS countcitystars
	, stddev(bu.stars) AS stdevcitystars
FROM tbl_train_business AS bu Left JOIN
	tbl_cities AS C ON 
		(C.city = BU.city)
GROUP BY bu.city, C.Cityid
ORDER BY stddev(bu.stars) DESC;

ALTER TABLE vw_citystars
  OWNER TO mcastagnaa;

