{{ config(
    schema='staging',
    materialized='table'
) }}

with source as (
    select *
    from {{ source('Source', 'gov_10a_main_table') }}
)

select
    {{ generate_surrogate_key([
        'freq', 'geo', 'na_item', 'sector', 'unit', 'time_period'
    ]) }} as id,
    *
from source
