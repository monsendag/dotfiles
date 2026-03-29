ZSHRC="$(cd "$(dirname "$0")" ; pwd -P)"

# set default fzf command
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'

export STARSHIP_CONFIG=~/.dotfiles/conf/starship.toml

export EDITOR=nvim

export EZA_CONFIG_DIR=~/.config/eza

# Minimal init for non-interactive shells or when fast init is requested
for file in $ZSHRC/init-untracked-fast/*.zsh; do
    source "$file"
done

# ============================================
# PERFORMANCE OPTIMIZATION: Instant prompt support
# If running in a non-interactive context (IDE terminals, CI), skip heavy init
# ============================================
if [[ $- != *i* ]] || [[ -n "$ZSH_FAST_INIT" ]]; then
  return 2>/dev/null || exit 0
fi

# grep colors (see manpage)
# http://www.gnu.org/software/grep/manual/html_node/Environment-Variables.html
GREP_COLORS='ms=01;31:mc=01;31:sl=01;01:cx=:fn=35:ln=32:bn=32:se=36'

# must run before compinit
typeset -gaU fpath=($fpath ~/.local/share/zsh/completions)

# must come before oh-my-zsh
fpath=('/usr/local/share/zsh/site-functions' $fpath)

autoload -Uz compinit bashcompinit compdef

# ============================================
# PERFORMANCE OPTIMIZATION: Cache compinit
# Only regenerate completion dump once per day
# ============================================
_zsh_compinit_cache() {
  local zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  # Check if zcompdump exists and is less than 24 hours old
  if [[ -n "$zcompdump"(N.mh+24) ]]; then
    # Outdated or missing - full compinit
    compinit -d "$zcompdump"
    # Compile in background for faster subsequent loads
    { zcompile "$zcompdump" } &!
  else
    # Use cached completions, skip security check for speed
    compinit -C -d "$zcompdump"
  fi
}
_zsh_compinit_cache

bashcompinit

autoload zmv ckd de 

# oh-my-zsh configuration
source $ZSHRC/oh-my-zsh.zsh

# ============================================
# PERFORMANCE OPTIMIZATION: Cache shell inits
# Pre-generate and cache the output of slow init commands
# Regenerate cache when binary changes or doesn't exist
# ============================================
_cache_init() {
  local name=$1
  local cmd=$2
  local cache_file="${ZDOTDIR:-$HOME}/.zsh_${name}_init.zsh"
  local binary_path=$(command -v "$name" 2>/dev/null)

  # Skip if command doesn't exist
  [[ -z "$binary_path" ]] && return

  # Regenerate if cache doesn't exist or binary is newer than cache
  if [[ ! -f "$cache_file" ]] || [[ "$binary_path" -nt "$cache_file" ]]; then
    eval "$cmd" > "$cache_file" 2>/dev/null
    { zcompile "$cache_file" } &!
  fi
  source "$cache_file"
}

_cache_init starship 'starship init zsh'
_cache_init zoxide 'zoxide init zsh'

# Atuin setup (check if installed)
if [[ -f "$HOME/.atuin/bin/env" ]]; then
  . "$HOME/.atuin/bin/env"
  _cache_init atuin 'atuin init zsh'
fi

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

# ============================================
# PERFORMANCE OPTIMIZATION: Run git check asynchronously
# Don't block shell startup for this reminder
# ============================================
{
  if rg -q NAME "$HOME/.gitconfig" 2>/dev/null; then
    e_arrow "Need to configure git user/email"
    e_arrow "run \`git user\`"
  fi
} &!


# lesspipe
# eval "$(lesspipe.sh)"

# ============================================
# PERFORMANCE OPTIMIZATION: Cache OS detection
# ============================================
if [[ -z "$_ZSH_OS_DETECTED" ]]; then
  if [[ "$(uname)" == "Darwin" ]]; then
    export _ZSH_OS_TYPE="macos"
  elif [[ -n "$TERMUX_VERSION" ]] || [[ "$PREFIX" == *termux* ]]; then
    export _ZSH_OS_TYPE="termux"
  elif [[ -f /proc/version ]] && grep -qi microsoft /proc/version 2>/dev/null; then
    export _ZSH_OS_TYPE="wsl"
  elif [[ -f /etc/issue ]] && grep -qi ubuntu /etc/issue 2>/dev/null; then
    export _ZSH_OS_TYPE="ubuntu"
  else
    export _ZSH_OS_TYPE="linux"
  fi
  export _ZSH_OS_DETECTED=1
fi

# load OS specific code
case "$_ZSH_OS_TYPE" in
  macos)   source "$ZSHRC/mac.zsh" ;;
  termux)  source "$ZSHRC/termux.zsh" ;;
  wsl)     source "$ZSHRC/wsl.zsh" ;;
  ubuntu)  source "$ZSHRC/ubuntu.zsh" ;;
esac

# set virtualenvwrapper working directory
export WORKON_HOME=$HOME/.virtualenvs

# how many lines of history to keep in memory
HISTSIZE=50000
# how many history entries to save to disk
SAVEHIST=100000
# append history to the history file (no overwriting)
setopt appendhistory
# share history across terminals
setopt sharehistory
#immediately append to the history file, not just when a term is killed
setopt incappendhistory

# https://zsh.sourceforge.io/Doc/Release/Options.html 
# require -e for applying escape sequences 
setopt BSD_echo

# load repo independent zsh configuration (can overwrite previous settings)
for file in $ZSHRC/init-untracked/*.zsh; do
    source "$file"
done

[ -f "$HOME/.environment.zsh" ] && source "$HOME/.environment.zsh";

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
