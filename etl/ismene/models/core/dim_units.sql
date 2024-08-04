{{ config(
    schema = 'Core',
    materialized = 'table'
) }}

SELECT DISTINCT
    unit,
    {{ generate_dim_surrogate_key_integer(['unit']) }} AS pk_unit

FROM
    {{ ref('government_finances') }}
