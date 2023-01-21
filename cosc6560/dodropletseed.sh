#!/bin/bash

# DigitalOcean droplet user data script
# Ubuntu 22.04 (LTS) x64 (GNU/Linux 5.19.0-29-generic x86_64)

# Clones SEED Labs repo and installs Docker
sudo apt-get update -y
sudo apt-get -y install git
sudo git clone https://github.com/seed-labs/seed-labs.git

# download docker gpg key and add docker repo
# reference - https://docs.docker.com/engine/install/ubuntu/
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
 
# install docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
