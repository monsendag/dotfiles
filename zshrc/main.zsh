ZSHRC="$HOME/.dotfiles/zshrc";

HISTSIZE=50000 # session history size
SAVEHIST=100000 # saved history size


alias dt='date +%s%N | cut -b1-13'


START=$(dt)

# load repo independent settings
[ -f "$HOME/.environment" ] && source "$HOME/.environment"; 

echo -n "env " && expr $(dt) - $START;

START=$(dt)
# must come before oh-my-zsh
fpath=('/usr/local/share/zsh/site-functions' $fpath)

echo -n "fpath " && expr $(dt) - $START;

START=$(dt)
# oh-my-zsh configuration
source $ZSHRC/oh-my-zsh.zsh
echo -n "oh-my-zsh " && expr $(dt) - $START;

START=$(dt)
# custom prompt 
source $ZSHRC/prompt.zsh
echo -n "prompt " && expr $(dt) - $START;

START=$(dt)
# custom aliases
source $ZSHRC/aliases.zsh
echo -n "aliases " && expr $(dt) - $START;

START=$(dt)
# load functions 
autoload zmv de ckd
echo -n "zmv de ckd " && expr $(dt) - $START;

START=$(dt)
# load custom zsh functions
fpath=( $ZSHRC/functions "${fpath[@]}" )
echo -n "custom zsh " && expr $(dt) - $START;


START=$(dt)
autoload -Uz ckd
echo -n "ckd " && expr $(dt) - $START;

START=$(dt)
# lesspipe
eval "$(lesspipe.sh)"
echo -n "lesspipe " && expr $(dt) - $START;


START=$(dt)
# load OS specific code
[ `uname` '==' "Linux" ] && source "$ZSHRC/linux.zsh";
[ `uname` '==' "Darwin" ] && source "$ZSHRC/mac.zsh";
[ $OSTYPE '==' "cygwin" ] && source "$ZSHRC/cygwin.zsh";
echo -n "os " && expr $(dt) - $START;

export EDITOR=vim

# set virtualenvwrapper working directory
export WORKON_HOME=$HOME/.virtualenvs

