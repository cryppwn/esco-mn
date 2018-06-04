#!/bin/bash

BOLD="\033[1m"
RED='\033[0;31m'
YELLOW="\033[38;5;11m"
GREEN='\033[0;32m'
NC='\033[0m' # No Color

print_msg() {
	echo -e "${BOLD}${GREEN}$1${NC}"
}

print_msg "Begining Docker installation\n"

print_msg "Installing required packages\n"
# Update required libs
sudo apt-get -qq install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# add apt-key fingerprint
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Display fingerprint and prompt for confirmation
print_msg "\nDisplaying apt-key fingerprint\n"
sudo apt-key fingerprint 0EBFCD88

while true; do
    read -p "Do you see a pub fingerprint matching: '9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88' (y/n)? " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

print_msg "Adding apt repository\n"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

print_msg "Updating Apt & Installing Docker-CE\n"
sudo apt-get -qq update
sudo apt-get -qq install docker-ce

print_msg "Docker installation completed successfully!\n"

sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose 
sudo chmod +x /usr/local/bin/docker-compose  

print_msg "Docker Compose installation completed successfully!\n"

echo -e "${YELLOW}Don't forget to add the docker group for other users (if desired):${NC} sudo usermod -aG docker <user>"

exit


