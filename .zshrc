# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# export NVM_LAZY_LOAD=true
# export NVM_COMPLETION=true

export ZSH="/home/hunter/.oh-my-zsh"
ZLE_RPROMPT_INDENT=0
ZSH_THEME="elessar"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"


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
    fd
    z
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fdfind --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_BASE=/usr/bin/fzf

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='micro'
else
  export EDITOR='code'
fi

export PATH=$PATH:/home/hunter/.yarn/bin 

HISTSIZE=2000
SAVEHIST=2000
HISTFILE=~/.history

alias tarit="tar -czvf"
alias fd="fdfind"
alias bat="batcat"

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
