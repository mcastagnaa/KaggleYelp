SELECT 	(CASE WHEN CHK.checkin_count IS NULL THEN 0 ELSE CHK.checkin_count END) AS ChkCount
	, AVG(BU.stars) AS AvgChkCountSt
	, COUNT(BU.stars) AS CountChkCountSt
	, STDDEV(BU.stars) AS StDevChkCountSt
FROM	tbl_train_business AS BU FULL JOIN
	tbl_train_checkin AS CHK ON 
		(BU.business_id = CHK.business_id)
GROUP BY CHK.checkin_count
HAVING COUNT(BU.stars) > 1
ORDER BY CHK.checkin_count DESC


