WITH source_data AS (
    SELECT
        *,
        TO_DATE(
            time_period,
            'YYYY-"Q"Q'
        ) AS time_period_date
    FROM
        {{ ref('raw_analysis') }}
),
y_ge_total AS(
    SELECT
        sex,
        country,
        time_period,
        headcount AS headcount_total,
        category,
        kpi_label,
        employment_status,
        time_period_date
    FROM
        source_data
    WHERE
        category = 'industry'
        AND age = 'Y_GE25'
),
y_ge_part AS(
    SELECT
        sex,
        country,
        time_period,
        headcount AS headcount_part,
        category,
        kpi_label,
        employment_status,
        time_period_date
    FROM
        source_data
    WHERE
        category = 'industry'
        AND age = 'Y_GE50'
),
RANDOM AS (
    SELECT
        A.*,
        b.headcount_part
    FROM
        y_ge_total AS A
        INNER JOIN y_ge_part AS b
        ON A.sex = b.sex
        AND A.country = b.country
        AND A.time_period = b.time_period
        AND A.kpi_label = b.kpi_label
        AND A.employment_status = b.employment_status
),
total_join AS(
    SELECT
        sex,
        'Y25-49' AS age,
        country,
        LEFT(
            time_period,
            4
        ) AS time_period,
        headcount_total - headcount_part AS headcount,
        category,
        kpi_label,
        employment_status,
        time_period_date
    FROM
        RANDOM
)
SELECT
    sex,
    age,
    country,
    time_period,
    AVG(headcount) AS headcount,
    category,
    kpi_label,
    employment_status
FROM
    total_join
GROUP BY
    sex,
    age,
    country,
    category,
    kpi_label,
    employment_status,
    time_period
