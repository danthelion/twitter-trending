# Twitter Trending Data Generator

The `twitter.py` data generator pulls live twitter trending data from
the [Twitter API](https://developer.twitter.com/en/docs/twitter-api/v1/trends/trends-for-location/api-reference/get-trends-place)
every 15 seconds, and uses the [Kafka Python client](https://kafka-python.readthedocs.io/en/master/) (`kafka-python`)
to push events into Redpanda.

**Example:**

```json
{
  "location": {
    "name": "Barcelona",
    "placeType": {
      "code": 7,
      "name": "Town"
    },
    "url": "http://where.yahooapis.com/v1/place/395273",
    "parentid": 23424982,
    "country": "Venezuela",
    "woeid": 395273,
    "countryCode": "VE"
  },
  "trends": [
    {
      "trends": [
        {
          "name": "#23Feb",
          "url": "http://twitter.com/search?q=%2323Feb",
          "promoted_content": null,
          "query": "%2323Feb",
          "tweet_volume": 25647
        },
        {
          "name": "#ConstruirPatriaEsProducir",
          "url": "http://twitter.com/search?q=%23ConstruirPatriaEsProducir",
          "promoted_content": null,
          "query": "%23ConstruirPatriaEsProducir",
          "tweet_volume": 28664
        },
        {
          "name": "Rusia",
          "url": "http://twitter.com/search?q=Rusia",
          "promoted_content": null,
          "query": "Rusia",
          "tweet_volume": 209119
        }
      ],
      "as_of": "2022-02-23T13:30:37Z",
      "created_at": "2022-02-10T05:40:07Z",
      "locations": [
        {
          "name": "Barcelona",
          "woeid": 395273
        }
      ]
    }
  ]
}
```

The twitter trending data can be enriched with the sample city location data provided in [`/data`](../data) based on
the `city` and `country` fields.


## Tweaking the code

If you make any changes to the data generator, rebuild the container using:

```bash
docker-compose build --no-cache

docker-compose up --force-recreate -d
```
