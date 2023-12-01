SELECT
    SUM(headcount),
    time_period,sex,category
FROM
    {{ ref('raw_analysis') }}
    WHERE country = 'Germany'
    AND time_period IN('2009-Q1', '2009', '2009-Q2')

GROUP BY

    time_period,sex,category

    