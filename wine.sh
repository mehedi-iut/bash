#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install software-properties-common apt-transport-https wget -y
sudo dpkg --add-architecture i386
wget -O- https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor | sudo tee /usr/share/keyrings/winehq.gpg
echo deb [signed-by=/usr/share/keyrings/winehq.gpg] http://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -cs) main | sudo tee /etc/apt/sources.list.d/winehq.list
sudo apt update
sudo apt install --install-recommends winehq-staging -y
winecfg
