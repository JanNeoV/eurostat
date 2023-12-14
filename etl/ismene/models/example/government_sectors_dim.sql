SELECT DISTINCT sector, CASE WHEN sector = 'S1' THEN 'TOTAL economy'
WHEN sector = 'S13' THEN 'GENERAL GOVERNMENT'
WHEN sector = 'S1311' THEN 'Central government'
WHEN sector = 'S1312' THEN 'State government'
WHEN sector = 'S1313' THEN 'Local government'
WHEN sector = 'S1314' THEN 'Social security funds'
WHEN sector = 'S212' THEN 'Institutions of the EU'

ELSE NULL END AS sector_mapping
 FROM eurostat_stag.gov_10a_main_table