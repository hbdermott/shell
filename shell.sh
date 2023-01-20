#!/bin/sh

sudo apt update && sudo apt upgrade
sudo apt install ranger fzf ncdu ripgrep nnn bat fd-find micro python3 python3-pip wget htop zsh zsh-syntax-highlighting

#NODE INSTALL
#curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - &&\
#sudo apt install -y nodejs
#npm install -g npx
#npm install -g yarn

#.NET INSTALL
#wget https://packages.microsoft.com/config/ubuntu/22.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
#sudo dpkg -i packages-microsoft-prod.deb
#sudo ls -arm packages-microsoft-prod.deb
#sudo apt update && sudo apt install -y dotnet-sdk-7.0

#LAZYGIT INSTALL

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
sudo rm -fr lazygit.tar.gz
echo "skip_global_compinit=1" > ~/.zshenv 
cp .zshrc ~

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
