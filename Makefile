IMAGE_NAME := geo_py
TAG ?= latest

geo_py:
	make compose

compose:
	docker compose up

recompose:
	docker compose up --build

into:
	docker exec -it python sh

jupyter:
	docker exec -it python jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root

lint:
	cd python
	isort ./
	black ./
	flake8 ./
	mypy --ignore-missing-imports ./