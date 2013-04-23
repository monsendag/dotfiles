# Add binaries into the path
PATH=~/.dotfiles/bin:$PATH
export PATH

BASHRC="$HOME/.dotfiles/bashrc";
# Run dotfiles script, then source.

source $(which src) && src $BASHRC

function dotfiles() {
  ~/.dotfiles/bin/dotfiles "$@" && src $BASHRC
}
