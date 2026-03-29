# Termux-only stuff. Abort if not Termux.
[[ -n "$TERMUX_VERSION" ]] || [[ "$PREFIX" == *termux* ]] || return 0

# Install packages via pkg.
packages=(
  neovim
  starship
  git
  git-extras
  zsh
  atuin
  zoxide
  tree
  fzf
  ripgrep
  eza
)

to_install=()
for pkg in "${packages[@]}"; do
  if ! dpkg -s "$pkg" &>/dev/null 2>&1; then
    to_install+=("$pkg")
  fi
done

if (( ${#to_install[@]} > 0 )); then
  e_header "Installing packages: ${to_install[*]}"
  pkg install -y "${to_install[@]}"
fi
