{% macro generate_md5_surrogate_key_integer(field_list) -%}
    {%- set default_null_value = '0' -%}
    {%- set fields = [] -%}

    {%- for field in field_list -%}
        {%- do fields.append(
            "coalesce(" ~ field ~ ", '" ~ default_null_value ~ "')"
        ) -%}
    {%- endfor -%}

    -- Use only a portion of the MD5 hash to avoid bigint overflow
    -- this is just another option to create the desired key since the other option will only work for postgres
    -- just as before, the loop above ensures concatenating the input fields and hashes them
    -- howerver, md5 generates a 32 character hexadecimal string (128-bit-value) based on the input. this is way too large
    -- bigint is only 64 bit which is why we take fewer characters of the resulting hash that will be cast to bigint
    abs(cast(('0x' || left(md5({{ dbt.concat(fields) }}), 9)) as bigint)) % 1000000000
{%- endmacro %}
