{{ config(
    materialized ='materializedview'
) }}


SELECT location_name, location_country, trends
FROM {{ ref('stg_twitter_trending') }}
