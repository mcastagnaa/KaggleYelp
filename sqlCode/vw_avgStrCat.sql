-- View: vw_avgStrCat

DROP VIEW vw_avgStrCat;

CREATE OR REPLACE VIEW vw_avgStrCat AS 
         SELECT 'Train'::text AS set
         , BU.business_id
	 , COUNT(BUC.category) AS CatNo
         , AVG(CA.avgcatstars) AS CatStars
	 , AVG(CA.countcatStars) AS avgCount
	 FROM tbl_train_business AS BU LEFT JOIN
		tbl_train_business_cat AS BUC ON 
			(BU.business_id = BUC.business_id) LEFT JOIN
		tbl_category_stars AS CA ON 
			(BUC.category = CA.category)
	GROUP BY BU.business_id
UNION ALL
         SELECT 'Test'::text AS set
         , BU.business_id
	 , COUNT(BUC.category) AS CatNo
         , AVG(CA.avgcatstars) AS CatStars
	 , AVG(CA.countcatStars) AS avgCount
	 FROM	tbl_test_business AS BU LEFT JOIN
		tbl_test_business_cat AS BUC ON 
			(BU.business_id = BUC.business_id) LEFT JOIN
		tbl_category_stars AS CA ON 
			(BUC.category = CA.category)
	 GROUP BY BU.business_id
         
;
ALTER TABLE vw_business
  OWNER TO mcastagnaa;
