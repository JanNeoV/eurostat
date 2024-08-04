{{ config(
    schema = 'Core',
    materialized = 'table'
) }}

SELECT *
FROM
    {{ ref('government_sectors_total') }}
