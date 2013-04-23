# Add binaries into the path
PATH=~/.dotfiles/bin:$PATH
export PATH

# Source all files in ~/.dotfiles/bashrc/
function src() {
  local file
  if [[ "$1" ]]; then
    source "$HOME/.dotfiles/bashrc/$1.sh"
  else
    for file in ~/.dotfiles/bashrc/*; do
      source "$file"
    done
  fi
}

# Run dotfiles script, then source.
function dotfiles() {
  ~/.dotfiles/bin/dotfiles "$@" && src
}

src
