DROP TABLE tbl_category_bias;

SELECT	C.Category
	, AVG(B.stars-3.67452543988905) AS CategoryBias
	, STDDEV(B.stars) AS CatBiasStDev
	, count(B.stars) AS CatBiasCount
INTO tbl_category_bias
FROM 	tbl_train_business_cat AS C LEFT JOIN
	tbl_train_business AS B ON (
		C.Business_id = B.Business_id
		)
GROUP BY C.Category
--HAVING count(stars) = 1
--ORDER BY STDDEV(B.stars) DESC
;
ALTER TABLE tbl_category_bias
  ADD CONSTRAINT "PK_catBias" PRIMARY KEY(category);