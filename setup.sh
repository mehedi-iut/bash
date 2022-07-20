#!/bin/bash

# Author: Mehedi

# update the system
sudo apt update -y && sudo apt upgrade -y
sudo apt install ubuntu-restricted-extras -y
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common wget ncurses-dev make build-essential unzip gpg gnupg-agent lsb-release gnupg


FILE=~/.bashrc
if test -f "$FILE"; then
    echo "alias python=python3" >> $FILE
    source $FILE
else
    touch $FILE
    echo "alias python=python3" >> $FILE
    source $FILE
fi


sudo apt install python3-pip -y

sudo apt install golang -y

# install edge web browser
# sudo apt install apt-transport-https ca-certificates curl software-properties-common wget -y
sudo wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft-edge.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main' | sudo tee /etc/apt/sources.list.d/microsoft-edge.list
sudo apt update
sudo apt install microsoft-edge-stable -y



# install gnome tweaks
sudo apt install gnome-tweaks -y

# install vim from source
# will be installed in /usr/local/bin/vim
# sudo apt install ncurses-dev -y
# sudo apt install make -y
# sudo apt install build-essential -y

wget https://github.com/vim/vim/archive/master.zip
# sudo apt install unzip -y
unzip master.zip
cd vim-master
cd src/
./configure
make
sudo make install

cd


# install visual studio code and "open in code" in context manager
# sudo apt-get install wget gpg -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

# sudo apt install apt-transport-https -y
sudo apt update -y
sudo apt install code -y

sudo apt install python3-nautilus
git clone https://github.com/vvanloc/Nautilus-OpenInVSCode.git
cd Nautilus-OpenInVSCode
chmod +x install.sh
sudo ./install.sh
nautilus -q
cd



# install sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update -y
sudo apt install sublime-text -y

# install monaco font
wget https://www.cufonfonts.com/download/redirect/monaco
unzip -q monaco
FONTS=~/.fonts
if test -d $FONTS; then
    echo "$FONTS exists"
else
    mkdir $FONTS
fi
mv Monaco.ttf $FONTS
sudo fc-cache -f -v



# install vlc
sudo apt update -y
sudo apt install vlc -y

# install remote desktop client (remmina)
sudo apt-add-repository ppa:remmina-ppa-team/remmina-next 
sudo apt update 
sudo apt install -y remmina remmina-plugin-rdp remmina-plugin-secret

# install docker
sudo apt-get update -y
# sudo apt-get install -y \
# apt-transport-https \
# ca-certificates \
# curl \
# gnupg-agent \
# software-properties-common &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&
sudo apt-get update -y &&
sudo sudo apt-get install docker-ce docker-ce-cli containerd.io -y &&
sudo usermod -aG docker ${USER}
sudo chmod 666 /var/run/docker.sock


# install minikube and kubectl for local kubernetes setup
sudo apt update -y
sudo apt upgrade -y

sudo apt install virtualbox virtualbox-ext-pack -y

wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo cp minikube-linux-amd64 /usr/local/bin/minikube
sudo chmod 755 /usr/local/bin/minikube
minikube version


curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version -o json

minikube start
kubectl config view

# install Azure CLI

sudo apt-get update
# sudo apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg
curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-get update -y
sudo apt-get install -y azure-cli

# install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update -y && sudo apt install terraform -y

