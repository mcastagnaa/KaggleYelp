SELECT	U.review_count
	, AVG(U.average_stars) AS AvgStarsRev
	, COUNT(U.average_stars) AS CountStarsRev
	, STDDEV(U.average_stars) AS StDevStarsRev
FROM 	tbl_train_user AS U
GROUP BY U.review_count
HAVING COUNT(U.average_stars) > 1
ORDER BY U.review_count
	