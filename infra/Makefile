RESOURCE_GROUP ?= k8s-resources
AKS_CLUSTER_NAME ?= kubernetes-aks1

# GRAFANA_POD_NAME=$(shell kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}')
# JAEGER_POD_NAME=$(shell kubectl -n istio-system get pod -l app=jaeger -o jsonpath='{.items[0].metadata.name}')
# APP_ID=$(shell az ad app list --query "[?displayName=='$(AKS_CLUSTER_NAME)'].{Id:appId}" --output table | tail -1)

.PHONY: create-plan
create-plan:
	#################################################################
	# Create terraform plan
	#################################################################
	terraform plan --out "main.tfplan"

.PHONY: create-cluster
create-cluster:
	#################################################################
	# Create AKS Cluster using terraform
	#################################################################
	terraform apply "main.tfplan"

.PHONY: get-credential
get-credential:
	################################################################
	# Get AKS Credentials
	#################################################################
	az aks get-credentials --resource-group $(RESOURCE_GROUP) --name $(AKS_CLUSTER_NAME)

.PHONY: get-node
get-node:
	kubectl get nodes
	
.PHONY: deploy-app
deploy-app:
	#################################################################
	# Deploy Newsfeed app in AKS Cluster
	#################################################################
	kubectl apply -f $(WORKDIR)/manifests/frontend-deploy.yaml
	kubectl apply -f $(WORKDIR)/manifests/frontend-service.yaml
	kubectl apply -f $(WORKDIR)/manifests/newsfeed-deploy.yaml
	kubectl apply -f $(WORKDIR)/manifests/newsfeed-service.yaml
	kubectl apply -f $(WORKDIR)/manifests/quotes-deploy.yaml
	kubectl apply -f $(WORKDIR)/manifests/quotes-service.yaml
	kubectl apply -f $(WORKDIR)/manifests/secret.yaml

.PHONY: delete-cluster
delete-cluster:
	#################################################################
	# Delete the AKS Cluster after use using terraform
	#################################################################
	terraform destroy