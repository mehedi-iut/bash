#!/bin/bash

wget https://download.microsoft.com/download/A/E/3/AE32C485-B62B-4437-92F7-8B6B2C48CB40/StorageExplorer-linux-x64.tar.gz
mkdir -p azure-storage-explorer
tar xvf Linux_StorageExplorer-linux-x64.tar.gz -C azure-storage-explorer
sudo mv azure-storage-explorer /opt/
echo "alias storage-explorer=/opt/azure-storage-explorer/StorageExplorer" >> ~/.bashrc
# rm StorageExplorer-linux-x64.tar.gz
