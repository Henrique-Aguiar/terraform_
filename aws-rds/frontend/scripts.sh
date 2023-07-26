#!/bin/bash
sudo apt-get update
sudo apt-get -y install docker.io
sudo usermod -aG docker ubuntu
sudo docker build -t henriquelr/meu-site-nginx .
sudo docker run -d -p 80:80 henriquelr/meu-site-nginx