{{ config(
    schema = 'Mart',
    materialized = 'table'
) }}

WITH age_filter AS (
    SELECT
        pk_age,
        age
    FROM
        {{ ref('dim_age') }}
    WHERE
        age IN ('Y15-24', 'Y25-49', 'Y50-74')
),

category_filter AS (
    SELECT
        pk_professional_background,
        category
    FROM
        {{ ref('dim_professional_background') }}
    WHERE
        category = 'occupation'
),

filtered_facts AS (
    -- CTE to join the fact table with the filtered dimension tables
    SELECT total_employed.*
    FROM
        {{ ref('fact_employment') }} AS total_employed
    INNER JOIN
        age_filter AS af
        ON total_employed.fk_age = af.pk_age
    INNER JOIN
        category_filter AS cf
        ON
            total_employed.fk_professional_background
            = cf.pk_professional_background
)

-- Final select to retrieve the filtered fact table
SELECT *
FROM
    filtered_facts
