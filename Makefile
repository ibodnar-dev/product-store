INFRA_DIR := infra
APP_DEPLOYMENT_YAML := $(INFRA_DIR)/k8s/deployment.yaml
APP_SERVICE_YAML := $(INFRA_DIR)/k8s/service.yaml
APP_CONFIGMAP_YAML := $(INFRA_DIR)/k8s/configmap.yaml
APP_ALL_TAG := app
APP_REPO_URI_FILE_PATH := $(INFRA_DIR)/terraform/app-repo-uri
APP_REPO_URI := $(shell cat ${APP_REPO_URI_FILE_PATH})

build:
	docker build -f $(INFRA_DIR)/docker/Dockerfile -t ${APP_REPO_URI} .

run:
	docker run --rm -v ./app:/code/app --name app -p 80:80 ${APP_REPO_URI}

push_app_image:
	aws ecr-public get-login-password --region us-east-1 \
 	| docker login --username AWS --password-stdin public.ecr.aws \
 	&& docker push ${APP_REPO_URI}

mk_start:
	minikube start --driver=docker

mk_dashboard:
	minikube dashboard

kl_apply_deployment:
	export APP_REPO_URI=${APP_REPO_URI} && envsubst < $(APP_DEPLOYMENT_YAML) | kubectl apply -f -

kl_apply_service:
	kubectl apply -f=$(APP_SERVICE_YAML)

kl_apply_all: kl_apply_deployment kl_apply_service

kl_delete_deployment:
	kubectl delete deployments -l group=$(APP_ALL_TAG)

kl_delete_service:
	kubectl delete services -l group=$(APP_ALL_TAG)

kl_delete_all: kl_delete_deployment kl_delete_service
