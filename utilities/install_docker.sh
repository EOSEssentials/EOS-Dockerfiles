#!/bin/bash

sudo apt-get update
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo apt-get install -y software-properties-common python-software-properties
sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
# -------------------
# Taking care of some minimal ubuntu versions
# -------------------------------
touch /etc/apt/sources.list.d/docker.list
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >> /etc/apt/sources.list.d/docker.list
# -------------------------------------------
sudo apt-get update
apt-cache policy docker-engine
sudo apt-get install -y docker-engine