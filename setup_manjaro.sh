#!/bin/bash

# get the fastest mirror and update the system
sudo pacman-mirrors --fasttrack && sudo pacman -Syu 

# install nvidia drivers
sudo mhwd -a pci nonfree 0300
sudo pacman -Sy --needed git base-devel
sudo pacman -Sy python-pip
sudo pacman -Sy go

sudo pacman -Sy gnome-tweaks

sudo pacman -Sy vim

# install VS Code from source
git clone https://aur.archlinux.org/visual-studio-code-bin.git
cd visual-studio-code-bin
makepkg -si

cd ..

# install Sublime Text
curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
sudo pacman -Syu sublime-text

# install VLC
sudo pacman -Syu
sudo pacman -Sy vlc
sudo pacman -Sy remmina


# install Kind Kubernetes
# install kind kubernetes
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# install Azure CLI
sudo pacman -S libffi openssl-1.0
curl -L https://aka.ms/InstallAzureCli | bash


# install AWS CLI
sudo pacman -Sy aws-cli

# install Terraform
sudo pacman -Sy terraform

# install helm
sudo pacman -Sy helm


# install Docker
sudo pacman -Syu
sudo pacman -Sy docker
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker $USER
newgrp docker
