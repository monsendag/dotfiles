ZSHRC="$(cd "$(dirname "$0")" ; pwd -P)"

# set default fzf command
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'

export STARSHIP_CONFIG=~/.dotfiles/conf/starship.toml

export EDITOR=nvim

# grep colors (see manpage)
# http://www.gnu.org/software/grep/manual/html_node/Environment-Variables.html
GREP_COLORS='ms=01;31:mc=01;31:sl=01;01:cx=:fn=35:ln=32:bn=32:se=36'

# must run before compinit
typeset -gaU fpath=($fpath ~/.local/share/zsh/completions)

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

eval "$(zoxide init zsh)"

. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# custom aliases
source $ZSHRC/aliases.zsh

# load functions
source $ZSHRC/functions.zsh

# include zsh-syntax-highlighting
source ~/.dotfiles/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# include zsh-autosuggestions
source ~/.dotfiles/vendor/zsh-autosuggestions/zsh-autosuggestions.zsh

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# show vim mode on RPS1
# function zle-line-init zle-keymap-select {
#   VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
#    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
#    zle reset-prompt
# }

# zle -N zle-line-init
# zle -N zle-keymap-select
# export KEYTIMEOUT=1

# configure colors
# list of indices http://i.stack.imgur.com/UQVe5.png
ZSH_HIGHLIGHT_HIGHLIGHTERS=(pattern main brackets)
ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[path]='fg=033'
ZSH_HIGHLIGHT_STYLES[alias]='fg=118'
ZSH_HIGHLIGHT_STYLES[function]='fg=192'

# ignore underscore-prefixed completions
# see http://unix.stackexchange.com/a/116205/66370
zstyle ':completion:*:*:-command-:*:*' ignored-patterns '_*'


function e_arrow()    { echo -e " \033[1;33m➜\033[0m  $@"; }

if rg NAME "$HOME/.gitconfig"; then
  e_arrow "Need to configure git user/email"
  e_arrow "run \`git user\`"
fi


# lesspipe
# eval "$(lesspipe.sh)"

# load OS specific code
[ `uname` '==' "Darwin" ] && source "$ZSHRC/mac.zsh";
[[ -e /proc/version && -n `grep --ignore-case microsoft /proc/version` ]] && source "$ZSHRC/wsl.zsh";
[[ -n `grep Ubuntu /etc/issue 2>/dev/null` ]] && source "$ZSHRC/ubuntu.zsh";


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

# https://zsh.sourceforge.io/Doc/Release/Options.html 
# require -e for applying escape sequences 
setopt BSD_echo

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
