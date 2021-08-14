# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 0

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
  e_header "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Install Homebrew recipes.
if [[ "$(type -P brew)" ]]; then
  recipes=(
  neovim
  starship
  git
  git-extras
  zsh
  tree
  fzf
  ripgrep
  exa
  )

  list="$(to_install "${recipes[*]}" "$(brew list --formula)")"
  if [[ "$list" ]]; then
    e_header "Installing Homebrew recipes: $list"
    brew install $list
  fi
fi
