    SELECT
        age,
        geo,
        sex,
        wstatus,
        nace_r2 AS token,
        SPLIT_PART(time_period, '-', 1)::INT AS time_period,
        SUM(obs_value) AS kpi_value,
        'industry' AS category
    FROM
        {{ source('Source', 'self_employment_by_industry_raw') }} WHERE obs_value IS NOT NULL GROUP BY age, geo, sex, wstatus, token, time_period, category