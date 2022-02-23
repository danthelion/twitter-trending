/*

The purpose of this model is to create a flight_information staging model
with light transformations on top of the source.

*/

{{ config(
    materialized='view'
) }}


WITH source AS (
    SELECT * FROM {{ ref('rp_twitter_trending') }}
),
converted AS (
    SELECT convert_from(data, 'utf8') AS data FROM source
),
casted AS (
    SELECT cast(data AS jsonb) AS data FROM converted
),
renamed AS (
    SELECT
       (data->'location'->>'name')::string as location_name,
       (data->'location'->>'country')::string as location_country,
       (data->'location'->>'woeid')::string as woeid,
       (data->'trends'->0->'trends')::jsonb as trends,
       (data->'trends'->0->>'as_of')::timestamp as trend_as_of
    FROM casted
),
final AS (
    SELECT
        location_name,
        location_country,
        woeid,
        jsonb_array_elements(trends)->>'name' as trend_name,
        TRIM(jsonb_array_elements(trends)->>'tweet_volume')::integer as trend_volume,
        trend_as_of
    FROM renamed
)

SELECT * FROM final
