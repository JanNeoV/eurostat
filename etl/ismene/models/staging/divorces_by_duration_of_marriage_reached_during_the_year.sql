WITH marriages AS (
    SELECT 
        c_birth AS country_of_birth_wife, 
        partner AS country_of_birth_husband, 
        obs_value AS number_of_marriages,
        geo AS place_of_marriage,
        time_period
    FROM 
        {{ source('Source', 'marriages_by_country_of_birth_of_bride_and_groom') }}
    WHERE geo NOT IN ('TOTAL', 'NAT', 'UNK', 'NEU27_2020_FOR', 'UNK', 'TOTAL', 'FOR', 'EU28_FOR')
           -- AND c_birth NOT IN ('TOTAL', 'NAT', 'UNK', 'NEU27_2020_FOR', 'FOR', 'EU28_FOR', 'NEU28_FOR', 'EU27_2007_FOR', 'NEU27_2007_FOR', 'EU27_2020_FOR')
        --AND partner NOT IN ('TOTAL', 'NAT', 'UNK', 'NEU27_2020_FOR', 'FOR', 'EU28_FOR', 'NEU28_FOR', 'EU27_2007_FOR', 'NEU27_2007_FOR', 'EU27_2020_FOR')
),
divorces AS (
    SELECT 
        c_birth AS country_of_birth_wife, 
        partner AS country_of_birth_husband, 
        COALESCE(obs_value, NULL) AS number_of_divorces,
        geo AS place_of_divorce,
        time_period
    FROM 
        {{ source('Source', 'divorces_by_country_of_birth_of_wife_and_husband') }}
    WHERE geo NOT IN ('TOTAL', 'NAT', 'UNK', 'NEU27_2020_FOR', 'UNK', 'TOTAL', 'FOR', 'EU28_FOR')
           -- AND c_birth NOT IN ('TOTAL', 'NAT', 'UNK', 'NEU27_2020_FOR', 'FOR', 'EU28_FOR', 'NEU28_FOR', 'EU27_2007_FOR', 'NEU27_2007_FOR', 'EU27_2020_FOR')
       -- AND partner NOT IN ('TOTAL', 'NAT', 'UNK', 'NEU27_2020_FOR', 'FOR', 'EU28_FOR', 'NEU28_FOR', 'EU27_2007_FOR', 'NEU27_2007_FOR', 'EU27_2020_FOR')
)

SELECT 
    m.country_of_birth_wife, 
    m.country_of_birth_husband, 
    m.number_of_marriages,
    d.number_of_divorces,
    m.time_period,
    CASE
        WHEN m.number_of_marriages = 0 THEN 0
        WHEN d.number_of_divorces = 0 THEN 0
        ELSE CAST(d.number_of_divorces AS FLOAT) / m.number_of_marriages * 100
    END AS divorce_rate,
    m.place_of_marriage
FROM 
    marriages m
INNER JOIN 
    divorces d
ON 
    m.country_of_birth_wife = d.country_of_birth_wife
    AND m.country_of_birth_husband = d.country_of_birth_husband
    AND m.place_of_marriage = d.place_of_divorce
    AND m.time_period = d.time_period
    AND m.number_of_marriages IS NOT NULL
    AND d.number_of_divorces IS NOT NULL

ORDER BY 
    divorce_rate DESC
