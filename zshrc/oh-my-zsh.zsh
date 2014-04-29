ZSH=$HOME/.dotfiles/vendor/oh-my-zsh
ZSH_THEME=""

plugins=(z vi-mode gitfast history-substring-search colored-man brew bower common-aliases mvn)
source $ZSH/oh-my-zsh.sh

# fix for history substring search (see robbyrussel/oh-my-zsh#2735)
bindkey "^[OA" up-line-or-history
bindkey "^[OB" down-line-or-history 
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
