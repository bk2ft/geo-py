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

j_meter_build:
	docker build --no-cache -t jmeter_base:latest -f docker/jmeter/Dockerfile .

lint:
	cd python
	isort ./
	black --line-length=80 ./
	flake8 ./
	# mypy --ignore-missing-imports ./