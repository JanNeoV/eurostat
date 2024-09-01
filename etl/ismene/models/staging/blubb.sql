    SELECT 
    DISTINCT geo
    , sex,obs_value, age
        --obs_value, geo
    FROM
        {{ source('Source', 'first_marriage_rates_by_age_and_sex') }}
        WHERE time_period = 2010
        AND geo = 'DE_TOT'
        --AND geo = 'DE'
        ORDER BY obs_value DESC
        --AND age = 'Y35-39' OR age = 'Y30-34'

