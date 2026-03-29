export DOTFILES="$HOME/.dotfiles"

# Add binaries into the path
export PATH="$DOTFILES/bin:$PATH";

# source zshrc
source "$DOTFILES/zshrc/main.zsh";
