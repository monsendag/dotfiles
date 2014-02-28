ZSHRC="$HOME/.dotfiles/zshrc";

# OS specific code
[ `uname` '==' "Linux" ] && source "$ZSHRC/linux.zsh";
[ `uname` '==' "Darwin" ] && source "$ZSHRC/mac.zsh";

# independent environment variables 
[ -f "$HOME/.environment" ] && source "$HOME/.environment"; 

# oh-my-zsh
source $ZSHRC/oh-my-zsh.zsh
# pure theme
source $ZSHRC/pure.zsh

# set ls colors
eval `dircolors $HOME/.dircolors`

alias ls='ls -h --color=auto'
alias gr='cd $(git root)'
export EDITOR=vim

alias subs='filebot -get-subtitles'

# set virtualenvwrapper working directory
export WORKON_HOME=$HOME/.virtualenv

# make autoenv run .env files

# ZMV
autoload zmv
alias zmz='noglob zmv'
alias zcp='noglob zmv -C'

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"
