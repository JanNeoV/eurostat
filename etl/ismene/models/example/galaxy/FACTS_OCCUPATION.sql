SELECT
    sex,
    age,
    country,
    time_period,
    headcount,
    category,
    kpi_label,
    employment_status
FROM {{ref('raw_analysis')}}  WHERE category = 'occupation' AND age in ('Y15-24', 'Y25-49', 'Y50-74')
