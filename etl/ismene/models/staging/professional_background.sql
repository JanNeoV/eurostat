WITH source_data AS (
    SELECT
        *,
        {{ generate_dim_surrogate_key_integer(['token']) }} AS pk_employment_background
    FROM
        {{ ref('employment_mapping_reference') }}
)
SELECT
    *
FROM
    source_data
