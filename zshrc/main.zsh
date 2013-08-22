
# allow to define independent environment variables in ~/.environment
if [ -f "$HOME/.environment" ]; then
	source "$HOME/.environment"
fi

# load oh-my-zsh
source $HOME/.dotfiles/zshrc/oh-my-zsh.zsh
# load pure theme
source $HOME/.dotfiles/zshrc/pure.zsh

alias gr='cd $(git root)'
export EDITOR=vim
