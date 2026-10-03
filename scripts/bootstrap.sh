#!/usr/bin/env bash
set -euo pipefail

if ! kind get clusters | grep -qx observability; then
  kind create cluster --config kind.yaml --name observability
fi

kubectl cluster-info
bash scripts/install-argocd.sh

echo
echo "GitOps bootstrap complete."
echo "Run: make ports"
