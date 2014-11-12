ZSHRC="$HOME/.dotfiles/zshrc";

HISTSIZE=50000 # session history size
SAVEHIST=100000 # saved history size

# must come before oh-my-zsh
fpath=('/usr/local/share/zsh/site-functions' $fpath)

# oh-my-zsh configuration
source $ZSHRC/oh-my-zsh.zsh

# custom prompt 
source $ZSHRC/prompt.zsh

# custom aliases
source $ZSHRC/aliases.zsh

# load functions 
autoload zmv de ckd

# load custom zsh functions
fpath=( $ZSHRC/functions "${fpath[@]}" )
autoload -Uz ckd


# load OS specific code
[ `uname` '==' "Linux" ] && source "$ZSHRC/linux.zsh";
[ `uname` '==' "Darwin" ] && source "$ZSHRC/mac.zsh";
[ $OSTYPE '==' "cygwin" ] && source "$ZSHRC/cygwin.zsh";

# load repo independent settings
[ -f "$HOME/.environment" ] && source "$HOME/.environment"; 

export EDITOR=vim

# set virtualenvwrapper working directory
export WORKON_HOME=$HOME/.virtualenvs

