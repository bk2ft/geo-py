
FROM python:3.11 AS python
RUN mkdir /python
WORKDIR /python

COPY ./python/requirements.txt ./
ADD ./python/. /python/

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y libgdal-dev

RUN pip install -r ./requirements.txt

CMD [ "python", "/python/flask/main.py" ]