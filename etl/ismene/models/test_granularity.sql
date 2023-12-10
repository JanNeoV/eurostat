WITH source_data AS (
    SELECT
        DISTINCT age
    FROM
        {{ ref('raw_analysis') }} 

),
industry_prep AS (
    SELECT
        DISTINCT age,
        category
    FROM
        {{ ref('raw_analysis') }}
    WHERE
        category = 'industry'

),
education_prep AS (
    SELECT
        DISTINCT age,
        category
    FROM
        {{ ref('raw_analysis') }}
    WHERE
        category = 'education'

),
occupation_prep AS (
    SELECT
        DISTINCT age,
        category
    FROM
        {{ ref('raw_analysis') }}
    WHERE
        category = 'occupation'

),
industry_comb AS (
    SELECT
        A.age,
        b.category AS industry_label
    FROM
        source_data AS A full
        OUTER JOIN industry_prep AS b
        ON A.age = b.age
),
education_comb AS (
    SELECT
        A.age,
        A.industry_label,
        b.category AS education_label
    FROM
        industry_comb AS A full
        OUTER JOIN education_prep AS b
        ON A.age = b.age
),
occupation_comb AS (
    SELECT
        A.age,
        A.industry_label,
        A.education_label,
        b.category AS occupation_label
    FROM
        education_comb AS A full
        OUTER JOIN occupation_prep AS b
        ON A.age = b.age
)
SELECT
    *
FROM
    occupation_comb
    -- WHERE industry_label IS NOT NULL AND occupation_label IS NOT NULL AND education_label IS NOT NULL  
