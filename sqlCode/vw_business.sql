-- View: vw_business

--DROP VIEW vw_business;

CREATE OR REPLACE VIEW vw_business AS 
         SELECT 'Train'::text AS set
         , BU.city
         , BU.review_count
         , CHK.checkin_count
         --, COALESCE(CHK.checkin_count,0) AS checkin_count
         --, BU.name
         , BU.business_id
         --, BU.full_address
         --, BU.state
         , BU.longitude
         , BU.latitude
         , round(BU.longitude, 4) AS nlongitude
         , round(BU.latitude, 4) AS nlatitude
         , BU.stars
         , BU.open
           FROM tbl_train_business AS BU LEFT JOIN
		tbl_train_checkin AS CHK ON 
		(BU.business_id = CHK.business_id)
UNION ALL
         SELECT 'Test'::text AS set
         , BU.city
         , BU.review_count
         , CHK.checkin_count
         --, COALESCE(CHK.checkin_count,0) AS checkin_count
         --, name
         , BU.business_id
         --, full_address
         --, state
         , BU.longitude
         , BU.latitude
         , round(BU.longitude, 4) AS nlongitude
         , round(BU.latitude, 4) AS nlatitude
         , BU.stars
         , BU.open
           FROM tbl_test_business AS BU LEFT JOIN
		tbl_test_checkin AS CHK ON 
		(BU.business_id = CHK.business_id)
;
ALTER TABLE vw_business
  OWNER TO mcastagnaa;

