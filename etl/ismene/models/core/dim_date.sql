{{ config(
    schema = 'Core',
    materialized = 'table'
) }}
WITH date_series AS (
    SELECT 
        generate_series(
            '1990-01-01'::date,
            '2025-12-31'::date,
            '1 day'::interval
        )::date AS date_key
),

date_details AS (
    SELECT
        date_key,
        EXTRACT(DAY FROM date_key) AS day,
        EXTRACT(MONTH FROM date_key) AS month,
        TO_CHAR(date_key, 'Month') AS month_name,
        EXTRACT(QUARTER FROM date_key) AS quarter,
        EXTRACT(YEAR FROM date_key) AS year,
        EXTRACT(WEEK FROM date_key) AS week,
        TO_CHAR(date_key, 'Day') AS week_name,
        EXTRACT(DOY FROM date_key) AS day_of_year,
        CASE WHEN TO_CHAR(date_key, 'Day') IN ('Saturday', 'Sunday') THEN TRUE ELSE FALSE END AS is_weekend
    FROM
        date_series
)

SELECT * FROM date_details
