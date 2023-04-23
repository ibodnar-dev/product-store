INFRA_DIR := infra
APP_DEPLOYMENT_YAML := $(INFRA_DIR)/k8s/deployment.yaml
APP_SERVICE_YAML := $(INFRA_DIR)/k8s/service.yaml
APP_ALL_TAG := app

build:
	docker build -f $(INFRA_DIR)/docker/Dockerfile -t product-store-app .

run:
	docker run --rm -v ./app:/code/app --name app -p 80:80 public.ecr.aws/s0z5h1j3/product-app:latest

push_app_image:
	docker push public.ecr.aws/s0z5h1j3/product-app:latest

mk_start:
	minikube start --driver=docker

kl_apply_deployment:
	kubectl apply -f=$(APP_DEPLOYMENT_YAML)

kl_apply_service:
	kubectl apply -f=$(APP_SERVICE_YAML)

kl_apply_all: kl_apply_deployment kl_apply_service

kl_delete_deployment:
	kubectl delete deployments -l group=$(APP_ALL_TAG)

kl_delete_service:
	kubectl delete services -l group=$(APP_ALL_TAG)

kl_delete_all: kl_delete_deployment kl_delete_service
