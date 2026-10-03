# Kubernetes Observability GitOps

Kubernetes + GitOps + Prometheus + Grafana + Alertmanager + Elasticsearch + Kibana, designed for GitHub Codespaces with Kind and Argo CD.

## Quick start

```bash
make bootstrap
```

Then inspect:

```bash
make status
make ports
```

Default local endpoints:
- Argo CD: https://localhost:8080
- Grafana: http://localhost:3000
- Prometheus: http://localhost:9090
- Alertmanager: http://localhost:9093
- Kibana: http://localhost:5601

This is a development/lab environment, not a production HA deployment. Elasticsearch is intentionally kept small for Codespaces.

## Architecture

```text
GitHub -> Argo CD -> Kind/Kubernetes
                    |-> Prometheus -> Grafana
                    |               -> Alertmanager
                    |-> Elasticsearch -> Kibana
                    `-> demo-app -> ServiceMonitor
```

## Prerequisites

GitHub Codespaces, Docker, kubectl, kind, helm and argocd CLI are installed by the devcontainer.

## GitOps

Argo CD watches `clusters/dev` in this repository. Application manifests are managed with Kustomize and Helm values.
