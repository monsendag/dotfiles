# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
  e_header "Installing Homebrew"
  /usr/bin/env ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)";
fi

# Update Homebrew.
if [[ "$(type -P brew)" ]]; then
  e_header "Updating Homebrew"
  brew update
fi

# Install Homebrew recipes.
if [[ "$(type -P brew)" ]]; then
  recipes=(git lesspipe git-extras)

  list="$(to_install "${recipes[*]}" "$(brew list)")"
  if [[ "$list" ]]; then
    e_header "Installing Homebrew recipes: $list"
    brew install $list
  fi
fi
