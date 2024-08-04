{{ config(
    schema = 'Core',
    materialized = 'table'
) }}

SELECT
    na_item,
    mapping AS label,
    pk_national_accounts
FROM
    {{ ref('national_accounts') }}
