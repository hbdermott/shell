export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

export ZSH="$HOME/.oh-my-zsh"
ZLE_RPROMPT_INDENT=0
ZSH_THEME="elessar"

DISABLE_UPDATE_PROMPT="true"

export PATH=$PATH:$HOME/.yarn/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$HOME/.opencode/bin:$PATH
export PATH=$PATH:/usr/bin

plugins=(
    git
    ubuntu
    sudo
    pip
    extract
    colored-man-pages
    alias-finder
    zsh-interactive-cd
    fzf
    fzf-tab
    z
    tldr
    eza
)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fdfind --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_BASE=/usr/bin/fzf

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='micro'
else
  export EDITOR='code'
fi



HISTSIZE=2000
SAVEHIST=2000
HISTFILE=$HOME/.history

alias tarit="tar -czvf"
alias fd="fdfind"
alias bat="batcat"
alias ls='eza'

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
