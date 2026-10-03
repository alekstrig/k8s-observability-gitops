#!/usr/bin/env bash
set -euo pipefail

kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl wait --for=condition=Available deployment/argocd-server -n argocd --timeout=300s

kubectl apply -f argocd/project.yaml
kubectl apply -f argocd/applications/root.yaml

echo "Argo CD installed. The root application will reconcile monitoring, logging and demo."
