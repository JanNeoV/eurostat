{{ config(
    schema = 'Core',
    materialized = 'table'
) }}

SELECT DISTINCT
    wstatus,
    {{ generate_dim_surrogate_key_integer(['wstatus']) }} AS pk_wstatus
FROM
    {{ ref('employment_union') }}
