WITH source_data AS (
    SELECT
        *,

        LEFT(time_period, 4) as time_period_date
    FROM  {{ref('raw_analysis')}} 
),

raw AS(
SELECT
    sex,
    age,
    country,
        time_period_date as time_period,
    AVG(headcount) as headcount,
    category,
    kpi_label,
    employment_status
FROM source_data WHERE category = 'industry' GROUP BY  sex,
    age,
    country,
    category,
    kpi_label,
    employment_status,
    time_period_date
    UNION ALL SELECT * FROM {{ref('HELP_INDUSTRY_AGE_25_49')}} )
    SELECT * FROM raw
