#!/bin/bash

wget https://github.com/microsoft/AzureStorageExplorer/releases/download/latest/Linux_StorageExplorer-linux-x64.tar.gz

mkdir -p azure-storage-explorer

tar xvf Linux_StorageExplorer-linux-x64.tar.gz -C azure-storage-explorer
cd azure-storage-explorer
sudo cp StorageExplorer /usr/local/bin/
cd


https://github.com/microsoft/AzureStorageExplorer/releases/latest
https://github.com/microsoft/AzureStorageExplorer/releases/download/v1.24.3/Linux_StorageExplorer-linux-x64.tar.gz



sudo wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo wget http://mirrors.edge.kernel.org/ubuntu/pool/main/i/icu/libicu63_63.2-2_amd64.deb
sudo dpkg -i libicu63_63.2-2_amd64.deb
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install dotnet-sdk-3.1



wget https://download.microsoft.com/download/A/E/3/AE32C485-B62B-4437-92F7-8B6B2C48CB40/StorageExplorer-linux-x64.tar.gz
mkdir -p azure-storage-explorer
tar xvf Linux_StorageExplorer-linux-x64.tar.gz -C azure-storage-explorer
sudo mv azure-storage-explorer /opt/
echo "alias storage-explorer=/opt/azure-storage-explorer/StorageExplorer" >> ~/.bashrc
rm StorageExplorer-linux-x64.tar.gz

