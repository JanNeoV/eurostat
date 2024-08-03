WITH
    main AS (
        SELECT
            *
        FROM
            {{ref('raw_analysis')}}
        WHERE
            employment_status = 'Self-employed persons' AND category = 'industry'
            AND sex = 'M'
            OR sex = 'F'
    ),
    female AS (
        SELECT
            country,
            kpi_label,
            time_period,
            SUM(headcount) AS female_headcount
        FROM
            main
        WHERE
            sex = 'F'
        GROUP BY
            country,
            kpi_label,
            time_period
        ORDER BY
            country,
            kpi_label,
            time_period
    ),
    total AS (
        SELECT
            country,
            kpi_label,
            time_period,
            MAX(headcount) AS male_headcount
        FROM
            main
        WHERE
            sex = 'M'
        GROUP BY
            country,
            kpi_label,
            time_period
    ),
    combined AS (
        SELECT
            a.country,
            a.kpi_label,
            a.time_period,
            a.female_headcount,
            b.male_headcount
        FROM
            female as a
            INNER JOIN total as b on a.country = b.country
            and a.kpi_label = b.kpi_label
            and a.time_period = b.time_period
    )
SELECT
    *
FROM
    combined
WHERE
    female_headcount >= male_headcount