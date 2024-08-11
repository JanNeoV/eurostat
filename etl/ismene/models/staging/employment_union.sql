{{ config(
    schema = 'Staging',
    materialized = 'table'
) }}

WITH union_tables AS (

    SELECT
        age,
        geo,
        sex,
        wstatus,
        time_period,
        obs_value AS kpi_value,
        isced11 AS token,
        'education' AS category
    FROM
        {{ source('Source', 'self_employment_by_education_raw') }} WHERE obs_value IS NOT NULL
    UNION ALL
    SELECT
        age,
        geo,
        sex,
        wstatus,
        time_period,
        obs_value AS kpi_value,
        isco08 AS token,
        'occupation' AS category
    FROM
        {{ source('Source', 'self_employment_by_occupation_raw') }} WHERE obs_value IS NOT NULL
    UNION ALL 
    SELECT
        age,
        geo,
        sex,
        wstatus,
        SPLIT_PART(time_period, '-', 1)::INT AS time_period,
        SUM(obs_value) AS kpi_value,
        nace_r2 AS token,
        'industry' AS category
    FROM
        {{ source('Source', 'self_employment_by_industry_raw') }} WHERE obs_value IS NOT NULL GROUP BY age, geo, sex, wstatus, token, time_period, category
)

SELECT * FROM union_tables
