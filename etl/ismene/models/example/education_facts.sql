WITH source_data AS (
    SELECT
        *,

        TO_DATE(time_period, 'YYYY-"Q"Q') as time_period_date
    FROM  {{ref('raw_analysis')}} 
)

SELECT
    sex,
    age,
    country,
    time_period,
    headcount,
    category,
    kpi_label,
    employment_status,
    time_period_date
FROM source_data WHERE category = 'education'
