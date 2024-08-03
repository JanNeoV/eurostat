{% macro custom_schema_macro() %}
    {% if target.name == 'dev' %}
        {# Example logic to return schema based on directory name #}
        {% if var('schema_name_override', none) %}
            {{ return(var('schema_name_override')) }}
        {% else %}
            {{ return(target.schema) }}
        {% endif %}
    {% else %}
        {{ return(target.schema) }}
    {% endif %}
{% endmacro %}
