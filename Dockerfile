FROM python:3.9-slim

WORKDIR /app

COPY . /app

RUN apt-get update && apt-get install -y \
    curl \
    && curl --version \
    && pip --version \
    && pip install --no-cache-dir -r requirements.txt

CMD ["python", "app.py"]
