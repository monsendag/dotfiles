ZSH=$HOME/.dotfiles/vendor/oh-my-zsh
ZSH_THEME=""

DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true


export ZSHZ_DATA="$HOME/.z_history"
export ZSHZ_NO_RESOLVE_SYMLINKS=1
export ZSHZ_TILDE=1

plugins=(z gitfast vi-mode history-substring-search gnu-utils docker mvn npm kubectl)
source $ZSH/oh-my-zsh.sh

