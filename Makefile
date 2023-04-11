build:
	docker build -t product-store-app .

run:
	docker run --rm -v ./app:/code/app --name app -p 80:80 public.ecr.aws/s0z5h1j3/product-app:latest

make stop:
	docker stop app

make push_app_image:
	docker push public.ecr.aws/s0z5h1j3/product-app:latest
