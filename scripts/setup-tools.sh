#!/usr/bin/env bash
set -euo pipefail

echo "Codespace is ready."
echo
echo "The Kubernetes lab is intentionally NOT started automatically."
echo "Next step: verify Docker, kubectl, kind, helm and git."
echo
echo "Run:"
echo "  docker --version"
echo "  kubectl version --client"
echo "  kind version"
echo "  helm version"
echo "  git status"
