
SELECT B.city 
	, B.set
	, B.longitude
	, B.nlongitude
	, N.roundedLongitude
	, B.latitude
	, B.nlatitude
	, N.roundedLatitude
	, N.stars

FROM vw_business AS B LEFT JOIN
	tbl_city_neighb AS N ON (
		N.roundedLongitude = B.nLongitude
		AND N.roundedlatitude = B.nLatitude
		)
WHERE B.set = 'Train'
ORDER BY City