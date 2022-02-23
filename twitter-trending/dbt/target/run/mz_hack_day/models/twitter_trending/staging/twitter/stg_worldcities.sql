create view "materialize"."public"."stg_worldcities"
  as (
    


WITH source AS (
    SELECT * FROM "materialize"."public"."worldcities"
)

SELECT * FROM source
  );