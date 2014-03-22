SELECT	city
	, AVG(stars-3.67452543988905) AS CityBias
	, STDDEV(stars-3.67452543988905) AS StDevCityB
	, COUNT(city) AS CityCount
INTO tbl_city_bias
FROM tbl_train_business
GROUP BY city
--HAVING count(city) > 1
ORDER BY city
;

/*
UPDATE tbl_test_business
SET city = 'Fountain Hills'
WHERE trim(city) = 'Fountain Hls'
*/