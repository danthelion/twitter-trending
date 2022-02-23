



CREATE SOURCE 
    materialize.public.worldcities

FROM FILE '/tmp/worldcities.csv' COMPRESSION NONE
FORMAT CSV WITH HEADER
DELIMITED BY '|';