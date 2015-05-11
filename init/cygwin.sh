# Cygwin-only stuff. Abort if not Cygwin.
[[ "$OSTYPE" =~ ^cygwin ]] || return 1


# replace bash with zsh
perl -pi -w -e 's/bash --login/zsh -l/g;' /Cygwin.bat

# Install APT packages.
packages=(
  zsh
  tree
  curl
  vim
  subversion
  openssh
  ncurses
)

# install packages
if (( ${#packages[@]} > 0 )); then
  e_header "Installing apt-cyg packages: ${packages[*]}"
  for package in "${packages[@]}"; do
    apt-cyg install "$package"
  done
fi

