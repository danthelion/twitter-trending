FROM python:3.9-slim

COPY requirements.txt .

RUN set -ex; \
  	pip install --no-cache-dir -r requirements.txt

COPY .env .
ADD twitter.py .

CMD ["python", "-u", "./twitter.py"]
