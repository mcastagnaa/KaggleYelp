SELECT	B.review_count
	, AVG(B.stars) AS AvgStarsBRev
	, COUNT(B.stars) AS CountStarsBRev
	, STDDEV(B.stars) AS StDevStarsBRev
FROM 	tbl_train_business AS B
GROUP BY B.review_count
HAVING COUNT(B.stars) > 1
ORDER BY B.review_count
	