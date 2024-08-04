{{ config(
    schema = 'Mart',
    materialized = 'table'
) }}

WITH na_filter AS (
    SELECT
        pk_national_accounts,
        na_item
    FROM
        {{ ref('dim_national_accounts') }}
    WHERE
        na_item IN (
            'D2REC',
            'D5REC',
            'D91REC',
            'D61REC',
            'D4REC',
            'D7REC',
            'D39REC',
            'D92_D99REC',
            'P11_P12_P131'
        )
),

sector_filter AS (
    SELECT
        pk_government_sector,
        sector
    FROM
        {{ ref('dim_gov_sector') }}
    WHERE
        sector = 'S13'
),

filtered_facts AS (
    -- CTE to join the fact table with the filtered dimension tables
    SELECT total_accounts.*
    FROM
        {{ ref('fact_government_accounts') }} AS total_accounts
    INNER JOIN
        sector_filter AS sectors
        ON total_accounts.fk_gov_sector = sectors.pk_government_sector
    INNER JOIN
        na_filter AS na
        ON
            total_accounts.fk_national_accounts
            = na.pk_national_accounts
)

-- Final select to retrieve the filtered fact table
SELECT *
FROM
    filtered_facts


/*
WITH BASE AS (
    SELECT * FROM {{ ref('government_finances') }}
     WHERE na_item IN (
'D2REC'
,'D5REC'
,'D91REC'
,'D61REC'
,'D4REC'
,'D7REC'
,'D39REC'
,'D92_D99REC'
, 'P11_P12_P131'
) AND sector

TOTAL AS (
    SELECT
        'total' AS INDICATOR
        , na_item
        , SUM(OBS_VALUE) AS VALUE
        , sector AS blubb
    FROM BASE GROUP BY na_item, sector

)
,
PARTS AS (
    SELECT
        DISTINCT na_item FROM Base
        ORDER BY na_item ASC
)
SELECT SUM(VALUE) FROM TOTAL WHERE na_item IN (
'D2REC'
,'D5REC'
,'D91REC'
,'D61REC'
,'D4REC'
,'D7REC'
,'D39REC'
,'D92_D99REC'
, 'P11_P12_P131'


) AND blubb = 'S13'
*/

/*
SELECT SUM(VALUE) FROM TOTAL WHERE na_item IN ('P2'
,'D1PAY'
,'D41PAY'
,'D3PAY'
,'D62_D632PAY'
,'D29PAY'
,'D5PAY'
,'D42PAY'
,'D43PAY'
,'D44PAY'
,'D45PAY'
,'D7PAY'
,'D8'
,'D9PAY'
,'OP5ANP'
) AND blubb = 'S13'
--UNION ALL
--SELECT * FROM PARTS */
