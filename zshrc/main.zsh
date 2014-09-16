ZSHRC="$HOME/.dotfiles/zshrc";

HISTSIZE=50000 # session history size
SAVEHIST=100000 # saved history size


# oh-my-zsh configuration
source $ZSHRC/oh-my-zsh.zsh

# custom prompt 
source $ZSHRC/prompt.zsh

# custom aliases
source $ZSHRC/aliases.zsh

# load custom zsh functions
fpath=( $ZSHRC/functions "${fpath[@]}" )
autoload -Uz ckd


# load OS specific code
[ `uname` '==' "Linux" ] && source "$ZSHRC/linux.zsh";
[ `uname` '==' "Darwin" ] && source "$ZSHRC/mac.zsh";

# load repo independent settings
[ -f "$HOME/.environment" ] && source "$HOME/.environment"; 

export EDITOR=vim

# set virtualenvwrapper working directory
export WORKON_HOME=$HOME/.virtualenvs

# enable ZMV
autoload zmv
alias zmz='noglob zmv'
alias zcp='noglob zmv -C'
