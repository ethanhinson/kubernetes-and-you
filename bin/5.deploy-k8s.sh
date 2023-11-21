#!/bin/bash
# Install a new namespace, deployment, service, and ingress
NAMESPACE="your-app"

kubectl config set-context kind-kind

if kubectl get namespace "$NAMESPACE" > /dev/null 2>&1; then
    echo "Namespace '$NAMESPACE' already exists."
else
    echo "Creating namespace: $NAMESPACE"
    kubectl create namespace "$NAMESPACE"

    if [ $? -eq 0 ]; then
        echo "Namespace '$NAMESPACE' created successfully."
    else
        echo "Failed to create namespace '$NAMESPACE'."
    fi
fi

kubectl apply -f ./k8s/configmap.yaml -n $NAMESPACE
kubectl apply -f ./k8s/deployment.yaml -n $NAMESPACE
kubectl apply -f ./k8s/service.yaml -n $NAMESPACE
kubectl apply -f ./k8s/ingress.yaml -n $NAMESPACE

kubectl rollout restart deployment weather -n $NAMESPACE
kubectl rollout restart deployment dice -n $NAMESPACE
kubectl rollout restart deployment pod-metadata -n $NAMESPACE
kubectl rollout restart deployment dogs -n $NAMESPACE