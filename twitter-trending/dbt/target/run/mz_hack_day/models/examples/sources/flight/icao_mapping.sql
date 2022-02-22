



CREATE SOURCE 
    materialize.public.icao_mapping

FROM FILE '/tmp/icao24_mapping_airbus.json.gz' COMPRESSION GZIP
FORMAT BYTES;