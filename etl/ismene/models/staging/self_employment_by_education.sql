{{ config(
    schema='staging',
    materialized='table'
) }}

with source as (
    select *
    from {{ source('Source', 'self_employment_by_education_raw') }}
)

select
    {{ generate_surrogate_key([
        'age', 'freq', 'geo', 'isced11', 'sex', 'unit', 'wstatus', 'time_period'
    ]) }} as id,
    *
from source
