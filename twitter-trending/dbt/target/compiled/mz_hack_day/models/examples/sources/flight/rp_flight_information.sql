



CREATE SOURCE 
    materialize.public.rp_flight_information

FROM KAFKA BROKER 'redpanda:9092' TOPIC 'flight_information'
  KEY FORMAT BYTES
  VALUE FORMAT BYTES
ENVELOPE UPSERT;