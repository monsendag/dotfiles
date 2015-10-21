ZSH=$HOME/.dotfiles/vendor/oh-my-zsh
ZSH_THEME=""

DISABLE_UPDATE_PROMPT=true

# don't resolve z symlinks
# https://github.com/rupa/z
export _Z_NO_RESOLVE_SYMLINKS=true

plugins=(z gitfast vi-mode history-substring-search brew gnu-utils docker mvn npm)
source $ZSH/oh-my-zsh.sh

# fix for history substring search (see robbyrussel/oh-my-zsh#2735)
bindkey "^[OA" up-line-or-history
bindkey "^[OB" down-line-or-history 
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
