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



git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
wget https://raw.githubusercontent.com/rupa/z/master/z.sh -O ~/.z
mkdir -p $ZSH_CUSTOM/themes && curl https://raw.githubusercontent.com/fjpalacios/elessar-theme/master/elessar.zsh-theme -L -o $ZSH_CUSTOM/themes/elessar.zsh-theme

echo "skip_global_compinit=1" > ~/.zshenv 

cp .zshrc ~
cd ~
sudo rm -fr ~/shell

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"