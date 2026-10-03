.PHONY: bootstrap cluster argocd status ports destroy

bootstrap:
	bash scripts/bootstrap.sh

cluster:
	kind create cluster --config kind.yaml --name observability

argocd:
	bash scripts/install-argocd.sh

status:
	kubectl get pods -A
	kubectl get applications -n argocd 2>/dev/null || true

ports:
	bash scripts/port-forward.sh

destroy:
	kind delete cluster --name observability
