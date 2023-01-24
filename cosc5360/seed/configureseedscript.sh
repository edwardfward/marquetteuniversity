#!/bin/bash

# clones seed repo
# tested on digitalocean ubuntu 22.04 (lts) x64

# clone seed repo
sudo apt-get update -y
sudo apt-get install -y git

# install in the user's home directory
wall "System is cloning repos..."
git clone https://github.com/seed-labs/seed-labs.git ~/seed-labs
git clone https://github.com/https://github.com/edwardfward/marquetteuniversity.git ~/marquette
wall "System is finished with cloning repos..installing docker"
# install docker key and repo
# ref - https://docs.docker.com/engine/install/ubuntu/

sudo apt-get update -y
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
# install docker
sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
wall "SEED installation and setup complete."
