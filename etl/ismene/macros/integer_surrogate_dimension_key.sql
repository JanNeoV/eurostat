{% macro generate_dim_surrogate_key_integer(field_list) -%}
    {%- set default_null_value = '0' -%}
    {%- set fields = [] -%}

    {%- for field in field_list -%}
        {%- do fields.append(
            "coalesce(" ~ field ~ ", '" ~ default_null_value ~ "')"
        ) -%}
    {%- endfor -%}

    -- Use hashtext to generate an integer directly
    -- hashtext is a postgres specific function that generates has of the input text & returns it as bigint
    -- this macro basically loops over all the input fields, concatenates them and applies the hashtext function directly
    -- last part ensures that the resulting key has 9 digits
    abs(hashtext({{ dbt.concat(fields) }})) % 1000000000 
{%- endmacro %}
