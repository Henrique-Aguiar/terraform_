#!/bin/bash
sudo apt-get update
sudo apt-get -y install docker.io
sudo usermod -aG docker ubuntu
sudo docker run -d -p 80:80 -p 443:443 henriquelr/certificado_ssl:04