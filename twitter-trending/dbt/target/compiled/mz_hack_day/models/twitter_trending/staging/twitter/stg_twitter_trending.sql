/*

The purpose of this model is to create a flight_information staging model
with light transformations on top of the source.

*/




WITH source AS (
    SELECT * FROM "materialize"."public"."rp_twitter_trending"
),
converted AS (
    SELECT convert_from(data, 'utf8') AS data FROM source
),
casted AS (
    SELECT cast(data AS jsonb) AS data FROM converted
),
renamed AS (
    SELECT

       (data->'location'->'name')::string as location_name,
       (data->'location'->'country')::string as location_country,
       (data->'trends'->0->'trends')::jsonb as trends
    FROM casted
),
final AS (
    SELECT
        location_name,
        location_country,
        trends
    FROM renamed
)

SELECT * FROM final