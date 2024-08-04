{{ config(
    materialized='table'
) }}

WITH source_data AS (
    SELECT
        *,


        
            
            {{ generate_dim_surrogate_key_integer(['sector']) }} AS pk_government_sector
    FROM
        {{ source('Source', 'government_sectors') }}
)

SELECT *
FROM
    source_data
