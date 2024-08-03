{{ config(
    schema = 'Core',
    materialized = 'table'
) }}

SELECT
    DISTINCT geo,
    {{ generate_dim_surrogate_key_integer(['geo']) }} AS pk_country
FROM
    {{ ref('employment_union') }}
