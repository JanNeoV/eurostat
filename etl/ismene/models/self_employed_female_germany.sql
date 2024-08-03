WITH
    main AS (
        SELECT
            *
        FROM
            {{ref('raw_analysis')}}
        WHERE
            employment_status = 'Self-employed persons'  AND category = 'industry' AND time_period = '2023-Q1'
            AND sex  IN ('M','F')
    ),
    female AS (
        SELECT
            age,
            country,
            kpi_label,
            time_period,
            headcount AS female_headcount
        FROM
            main
        WHERE
            sex = 'F'
        GROUP BY
            age,
            country,
            kpi_label,
            time_period,
            headcount
        ORDER BY
            age,
            country,
            kpi_label,
            time_period,
            headcount
    ),
    total AS (
        SELECT
            age,
            country,
            kpi_label,
            time_period,
            headcount as male_headcount
        FROM
            main
        WHERE
            sex = 'M'
        GROUP BY
            age,
            country,
            kpi_label,
            time_period,
            headcount
    ),
    combined AS (
        SELECT
            a.age,
            a.country,
            a.kpi_label,
            a.time_period,
            a.female_headcount,
            b.male_headcount
        FROM
            female as a
            INNER JOIN total as b on a.age = b.age
            and a.kpi_label = b.kpi_label
            and a.time_period = b.time_period and a.country = b.country
    )
    
SELECT
    kpi_label,age,time_period,female_headcount,male_headcount, country
FROM
    combined WHERE female_headcount >= male_headcount 