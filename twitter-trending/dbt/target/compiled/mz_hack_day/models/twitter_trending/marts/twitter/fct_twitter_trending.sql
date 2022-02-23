

with ranked_trends as (
    select tt.location_name
         , tt.location_country
         , tt.trend_name
         , tt.trend_volume
         , tt.trend_as_of as trend_date
         , wc.lat::float as location_latitude
         , wc.lng::float as location_longitude
         , ROW_NUMBER() over (partition by tt.woeid order by tt.trend_volume desc) as trend_rank
from "materialize"."public"."stg_twitter_trending" tt
    left join "materialize"."public"."stg_worldcities" wc
on tt.location_name = wc.city and tt.location_country = wc.country
where tt.trend_volume > 0
    )

select location_name, location_country, trend_volume, trend_name, location_latitude, location_longitude, trend_date
from ranked_trends
where trend_rank = 1