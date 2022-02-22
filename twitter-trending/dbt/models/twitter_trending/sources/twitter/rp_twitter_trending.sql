{{ config(materialized='source') }}

{% set source_name %}
    {{ mz_generate_name('rp_twitter_trending') }}
{% endset %}

CREATE SOURCE {{ source_name }}
FROM KAFKA BROKER 'redpanda:9092' TOPIC 'trending_data'
  KEY FORMAT BYTES
  VALUE FORMAT BYTES
ENVELOPE UPSERT;