{{ config(
    schema = 'Core',
    materialized = 'table'
) }}

SELECT
    {{ generate_dim_surrogate_key_integer(['age']) }} AS fk_age,
    {{ generate_dim_surrogate_key_integer(['geo']) }} AS fk_country,
    {{ generate_dim_surrogate_key_integer(['wstatus']) }} AS fk_wstatus,


    
        
        {{ generate_dim_surrogate_key_integer(['token']) }} AS fk_professional_background,
    kpi_value * 1000 AS headcount
FROM
    {{ ref('employment_union') }}
