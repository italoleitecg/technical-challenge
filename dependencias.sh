#!/bin/bash

sudo su -
sudo apt-get update
sudo apt-get install -y apt-utils
sudo apt-get install -y curl
sudo apt-get install -y wget
sudo apt-get install -y git
sudo apt install vim -y

# sudo apt-get install -y ca-certificates curl gnupg lsb-release
# 
# sudo mkdir -p /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# 
# echo \
#   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# 
# sudo apt-get update
# 
# sudo chmod a+r /etc/apt/keyrings/docker.gpg
# sudo apt-get update
# 
# sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# installing the kubernetes
## sudo apt-get update
## sudo apt-get install -y ca-certificates curl
## sudo apt-get install -y apt-transport-https
## sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
## echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
## sudo apt-get update
## sudo apt-get install -y kubectl

#installing the k3d
# wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
# sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

#installing kubectl
# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# docker run --name mariadb -e MARIADB_ROOT_PASSWORD=diouxx -e MARIADB_DATABASE=glpidb -e MARIADB_USER=glpi_user -e MARIADB_PASSWORD=glpi -d mariadb:10.7
# docker run --name glpi --link mariadb:mariadb -p 80:80 -d diouxx/glpi
# docker run -d --name=grafana-italo -p 3000:3000 italoleitecg/grafana-italo

# sudo su -
# cd /root
# wget https://github.com/italoleitecg/technical-challenge/blob/main/deployment.yaml

# k3d cluster create meucluster -p "80:30000@loadbalancer"

# kubectl apply -f deployment.yaml