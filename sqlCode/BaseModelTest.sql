SELECT	R.Review_id
	, R.User_id
	, R.Stars
	, (CASE WHEN U.average_stars >= 0 THEN U.average_stars
		WHEN U.average_stars IS NULL THEN
		(CASE WHEN B.stars >= 0 THEN B.stars
			ELSE 2.5 END) END) AS Estimate
--INTO TEMP Estimates
FROM	tbl_test_review AS R LEFT JOIN
	tbl_test_user AS U ON (
		R.user_id = U.user_id
		) LEFT JOIN
	tbl_test_business AS B ON (
		R.business_id = B.business_Id
		)

ORDER BY R.Id ASC;		
--SELECT * FROM Estimates;
--Select SQRT(SUM((Estimate - stars) ^ 2)/count(Review_id)) AS RMSE FROM Estimates;

--DROP TABLE Estimates