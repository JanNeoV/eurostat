{{ config(
    materialized='table'
) }}

WITH source_data AS (
    SELECT
        *,


        
            
            {{ generate_dim_surrogate_key_integer(['na_item']) }} AS pk_national_accounts
    FROM
        {{ source('Source', 'national_accounts_indicator') }}
)

SELECT *
FROM
    source_data
