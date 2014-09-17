# Cygwin-only stuff. Abort if not Cygwin.
[[ "$OSTYPE" =~ ^cygwin ]] || return 1


# replace bash with zsh
perl -pi -w -e 's/bash --login/zsh -l/g;' /Cygwin.bat


# Install Cygwin packages.
if [[ "$(type -P cygwin.exe)" ]]; then
  packages="openssh,subversion,vim,curl,zsh"
  e_header "Installing cygwin packages: $packages"
  cygwin.exe --no-admin -q -P $packages
fi
