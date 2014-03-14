
ZSHRC="$HOME/.dotfiles/zshrc";

alias gr='cd $(git root)'
alias less='less -S' # enable horizontal scrolling in less
alias s='ssh'
alias subs='filebot -get-subtitles'

# oh-my-zsh
source $ZSHRC/oh-my-zsh.zsh
# pure theme
source $ZSHRC/pure.zsh

# OS specific code
[ `uname` '==' "Linux" ] && source "$ZSHRC/linux.zsh";
[ `uname` '==' "Darwin" ] && source "$ZSHRC/mac.zsh";

# independent environment variables 
[ -f "$HOME/.environment" ] && source "$HOME/.environment"; 
# set ls colors
eval `dircolors $HOME/.dotfiles/conf/dircolors`

export EDITOR=vim


# set virtualenvwrapper working directory
export WORKON_HOME=$HOME/.virtualenvs

# initialize autoenv
autoenv_init

# ZMV
autoload zmv
alias zmz='noglob zmv'
alias zcp='noglob zmv -C'

