{% macro custom_schema_override() %}
    {% if target.name == 'dev' %}
        {{ return(target.schema) }}
    {% else %}
        {{ return('public') }}  {# or some other default schema #}
    {% endif %}
{% endmacro %}
