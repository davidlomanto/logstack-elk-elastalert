#! /bin/bash

cd elastalert
export HOST_ES=$(microk8s.kubectl get svc -n logging elasticsearch -o jsonpath='{.spec.clusterIP}')
docker build -t ntopus/elastalert:latest ./
docker run -e HOST_ES=$HOST_ES -it ntopus/elastalert:latest
