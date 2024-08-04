{{ config(
    schema = 'Core',
    materialized = 'table'
) }}

SELECT
    
        
        {{ generate_dim_surrogate_key_integer(['na_item']) }} AS fk_national_accounts,
    {{ generate_dim_surrogate_key_integer(['geo']) }} AS fk_country,
    {{ generate_dim_surrogate_key_integer(['sector']) }} AS fk_gov_sector,
    {{ generate_dim_surrogate_key_integer(['unit']) }} AS fk_unit,
    time_period AS year,
    obs_value AS value

FROM
    {{ ref('government_finances') }}
