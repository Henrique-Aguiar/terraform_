#!/bin/bash
sudo apt-get update
sudo apt-get -y install docker.io
sudo usermod -aG docker ubuntu
sudo docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql