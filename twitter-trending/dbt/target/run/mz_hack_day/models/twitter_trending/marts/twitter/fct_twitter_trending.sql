create materialized view "materialize"."public"."fct_twitter_trending"
  as (
    


SELECT location_name, location_country, trends
FROM "materialize"."public"."stg_twitter_trending"
  );