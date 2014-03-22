DROP TABLE tbl_open_bias;

SELECT open
	, AVG(stars-3.67452543988905) AS OpenBias
	, stddev(stars)
INTO tbl_open_bias
FROM tbl_train_business
GROUP BY open
;