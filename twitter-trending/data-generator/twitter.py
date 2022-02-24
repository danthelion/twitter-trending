import json
import os
import time

import dotenv
import schedule as schedule
import tweepy
from kafka import KafkaProducer


def read_dotenv_dict() -> dict:
    dotenv.load_dotenv()
    return {
        "consumer_key": os.getenv("TWITTER_CONSUMER_KEY"),
        "consumer_secret": os.getenv("TWITTER_CONSUMER_SECRET"),
        "access_token": os.getenv("TWITTER_ACCESS_TOKEN"),
        "access_token_secret": os.getenv("TWITTER_ACCESS_TOKEN_SECRET")
    }


def get_trending_data():
    credentials = read_dotenv_dict()
    auth = tweepy.OAuthHandler(credentials["consumer_key"], credentials["consumer_secret"])
    auth.set_access_token(credentials["access_token"], credentials["access_token_secret"])
    api = tweepy.API(auth)
    available_loc = api.available_trends()

    prod = KafkaProducer(bootstrap_servers='redpanda:9092')

    for loc in available_loc:
        time.sleep(15)
        place_trends = api.get_place_trends(loc['woeid'])
        msg = {
            "location": loc,
            "trends": place_trends
        }
        prod.send(
            topic='trending_data',
            key=loc['woeid'].encode('utf-8'),
            value=json.dumps(msg).encode('utf-8')
        )


if __name__ == '__main__':
    get_trending_data()
    schedule.every(180).seconds.do(get_trending_data)

    while True:
        schedule.run_pending()
        time.sleep(1)
