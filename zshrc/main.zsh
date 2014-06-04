ZSHRC="$HOME/.dotfiles/zshrc";

source $ZSHRC/oh-my-zsh.zsh
source $ZSHRC/prompt.zsh
source ~/.dotfiles/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# set aliases after imports, to ensure they arent overridden
alias cr='cd $(git root)'
alias less='less -S' # enable horizontal scrolling in less
alias s='ssh'
alias subs='filebot -get-subtitles'
alias ta='tmux a'
alias c='z'

# OS specific code
[ `uname` '==' "Linux" ] && source "$ZSHRC/linux.zsh";
[ `uname` '==' "Darwin" ] && source "$ZSHRC/mac.zsh";

# repo independent settings
[ -f "$HOME/.environment" ] && source "$HOME/.environment"; 

# set ls colors
eval `dircolors $HOME/.dotfiles/conf/dircolors`


export EDITOR=vim

# set virtualenvwrapper working directory
export WORKON_HOME=$HOME/.virtualenvs

# enable ZMV
autoload zmv
alias zmz='noglob zmv'
alias zcp='noglob zmv -C'
