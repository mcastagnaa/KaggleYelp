-- View: vw_derived_user_votes

DROP VIEW vw_derived_user_votes;

CREATE OR REPLACE VIEW vw_derived_user_votes AS 


SELECT 	RE.user_id
	, COUNT(RE.stars) AS derCountStars
	, AVG(RE.stars) AS derAvgStars
--	, COUNT(REVO.review_id) AS derCountVotes
	, SUM(REVO.funny)+ SUM(REVO.useful) + SUM(REVO.cool) AS derTotRevRat
	, SUM(REVO.funny)::numeric/( 
	CASE WHEN (SUM(REVO.funny)+ SUM(REVO.useful) + SUM(REVO.cool)) = 0 THEN NULL ELSE
		(SUM(REVO.funny)+ SUM(REVO.useful) + SUM(REVO.cool)) END) AS derFunnyPerc
	, SUM(REVO.useful)::numeric/( 
	CASE WHEN (SUM(REVO.funny)+ SUM(REVO.useful) + SUM(REVO.cool)) = 0 THEN NULL ELSE
		(SUM(REVO.funny)+ SUM(REVO.useful) + SUM(REVO.cool)) END) AS derUsefulPerc
	, SUM(REVO.cool)::numeric/( 
	CASE WHEN (SUM(REVO.funny)+ SUM(REVO.useful) + SUM(REVO.cool)) = 0 THEN NULL ELSE
		(SUM(REVO.funny)+ SUM(REVO.useful) + SUM(REVO.cool)) END) AS dercoolPerc
FROM	tbl_train_review AS RE LEFT JOIN
	tbl_train_user AS U ON 
		(RE.user_id = U.user_id) LEFT JOIN
	tbl_train_review_votes AS REVO ON 
		(RE.review_id = REVO.review_id) 
WHERE U.user_id IS NULL
GROUP BY RE.user_id
--HAVING COUNT(RE.stars) <> COUNT(REVO.review_id) checked -> none!

;

ALTER TABLE vw_derived_user_votes
  OWNER TO mcastagnaa;