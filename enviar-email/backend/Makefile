TIMESTEMP := $(shell date +%s)
build:
	sudo docker build -t henriquelr/dves_api:$(TIMESTEMP) .
	sudo docker tag henriquelr/dves_api:$(TIMESTEMP)  henriquelr/dves_api:latest

push: build
	sudo docker push henriquelr/dves_api:latest         
	sudo docker push henriquelr/dves_api:$(TIMESTEMP)
          
