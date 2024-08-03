{{ config(
    materialized='table'
) }}

with source as (
    select *
    from {{ source('Source', 'self_employment_by_occupation_raw') }}
)

select
    {{ generate_surrogate_key([
        'age', 'freq', 'geo', 'isco08', 'sex', 'unit', 'wstatus', 'time_period'
    ]) }} as id,
    *
from source
