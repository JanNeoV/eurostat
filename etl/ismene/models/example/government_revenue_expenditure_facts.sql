SELECT
        geo,
        na_item,
        time_period,unit,
        obs_value :: numeric AS VALUE
FROM
    eurostat_stag.gov_10a_main_table
WHERE
    sector = 'S13'
    AND unit IN (
        'MIO_EUR',
        'PC_GDP'
    )
    AND na_item IN (
        'TE',
        'TR',
        'B9'
    )
    AND obs_value IS NOT NULL
    AND geo NOT IN (
        'EA19',
        'EA20',
        'EU27_2020'
    )