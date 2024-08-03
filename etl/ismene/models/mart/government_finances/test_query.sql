SELECT age, country, SUM(headcount) FROM
    {{ ref('one_big_tabel_raw') }} WHERE time_period = '2010' AND category = 'industry' GROUP BY age, country