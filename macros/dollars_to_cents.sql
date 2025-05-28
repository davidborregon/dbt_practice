{% macro dollars_to_cents(column_name, scale=2) %}
    CAST({{ column_name }} * (POWER(10, {{ scale }})) AS INT)
{% endmacro %}