{#
Generic test to verify that a number-type column only has positive values.
Returns all rows with values <= 0
#}

{% test positive_values(model, column_name) %}

select {{ column_name }}
from {{ model }}
where {{ column_name }} <= 0

{% endtest %}