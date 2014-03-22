SELECT 'busstars'
, SUM(CASE WHEN busstars IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(busstars) AS MAX
	, MIN(busstars) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'avgopstars'
	, SUM(CASE WHEN avgopstars IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(avgopstars) AS MAX
	, MIN(avgopstars) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'avgcitystars'
	, SUM(CASE WHEN avgcitystars IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(avgcitystars) AS MAX
	, MIN(avgcitystars) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'avglatstars'
, SUM(CASE WHEN avglatstars IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(avglatstars) AS MAX
	, MIN(avglatstars) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'avglonstars'
, SUM(CASE WHEN avglonstars IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(avglonstars) AS MAX
	, MIN(avglonstars) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'avgblkstars'
, SUM(CASE WHEN avgblkstars IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(avgblkstars) AS MAX
	, MIN(avgblkstars) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'chkstars'
, SUM(CASE WHEN chkstars IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(chkstars) AS MAX
	, MIN(chkstars) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'revcountstars'
, SUM(CASE WHEN revcountstars IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(revcountstars) AS MAX
	, MIN(revcountstars) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'catstars'
, SUM(CASE WHEN catstars IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(catstars) AS MAX
	, MIN(catstars) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'avgusstars'
, SUM(CASE WHEN avgusstars IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(avgusstars) AS MAX
	, MIN(avgusstars) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'ustotalrevrates'
, SUM(CASE WHEN ustotalrevrates IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(ustotalrevrates) AS MAX
	, MIN(ustotalrevrates) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'ustotalrevfunny'
, SUM(CASE WHEN ustotalrevfunny IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(ustotalrevfunny) AS MAX
	, MIN(ustotalrevfunny) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'ustotalrevuseful'
, SUM(CASE WHEN ustotalrevuseful IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(ustotalrevuseful) AS MAX
	, MIN(ustotalrevuseful) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'ustotalrevcool'
, SUM(CASE WHEN ustotalrevcool IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(ustotalrevcool) AS MAX
	, MIN(ustotalrevcool) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'review_count'
, SUM(CASE WHEN review_count IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(review_count) AS MAX
	, MIN(review_count) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'checkin_count'
, SUM(CASE WHEN checkin_count IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(checkin_count) AS MAX
	, MIN(checkin_count) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'isopen'
, SUM(CASE WHEN isopen IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(isopen) AS MAX
	, MIN(isopen) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'cityid'
, SUM(CASE WHEN cityid IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(cityid) AS MAX
	, MIN(cityid) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'roundlon'
, SUM(CASE WHEN roundlon IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(roundlon) AS MAX
	, MIN(roundlon) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'roundlat'
, SUM(CASE WHEN roundlat IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(roundlat) AS MAX
	, MIN(roundlat) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'userreview_count'
, SUM(CASE WHEN userreview_count IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(userreview_count) AS MAX
	, MIN(userreview_count) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'catno'
, SUM(CASE WHEN catno IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(catno) AS MAX
	, MIN(catno) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset

UNION ALL
SELECT 'businblk'
, SUM(CASE WHEN businblk IS NULL THEN 1 ELSE 0 END) AS NULLS
	, MAX(businblk) AS MAX
	, MIN(businblk) AS MIN
	, businessset
	, userset
FROM tbl_test_starset
GROUP BY businessset, userset
--ORDER BY NULLS DESC


