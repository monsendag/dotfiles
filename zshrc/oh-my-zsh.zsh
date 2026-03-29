ZSH=$HOME/.dotfiles/vendor/oh-my-zsh
ZSH_THEME=""

DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true


plugins=(gitfast vi-mode history-substring-search gnu-utils docker docker-compose kubectl mvn npm)

# Skip compfix check for faster startup
ZSH_DISABLE_COMPFIX=true

source $ZSH/oh-my-zsh.sh


