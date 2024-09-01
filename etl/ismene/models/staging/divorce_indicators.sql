    SELECT 
*
    FROM 
        {{ source('Source', 'divorces_by_country_of_birth_of_wife_and_husband') }}