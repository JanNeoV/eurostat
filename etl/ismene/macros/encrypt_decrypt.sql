{% macro hash_or_keep(column) %}
    {% if target.name == 'dev' %}
        md5({{ column }})
    {% else %}
        {{ column }}
    {% endif %}
{% endmacro %}
