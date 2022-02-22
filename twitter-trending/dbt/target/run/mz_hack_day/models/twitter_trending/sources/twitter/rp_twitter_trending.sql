



CREATE SOURCE 
    materialize.public.rp_twitter_trending

FROM KAFKA BROKER 'redpanda:9092' TOPIC 'trending_data'
  KEY FORMAT BYTES
  VALUE FORMAT BYTES
ENVELOPE UPSERT;