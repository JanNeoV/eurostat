{{ config(
    schema = 'Mart',
    materialized = 'table'
) }}

WITH 
sector_filter AS (
    SELECT
        pk_government_sector,
        sector
    FROM
        {{ ref('dim_gov_sector') }}
    WHERE
        sector = 'S13'
),

filtered_facts AS (
    -- CTE to join the fact table with the filtered dimension tables
    SELECT total_accounts.*
    FROM
        {{ ref('fact_government_accounts') }} AS total_accounts
    INNER JOIN
        sector_filter AS sectors
        ON total_accounts.fk_gov_sector = sectors.pk_government_sector
)

SELECT *
FROM
    filtered_facts
