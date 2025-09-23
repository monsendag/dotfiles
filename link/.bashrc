# Add binaries into the path
export PATH="$HOME/.dotfiles/bin:$PATH";

# load repo independent settings (can overwrite previous settings)
[ -f "$HOME/.environment.bash" ] && source "$HOME/.environment.bash";
