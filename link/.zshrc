# Add binaries into the path
PATH=~/.dotfiles/bin:$PATH
export PATH

ZSHRC="$HOME/.dotfiles/zshrc";

# source all in zshrc
source $(which src) && src $ZSHRC

function dotfiles() {
  ~/.dotfiles/bin/dotfiles "$@" && src
}


