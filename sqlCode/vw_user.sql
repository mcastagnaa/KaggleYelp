-- View: vw_user

DROP VIEW vw_user;

CREATE OR REPLACE VIEW vw_user AS 
         SELECT 'Train'::text AS set
		, U.user_id
		, U.average_stars
		, U.review_count
		, U.name
		, (V.funny + V.useful + V.cool) AS totRevRat
		, (V.funny::numeric)/
		(CASE WHEN (V.funny + V.useful + V.cool) = 0 
			THEN NULL
			ELSE (V.funny + V.useful + V.cool) END) AS funnyPerc
		, (V.useful::numeric)/
		(CASE WHEN (V.funny + V.useful + V.cool) = 0 
			THEN NULL
			ELSE (V.funny + V.useful + V.cool) END) AS usefulPerc
		, (V.cool::numeric)/
		(CASE WHEN (V.funny + V.useful + V.cool) = 0 
			THEN NULL
			ELSE (V.funny + V.useful + V.cool) END) coolPerc
		
           FROM tbl_train_user AS U LEFT JOIN
		tbl_train_user_votes AS V ON 
			(U.user_id = V.user_id)
UNION ALL
         SELECT 'Test'::text AS set
		, U.user_id
		, NULL::numeric AS average_stars
		, U.review_count
		, U.name
		, NULL::numeric AS totRevRat
		, NULL::numeric AS funnyPerc
		, NULL::numeric AS usefulPerc
		, NULL::numeric AS coolPerc
		
           FROM tbl_test_user AS U
;

ALTER TABLE vw_user
  OWNER TO mcastagnaa;

