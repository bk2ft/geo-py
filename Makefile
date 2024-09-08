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
	docker exec -it jmeter bash -c "cd bin; sh jmeter -n -t tests/TestPlanGraphQL.jmx -JThreadNumber=10 -JRampUpPeriod=1 -Jiterations=10 -l results.csv -e -o /tests_output"
	docker cp jmeter:/tests_output ./jmeter/tests
	docker stop jmeter
	docker rm jmeter

jmeter_ui:
	docker build -t jmeter_ui:latest -f ./docker/jmeter/Dockerfile.ui .

run_gui:
	docker run -v ${PWD}/jmeter/tests:/home/alpine/tests -e PASSWD=pword -d -p 5900:5900 --name jmeter_ui jmeter_ui:latest

non_gui:
	docker run -v ${PWD}/jmeter/tests:/home/alpine/tests --name jmeter_noui jmeter_ui:latest jmeter -n -t tests/TestPlan.jmx -l tests/nogui_output/results.jtl
	docker stop jmeter_noui
	docker rm jmeter_noui
	
lint:
	cd python
	isort ./
	black --line-length=80 ./
	flake8 ./
	# mypy --ignore-missing-imports ./
	ontent-type: application/json' \
    --url 'http://www.mattbudd.co.uk:2095/graphql' \
    --data '{"query":"query ExampleQuery {\n  getJobs {\n    title\n  }\n}"}'