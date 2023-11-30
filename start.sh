#!/bin/bash

echo "Start ELK...." 

echo "      **         **        ****** "
echo "    **  **       **          **   "
echo "   ***  ***      **          **   "
echo "  **********     **          **   "
echo " **        **    **          **   "
echo "**          **   ******    ****** "

echo "Set vm.max_map_count memory config."   
minikube ssh 'sudo -s sysctl -w vm.max_map_count=662144'

echo "#####################################"
#Set ELK configuration
echo "set elasticsearch, logstash and kibana configuration."
kubectl apply -f elasticsearch/elasticsearch-config.yaml
kubectl apply -f logstash/logstash-config.yaml
kubectl apply -f kibana/kibana-config.yaml

echo "#####################################"
#create elasticsearch, logstash and kibana deplotments
echo "create elasticsearch, logstash and kibana deplotments."
kubectl apply -f elasticsearch/elasticsearch-deployment.yaml
sleep 15s
kubectl apply -f logstash/logstash-deployment.yaml
kubectl apply -f kibana/kibana-deployment.yaml
sleep 10s
echo "#####################################"


#Start Spring boot app to send logs to ELK cluster 
echo "Start Spring boot app to send logs to ELK cluster."
sleep 10s
kubectl apply -f client/elk-spring.yaml
sleep 5s
echo "#####################################"
echo "create elasticsearch, logstash and kibana services."
kubectl apply -f elasticsearch/elasticsearch-service.yaml
kubectl apply -f logstash/logstash-service.yaml
kubectl apply -f kibana/kibana-service.yaml
echo "Finalize Installation, Please wait....."
     
sleep 30s
echo "Installation completed successfully."

echo "kibana server running on http://localhost:5601."
kubectl port-forward service/kibana 5601:5601

echo "Kibana server running on localhost:5601"



