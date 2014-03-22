UPDATE tbl_test_business AS B
SET latitude = A.latitude, longitude = A.longitude
FROM tbl_train_business_amd AS A 
WHERE (B.business_id = A.business_id)
;
SELECT B.business_id
	, B.latitude, A.latitude
	, B.longitude, A.longitude
FROM tbl_test_business AS B LEFT JOIN
	tbl_train_business_amd AS A ON 
		(B.business_id = A.business_id)
;	