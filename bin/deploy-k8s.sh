#!/bin/bash

kubectl apply -f ./k8s/deployment.yaml
kubectl apply -f ./k8s/service.yaml
kubectl apply -f ./k8s/ingress.yaml

kubectl rollout restart deployment weather
kubectl rollout restart deployment dice