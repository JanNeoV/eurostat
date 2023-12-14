WITH main AS(
    SELECT
        geo,
        na_item,
        time_period,unit,
        obs_value :: numeric AS VALUE
    FROM
        eurostat_stag.gov_10a_main_table
    WHERE
        sector = 'S13'
        AND  unit IN ('MIO_EUR','PC_GDP')
        AND na_item IN (
            'TE',
            'TR',
            'B9'
        )
        AND obs_value IS NOT NULL
),
main_expense AS(
    SELECT
        geo,
        na_item,
        time_period,unit,
        obs_value :: numeric AS VALUE
    FROM
        eurostat_stag.gov_10a_main_table
    WHERE
        sector = 'S13'
        AND unit IN ('MIO_EUR','PC_GDP')
    AND na_item IN (
        'P2',
        'D1PAY',
        'D41PAY',
        'D3PAY',
        'D62_D632PAY',
        'OP5ANP',
        'D9PAY' -- other current expenditure f
    )
),
main_ AS (
    SELECT
        geo,
        na_item,
        time_period,unit,
        obs_value :: numeric AS VALUE
    FROM
        eurostat_stag.gov_10a_main_table
    WHERE
        sector = 'S13'
        AND unit IN ('MIO_EUR','PC_GDP')
        AND na_item IN (
            'TE',
            'TR',
            'B9'
        )
        AND obs_value IS NOT NULL
),
other_categories AS (
    SELECT
        geo,
        na_item,
        time_period,unit,
        obs_value :: numeric AS VALUE
    FROM
        eurostat_stag.gov_10a_main_table
    WHERE
        sector = 'S13'
        AND unit IN ('MIO_EUR','PC_GDP')
    AND na_item IN (
        'P2',
        'D1PAY',
        'D41PAY',
        'D3PAY',
        'D62_D632PAY',
        'OP5ANP',
        'D9PAY' -- other current expenditure f
    )
),
other_category_ AS (
    SELECT
        m.geo,
        'other_expenditure' AS na_item,
        m.time_period,m.unit,
        (m.value - COALESCE(o.value, 0)) AS VALUE
    FROM
        main_ m
        LEFT JOIN (
            SELECT
                geo,
                'other_expenditure' AS na_item,
                time_period,unit,
                SUM(
                    VALUE :: numeric
                ) AS VALUE
            FROM
                other_categories
            GROUP BY
                geo,
                time_period,unit
        ) o
        ON m.geo = o.geo
        AND m.time_period = o.time_period AND m.unit = o.unit
    WHERE
        m.na_item = 'TE'
),
everything_combined AS(
    SELECT
        *
    FROM
        main_expense
    UNION ALL
    SELECT
        *
    FROM
        other_category_
)
SELECT
    *
FROM everything_combined WHERE geo NOT IN ('EA19',
'EA20','EU27_2020')