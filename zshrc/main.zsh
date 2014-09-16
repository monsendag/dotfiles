ZSHRC="$HOME/.dotfiles/zshrc";

source $ZSHRC/oh-my-zsh.zsh
source $ZSHRC/prompt.zsh
source ~/.dotfiles/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# load custom functions

# custom aliases
source $ZSHRC/aliases.zsh

fpath=( $ZSHRC/functions "${fpath[@]}" )
autoload -Uz ckd

# OS specific code
[ `uname` '==' "Linux" ] && source "$ZSHRC/linux.zsh";
[ `uname` '==' "Darwin" ] && source "$ZSHRC/mac.zsh";

# repo independent settings
[ -f "$HOME/.environment" ] && source "$HOME/.environment"; 

# set ls colors
eval `dircolors $HOME/.dotfiles/conf/dircolors`

# ignore underscore-prefixed completions
# see http://unix.stackexchange.com/a/116205/66370
zstyle ':completion:*:*:-command-:*:*' ignored-patterns '_*'

export EDITOR=vim

# set virtualenvwrapper working directory
export WORKON_HOME=$HOME/.virtualenvs

# enable ZMV
autoload zmv
alias zmz='noglob zmv'
alias zcp='noglob zmv -C'
