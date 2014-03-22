-- View: vw_checkin

DROP VIEW vw_checkin;

CREATE OR REPLACE VIEW vw_checkin AS 
         SELECT 'Train'::text AS set
         , business_id
         , checkin_count
           FROM tbl_train_checkin
UNION ALL
         SELECT 'Test'::text AS set
         , business_id
         , checkin_count
           FROM tbl_test_checkin;

ALTER TABLE vw_checkin
  OWNER TO mcastagnaa;

