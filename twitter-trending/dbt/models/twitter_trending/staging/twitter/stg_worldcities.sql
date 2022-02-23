{{ config(
    materialized='view'
) }}


WITH source AS (
    SELECT * FROM {{ ref('worldcities') }}
)

SELECT * FROM source
