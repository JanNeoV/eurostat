{{ config(
    materialized='table'
) }}

WITH source_data AS (
    SELECT
        *,
        {{ generate_dim_surrogate_key_integer(['geo']) }} AS pk_countries
    FROM
        {{ source('Source', 'geo_country_mapping') }}
)

SELECT *
FROM
    source_data
