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

jmeter_build:
	docker build --no-cache -t jmeter_base:latest -f docker/jmeter/Dockerfile .

jmeter_test:
	docker run -it -d --name jmeter jmeter_base:latest
	docker exec -it jmeter bash -c "cd bin; sh jmeter -n -t TestPlan.jmx -JThreadNumber=10 -JRampUpPeriod=1 -Jiterations=10 -l results.csv -e -o /TestPlan_output"
	docker cp jmeter:/TestPlan_output ./jmeter
	docker stop jmeter
	docker rm jmeter

lint:
	cd python
	isort ./
	black --line-length=80 ./
	flake8 ./
	# mypy --ignore-missing-imports ./