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


## Elastic Stack

The repository uses Elastic Cloud on Kubernetes (ECK), the official Elastic Kubernetes operator, rather than the legacy Elastic Helm charts. The Codespaces profile deploys a single-node Elasticsearch and one Kibana replica to keep resource usage manageable.

Kibana is exposed locally over HTTPS after:

```bash
make ports
```

Get the generated `elastic` user password:

```bash
kubectl -n logging get secret elasticsearch-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'; echo
```

The browser may warn about the self-signed development certificate.

## Argo CD

Get the initial admin password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

Username:

```text
admin
```

Open https://localhost:8080 after `make ports`.

## Important

This repository is intentionally a Codespaces lab. Elasticsearch is configured as a single-node development cluster with small resource limits. For production, use multiple nodes, durable storage, TLS, secret management, resource sizing, and an appropriate Elastic deployment strategy.
