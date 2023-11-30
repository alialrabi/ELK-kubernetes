#!/bin/bash

echo "Stop ELK...." 


echo "      **         **        ****** "
echo "    **  **       **          **   "
echo "   ***  ***      **          **   "
echo "  **********     **          **   "
echo " **        **    **          **   "
echo "**          **   ******    ****** "

echo "#####################################"
#Start elasticsearch, logstash and kibana services
echo "Remove deployments"
kubectl delete deployment --all
kubectl delete statefulset elasticsearch
echo "#####################################"
echo "Remove services"
kubectl delete  service elasticsearch
kubectl delete  service logstashsv
kubectl delete  service kibana

echo "#####################################"
echo "Remove configmap"
kubectl delete configmap elasticsearch-config
kubectl delete configmap logstash-config
kubectl delete configmap kibana-config

echo "Stop kibana port 5601"
fuser -n tcp -k 5601

echo "All resources has been removed."


