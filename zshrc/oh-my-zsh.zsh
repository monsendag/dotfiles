ZSH=$HOME/.dotfiles/vendor/oh-my-zsh
ZSH_THEME=""

DISABLE_UPDATE_PROMPT=true

plugins=(z vi-mode gitfast svn history-substring-search colored-man brew bower gnu-utils docker mvn)
source $ZSH/oh-my-zsh.sh

# fix for history substring search (see robbyrussel/oh-my-zsh#2735)
bindkey "^[OA" up-line-or-history
bindkey "^[OB" down-line-or-history 
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
