# Add binaries into the path
PATH=~/.dotfiles/bin:$PATH
export PATH

# Source all files in ~/.dotfiles/zshrc/
function src() {
  local file
  if [[ -n "$1" ]]; then
    source "$HOME/.dotfiles/zshrc/$1.sh"
  else
    for file in ~/.dotfiles/zshrc/*; do
      source "$file"
    done
  fi
}

# Run dotfiles script, then source.
function dotfiles() {
  ~/.dotfiles/bin/dotfiles "$@" && src
}

src
