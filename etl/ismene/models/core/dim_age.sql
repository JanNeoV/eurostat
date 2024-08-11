{{ config(
    schema = 'Core',
    materialized = 'table'
) }}

SELECT DISTINCT
    {{ hash_or_keep('age') }} AS age,
    {{ generate_dim_surrogate_key_integer(['age']) }} AS pk_age
FROM
    {{ ref('employment_union') }}
