#!/bin/bash

microk8s.kubectl delete -f logging-stack.yaml
microk8s.kubectl delete -f fluentd-istio.yaml
microk8s.kubectl delete -f bookinfo-gateway.yaml
microk8s.kubectl delete -f bookinfo.yaml
