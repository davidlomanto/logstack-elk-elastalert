#! /bin/bash

cd elastalert
echo $HOST_ES
docker build -t ntopus/elastalert:latest ./
docker run -e HOST_ES=$HOST_ES -it ntopus/elastalert:latest
