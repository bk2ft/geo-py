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
	docker cp ./jmeter/tests jmeter:/opt/apache-jmeter-5.3/bin
	docker exec -it jmeter bash -c "cd bin; sh jmeter -n -t tests/TestPlan.jmx -JThreadNumber=10 -JRampUpPeriod=1 -Jiterations=10 -l results.csv -e -o /tests_output"
	docker cp jmeter:/tests_output ./jmeter
	docker stop jmeter
	docker rm jmeter

jmeter_ui:
	docker build -t jmeter_ui:latest -f ./docker/jmeter/Dockerfile.ui .

run_gui:
	docker run -v ./tests:/home/alpine/tests -e PASSWD=pword -d -p 5900:5900 --name jmeter_ui jmeter_ui:latest

non_gui:
	docker run -v ./tests:/home/alpine/tests jmeter_ui:latest jmeter -n -t tests/TestPlan.jmx -l tests/results.jtl
	
lint:
	cd python
	isort ./
	black --line-length=80 ./
	flake8 ./
	# mypy --ignore-missing-imports ./