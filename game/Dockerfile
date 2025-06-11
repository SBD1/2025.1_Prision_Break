FROM python:3.9-slim-buster

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PG_HOST=db
ENV PG_DB_NAME=prision_break_db
ENV PG_USER=prision_break_user
ENV PG_PASSWORD=123

CMD ["python", "app_console.py"]
