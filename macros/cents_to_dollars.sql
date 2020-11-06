{% macro cents_to_dollars(cents, decimal_places=2) -%}
    round( 1.0 * {{ cents }} / 100, {{ decimal_places }})
{%- endmacro %}