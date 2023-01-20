git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
wget https://raw.githubusercontent.com/rupa/z/master/z.sh -O ~/.z
sudo mkdir -p $ZSH_CUSTOM/themes && curl https://raw.githubusercontent.com/fjpalacios/elessar-theme/master/elessar.zsh-theme -L -o $ZSH_CUSTOM/themes/elessar.zsh-theme

source ~/.zshrc