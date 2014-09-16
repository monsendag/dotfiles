ZSHRC="$HOME/.dotfiles/zshrc";

source $ZSHRC/oh-my-zsh.zsh

# load custom functions
# custom prompt
source $ZSHRC/prompt.zsh

# custom aliases
source $ZSHRC/aliases.zsh

fpath=( $ZSHRC/functions "${fpath[@]}" )
autoload -Uz ckd

# OS specific code
[ `uname` '==' "Linux" ] && source "$ZSHRC/linux.zsh";
[ `uname` '==' "Darwin" ] && source "$ZSHRC/mac.zsh";

# repo independent settings
[ -f "$HOME/.environment" ] && source "$HOME/.environment"; 

export EDITOR=vim

# set virtualenvwrapper working directory
export WORKON_HOME=$HOME/.virtualenvs

# enable ZMV
autoload zmv
alias zmz='noglob zmv'
alias zcp='noglob zmv -C'
