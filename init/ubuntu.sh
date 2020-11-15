# Ubuntu-only stuff. Abort if not Ubuntu.
[[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1

# Install APT packages.
packages=(
  git-core
  zsh
  tree
  fzf
  exa
  ripgrep
)



# add uninstalled packages to list
list=()
for package in "${packages[@]}"; do
  if [[ ! "$(dpkg -l "$package" 2>/dev/null | grep "^ii  $package")" ]]; then
    list=("${list[@]}" "$package")
  fi
done

# install uninstalled packages
if (( ${#list[@]} > 0 )); then
  e_header "Installing APT packages: ${list[*]}"
  for package in "${list[@]}"; do
    sudo apt-get -qq install "$package"
  done
fi

# install starship (not in apt repos)
curl -fsSL https://starship.rs/install.sh | bash
