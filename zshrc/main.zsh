ZSHRC="$(cd "$(dirname "$0")" ; pwd -P)"

# set default fzf command
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'

# grep colors (see manpage)
# http://www.gnu.org/software/grep/manual/html_node/Environment-Variables.html
GREP_COLORS='ms=01;31:mc=01;31:sl=01;01:cx=:fn=35:ln=32:bn=32:se=36'

# must come before oh-my-zsh
fpath=('/usr/local/share/zsh/site-functions' $fpath)

autoload -Uz compinit bashcompinit compdef

compinit
bashcompinit

autoload zmv ckd de 

# oh-my-zsh configuration
source $ZSHRC/oh-my-zsh.zsh

# set starship prompt 
eval "$(starship init zsh)"

# custom aliases
source $ZSHRC/aliases.zsh

# load functions
source $ZSHRC/functions.zsh


function e_arrow()    { echo -e " \033[1;33m➜\033[0m  $@"; }

if rg NAME "$HOME/.gitconfig"; then
  e_arrow "Need to configure git user/email"
  e_arrow "run \`git user\`"
fi


# lesspipe
# eval "$(lesspipe.sh)"

# load OS specific code
[ `uname` '==' "Darwin" ] && source "$ZSHRC/mac.zsh";
[[ -e /proc/version && -n `grep Microsoft /proc/version` ]] && source "$ZSHRC/wsl.zsh";
[[ -n `grep Ubuntu /etc/issue 2>/dev/null` ]] && source "$ZSHRC/ubuntu.zsh";

export EDITOR=vim

# set virtualenvwrapper working directory
export WORKON_HOME=$HOME/.virtualenvs

# how many lines of history to keep in memory
HISTSIZE=50000
# how many history entries to save to disk
SAVEHIST=100000
# append history to the history file (no overwriting)
setopt    appendhistory
# share history across terminals
setopt    sharehistory
#immediately append to the history file, not just when a term is killed
setopt    incappendhistory

# load repo independent settings (can overwrite previous settings)
[ -f "$HOME/.environment.sh" ] && source "$HOME/.environment.sh"; 

# ctrl+Z to load buffer
# http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z

bindkey '^Z' fancy-ctrl-z
