-- Checksumme

SELECT *, obs_value::NUMERIC as value_ FROM eurostat_stag.gov_10a_main_table WHERE geo = 'DE' AND sector = 'S13' AND unit = 'MIO_EUR' AND na_item = 'D2REC'