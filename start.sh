#!/bin/bash

cd $(find ~ -maxdepth 2 -iname "logstack-elk-elastalert")
sudo snap install microk8s --classic
sudo microk8s.start
echo "y\n" | sudo microk8s.enable istio
microk8s.kubectl label namespace default istio-injection=enabled

result1=$(microk8s.kubectl get pods --field-selector=status.phase!=Succeeded,status.phase!=Running --all-namespaces)
echo "aguarde... processando (Istio - 1/3)"
while [ ${#result1} -ne 0 ];
do
	result1=$(microk8s.kubectl get pods --field-selector=status.phase!=Succeeded,status.phase!=Running --all-namespaces)
	sleep 1
done


#Bloco da Aplicação
microk8s.kubectl create -f bookinfo.yaml
sleep 2
result1=$(microk8s.kubectl get pods --field-selector=status.phase!=Succeeded,status.phase!=Running --all-namespaces)
echo "aguarde... processando (Aplicação - 2/3)"
while [ ${#result1} -ne 0 ];
do
	result1=$(microk8s.kubectl get pods --field-selector=status.phase!=Succeeded,status.phase!=Running --all-namespaces)
	sleep 2
done
microk8s.kubectl create -f bookinfo-gateway.yaml
microk8s.kubectl create -f logging-stack.yaml

result1=$(microk8s.kubectl get pods --field-selector=status.phase!=Succeeded,status.phase!=Running --all-namespaces)
echo "aguarde... processando (Elasticsearch, Fluentd e Kibana - 3/3)"
while [ ${#result1} -ne 0 ];
do
	result1=$(microk8s.kubectl get pods --field-selector=status.phase!=Succeeded,status.phase!=Running --all-namespaces)
	sleep 1
done
microk8s.kubectl create -f fluentd-istio.yaml

export INGRESS_PORT=$(microk8s.kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}') 
export SECURE_INGRESS_PORT=$(microk8s.kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
export INGRESS_HOST=127.0.0.1
export HOST_ES=$(microk8s.kubectl get svc -n logging elasticsearch -o jsonpath='{.spec.clusterIP}')
export HOST_KB=$(microk8s.kubectl get svc -n logging kibana -o jsonpath='{.spec.clusterIP}')
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
echo
echo -e "\033[01;32mENDEREÇO DE ACESSO DA APLICAÇÃO:  $GATEWAY_URL/productpage"
echo -e "\033[01;32mENDEREÇO DE ACESSO AO KIBANA:  $HOST_KB:5601"
echo
sleep 3



