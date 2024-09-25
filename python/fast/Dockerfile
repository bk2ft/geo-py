
# syntax=docker/dockerfile:1

FROM python:3.9 as fastapi

COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . /app

CMD ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0", "--port", "5000"]