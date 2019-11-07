FROM python:3

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install build-essential libssl-dev git

WORKDIR /home/elastalert

ADD requirements*.txt ./
RUN pip install -r requirements-dev.txt

ENV HOST_ES localhost
ENV PORT_ES 9200

COPY . .

RUN python setup.py install
RUN pip install "elasticsearch>=5.0.0"
RUN pip install "setuptools>=11.3"

ENTRYPOINT ./startup.sh
