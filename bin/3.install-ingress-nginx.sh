#!/bin/bash
# https://kubernetes.github.io/ingress-nginx/deploy/
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update ingress-nginx
helm install --kube-context kind-kind -n ingress-nginx --create-namespace \
  --values https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/hack/manifest-templates/provider/kind/values.yaml \
  --set controller.allowSnippetAnnotations=true ingress-nginx ingress-nginx/ingress-nginx
kubectl --context kind-kind -n ingress-nginx wait \
  --timeout=300s \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller

echo "Ingress-Nginx is ready!"