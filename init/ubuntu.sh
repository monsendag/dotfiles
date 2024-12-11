# Ubuntu-only stuff. Abort if not Ubuntu.
[[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 0

# Install APT packages.
packages=(
  git
  zsh
  tree
  fzf
  ripgrep
  neovim
)

# add uninstalled packages to list
list=()
for package in "${packages[@]}"; do
  if [[ ! "$(dpkg -l "$package" 2>/dev/null | grep "^ii  $package")" ]]; then
    list=("${list[@]}" "$package")
  else 
    e_error "init / apt: skipping installed package: $package"
  fi
done

export DEBIAN_FRONTEND="noninteractive"
export TZ=Etc/UTC

# install uninstalled packages
if (( ${#list[@]} > 0 )); then
  e_header "Installing APT packages: ${list[*]}"
  for package in "${list[@]}"; do
    sudo apt-get -qq -y install --no-install-recommends "$package"
  done
fi

if ! command -v starship &> /dev/null; then
  e_header "Installing starship from https://starship.rs/install.sh";
  curl -fsSL https://starship.rs/install.sh | sh;
fi
