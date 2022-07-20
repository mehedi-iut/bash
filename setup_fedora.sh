#/bin/bash

# update the system
sudo dnf upgrade -y
sudo dnf install wget unzip dnf-plugins-core curl

FILE=~/.bashrc
if test -f "$FILE"; then
    echo "alias python=python3" >> $FILE
    source $FILE
else
    touch $FILE
    echo "alias python=python3" >> $FILE
    source $FILE
fi

# install pip
sudo dnf install python3-pip -y

# install golang
sudo dnf install -y go

# install edge
sudo dnf upgrade --refresh -y
sudo dnf install dnf-plugins-core -y
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
sudo dnf update --refresh -y
sudo dnf install microsoft-edge-stable -y

# install gnome tweaks
sudo dnf install gnome-tweaks -y

# install vim
sudo dnf install vim -y

# install VS Code
sudo dnf upgrade --refresh -y
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
printf "[vscode]\nname=packages.microsoft.com\nbaseurl=https://packages.microsoft.com/yumrepos/vscode/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscode.repo
sudo dnf install code -y

sudo dnf install python3-nautilus
git clone https://github.com/vvanloc/Nautilus-OpenInVSCode.git
cd Nautilus-OpenInVSCode
chmod +x install.sh
sudo ./install.sh
nautilus -q
cd


# install sublime text
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo dnf install sublime-text -y


# install Monaco Fonts
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

# install VLC
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install vlc -y


# install Remote desktop client tools (Rmmina)
sudo dnf install remmina -y

# install Docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker --now
sudo usermod -aG docker $USER
sudo newgrp docker
docker version

# install minikube and kubectl
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube version

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --short

minikube start --driver=docker

# install Azure CLI
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
sudo dnf install azure-cli -y

# install Azure Storage explorer


# install Terraform
sudo dnf update -y
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf install terraform -y

