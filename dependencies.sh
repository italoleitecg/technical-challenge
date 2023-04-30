#!/bin/bash

#installing tools
sudo apt update
sudo apt install -y apt-utils
sudo apt install -y curl
sudo apt install -y wget
sudo apt install -y git
sudo apt install vim -y

#docker installation
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt-cache policy docker-ce
sudo apt install docker-ce -y

#kubectl install
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

#k3d install
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

#download repository file deployment.yaml to create my kubernetes cluster
#sudo wget -O /home/ubuntu/deployment.yaml https://raw.githubusercontent.com/italoleitecg/technical-challenge/47683e93c119183e79722b3a7b6237478f76086f/deployment.yaml
#curl -u italoleitecg:"${var.github_token}" -o /home/ubuntu/Vagrantfile https://raw.githubusercontent.com/italoleitecg/aula_pentest_impacta/f763e2fb0267966d70ac32dbfaa1fec27f806463/Vagrantfile
curl -u italoleitecg:"${var.github_token}" -o /home/ubuntu/deployment.yaml https://raw.githubusercontent.com/italoleitecg/technical-challenge/47683e93c119183e79722b3a7b6237478f76086f/deployment.yaml

#create cluster
sudo k3d cluster create grafanacluster -p "80:30000@loadbalancer"

#run deployment
sudo kubectl apply -f /home/ubuntu/deployment.yaml