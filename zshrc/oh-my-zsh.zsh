ZSH=$HOME/.dotfiles/vendor/oh-my-zsh
ZSH_THEME=""

DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true

# don't resolve z symlinks
# https://github.com/rupa/z
export _Z_NO_RESOLVE_SYMLINKS=true

plugins=(z gitfast vi-mode history-substring-search gnu-utils docker mvn npm adb kubectl)
source $ZSH/oh-my-zsh.sh

