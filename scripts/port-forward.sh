#!/usr/bin/env bash
set -euo pipefail

pkill -f "kubectl port-forward" 2>/dev/null || true

kubectl -n argocd port-forward svc/argocd-server 8080:443 >/tmp/argocd-forward.log 2>&1 &
kubectl -n monitoring port-forward svc/kube-prometheus-stack-grafana 3000:80 >/tmp/grafana-forward.log 2>&1 &
kubectl -n monitoring port-forward svc/kube-prometheus-stack-prometheus 9090:9090 >/tmp/prometheus-forward.log 2>&1 &
kubectl -n monitoring port-forward svc/kube-prometheus-stack-alertmanager 9093:9093 >/tmp/alertmanager-forward.log 2>&1 &
kubectl -n logging port-forward svc/kibana-kibana 5601:5601 >/tmp/kibana-forward.log 2>&1 &

echo "Grafana:     http://localhost:3000"
echo "Prometheus:  http://localhost:9090"
echo "Alertmanager: http://localhost:9093"
echo "Kibana:      http://localhost:5601"
echo "Argo CD:     https://localhost:8080"
