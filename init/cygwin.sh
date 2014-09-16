# Cygwin-only stuff. Abort if not Cygwin.
[[ "$OSTYPE" =~ ^cygwin ]] || return 1

# Install Cygwin packages.
if [[ "$(type -P cygwin.exe)" ]]; then
  packages="openssh,subversion,vim,curl,zsh"
  e_header "Installing cygwin packages: $packages"
  cygwin.exe -q -P $packages
fi
