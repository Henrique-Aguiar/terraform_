TIMESTEMP := $(shell date +%s)
build:
	sudo docker build -t henriquelr/meu-site-nginx .
	sudo docker build -t henriquelr/meu-site-nginx:$(TIMESTEMP) .

push: build
	sudo docker push henriquelr/meu-site-nginx             
	sudo docker push henriquelr/meu-site-nginx:$(TIMESTEMP)
          
