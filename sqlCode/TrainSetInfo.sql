DROP TABLE RawTestCase;

SELECT T.id
	, T.user_Id
	, T.business_Id
	, (CASE WHEN (U.user_id IS NOT NULL) AND (B.business_id IS NOT NULL) THEN 'F'
		WHEN (U.user_id IS NOT NULL) AND (B.business_id IS NULL) THEN 'U'
		WHEN (U.user_id IS NULL) AND (B.business_id IS NOT NULL) THEN 'B'
		WHEN (U.user_id IS NULL) AND (B.business_id IS NULL) THEN 'E'
		ELSE '?' END) AS TestCase
INTO TEMP RawTestCase
FROM tbl_test_review AS T LEFT JOIN
	tbl_train_business AS B ON 
		(B.business_Id = T.business_Id) LEFT JOIN
	tbl_train_user AS U ON 
		(U.user_Id = T.user_Id)
;
/*
SELECT T.*, C.TestCase
FROM tbl_test_review AS T LEFT JOIn
	RawTestCase AS C ON c.id = T.id
	
;

UPDATE tbl_test_review
SET revCase = c.TestCase
FROM RawTestCase AS C
WHERE c.id = tbl_test_review.id
;
SELECT * FROM tbl_test_review
*/