{{ config(
    schema = 'Core',
    materialized = 'table'
) }}

SELECT
    label AS professional_background,
    category
    ,

    
        
        {{ generate_dim_surrogate_key_integer(['token']) }} AS pk_professional_background
FROM
    {{ ref('professional_background') }}
