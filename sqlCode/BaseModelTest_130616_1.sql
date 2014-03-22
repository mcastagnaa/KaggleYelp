SELECT	R.User_id
	, R.Business_id
	, U.average_stars AS avgUserStars 	--get out this
	, B.stars AS avgBusinessStars		--get out this
	, (CASE WHEN U.average_stars >= 0 THEN U.average_stars
		WHEN U.average_stars IS NULL THEN
		(CASE WHEN B.stars >= 0 THEN B.stars
			ELSE 2.5 END) END) AS Stars
FROM	tbl_test_review AS R LEFT JOIN
	tbl_train_user AS U ON (
		R.user_id = U.user_id
		) LEFT JOIN
	tbl_train_business AS B ON (
		R.business_id = B.business_Id
		)

ORDER BY R.Id ASC;		
--SELECT * FROM Estimates;
--Select SQRT(SUM((Estimate - stars) ^ 2)/count(Review_id)) AS RMSE FROM Estimates;

--DROP TABLE Estimates