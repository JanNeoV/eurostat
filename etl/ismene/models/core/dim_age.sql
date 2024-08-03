{{ config(
    schema = 'Core',
    materialized = 'table'
) }}

SELECT
    DISTINCT age,
    {{ generate_dim_surrogate_key_integer(['age']) }} AS pk_age
FROM
    {{ ref('employment_union') }}
