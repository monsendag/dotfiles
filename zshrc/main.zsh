
ZSHRC="$HOME/.dotfiles/zshrc";

# independent environment variables 
[ -f "$HOME/.environment" ] && source "$HOME/.environment"; 
# set ls colors
eval `dircolors $HOME/.dircolors`

alias ls='ls -h --color=auto'
alias gr='cd $(git root)'
alias less='less -S' # enable horizontal scrolling in less
alias s='ssh'

export EDITOR=vim

alias subs='filebot -get-subtitles'

# set virtualenvwrapper working directory
export WORKON_HOME=$HOME/.virtualenvs

# ZMV
autoload zmv
alias zmz='noglob zmv'
alias zcp='noglob zmv -C'

# oh-my-zsh
source $ZSHRC/oh-my-zsh.zsh
# pure theme
source $ZSHRC/pure.zsh

# OS specific code
[ `uname` '==' "Linux" ] && source "$ZSHRC/linux.zsh";
[ `uname` '==' "Darwin" ] && source "$ZSHRC/mac.zsh";


# open screen if we're on ssh
[[ -z "$SSH_CLIENT" && ! -z "$STY" ]]  || screen -DR
