#!/bin/bash

set -e
# ANSI escape code for green color
green_color="\033[32m"
# ANSI escape code for red color
red_color="\033[31m"
# Reset ANSI escape code (to revert back to default color)
reset_color="\033[0m"


sudo apt update

sudo apt install ca-certificates curl  gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io docker-compose -y

sudo usermod -aG docker $USER

# Check if the service is active
status=$(systemctl is-active docker)
if [ $status == "active" ]; then
    echo -e "${green_color}docker daemon is active and running ${reset_color}"
else
    echo -e  "${red_color}docker daemon failed to run${reset_color}"
fi


docker --version
docker-compose --version

sudo docker run --rm hello-world
