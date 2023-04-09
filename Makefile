build:
	docker build -t product-store-app .

run:
	docker run --rm -v ./app:/code/app --name app -p 80:80 product-store-app

make stop:
	docker stop app
