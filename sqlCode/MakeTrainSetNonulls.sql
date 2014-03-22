DROP TABLE tbl_train_set_nonulls;

SELECT business_id
  , review_id
  , user_id
  , stars_x
  , busstars
  , avgopstars
  , avgcitystars
  , avglatstars
  , avglonstars
  , avgblkstars
  , COALESCE(chkstars, (SELECT avg(chkstars) FROM tbl_train_starset)) AS chkstars
  , revcountstars
  , COALESCE(catstars, (SELECT avg(catstars) FROM tbl_train_starset)) AS catstars
  , avgusstars
  , ustotalrevrates
  , COALESCE(ustotalrevfunny, 0) AS ustotalrevfunny
  , COALESCE(ustotalrevuseful, 0) AS ustotalrevuseful
  , COALESCE(ustotalrevcool, 0) AS ustotalrevcool
  , review_count
  , COALESCE(checkin_count, -1) AS checkin_count
  , isopen
  , cityid
  , roundlon
  , roundlat
  , userreview_count
  , catno
  , businblk
INTO tbl_train_set_nonulls
FROM tbl_train_starset
;

ALTER TABLE tbl_train_set_nonulls
  ADD CONSTRAINT "Pk_tbl_train_nonull" PRIMARY KEY(review_id);

ALTER TABLE tbl_train_starset OWNER TO mcastagnaa;
