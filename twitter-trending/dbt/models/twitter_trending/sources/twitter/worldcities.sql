{{ config(materialized='source') }}

{% set source_name %}
    {{ mz_generate_name('worldcities') }}
{% endset %}

CREATE SOURCE {{ source_name }}
FROM FILE '/tmp/worldcities.csv' COMPRESSION NONE
FORMAT CSV WITH HEADER
DELIMITED BY '|';