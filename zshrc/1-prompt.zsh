# set up prompt

export CLICOLOR=1
export LSCOLORS=CxFxExDxBxegedabagacad

autoload -U compinit
compinit

# vi mode
bindkey -v

# git:
# %b => current branch
# %a => current action (rebase/merge)
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
setopt no_beep 
setopt correct 
setopt auto_list
setopt complete_in_word 
setopt auto_pushd
setopt extended_glob
setopt zle
setopt complete_aliases
setopt autocd
setopt noxtrace #  ?
setopt localoptions 
setopt extendedglob
setopt prompt_subst # enable prompt substitution

autoload -U vcs_info
autoload -U add-zsh-hook
autoload -U compinit
compinit

for keycode in '[' '0'; do
  bindkey "^[${keycode}A" history-substring-search-up
  bindkey "^[${keycode}B" history-substring-search-down
done
unset keycode


zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' stagedstr '%F{yellow}●'
zstyle ':vcs_info:*' unstagedstr '%F{cyan}●'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' check-for-changes true

# left section: current path + git status
current_path=" %F{green}%~%b "
left_section="$current_path"
# right section
# use $SERVERNAME for hostname if found
# used for overriding servername in prompt on AWS
[[ -n $SERVERNAME ]] && server=$SERVERNAME || server=$(hostname -s)

user_host="%b%F{magenta}%n%F{white}@%b%F{cyan}$server"

# line two: red on error-->
line2="%(?/%F{blue}/%F{red})%B--%b%F{white}%(!.#.❯) "

prehook() {
  if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
      zstyle ':vcs_info:*' formats '%F{white}%b %c%u'
  } else {
      zstyle ':vcs_info:*' formats '%F{white}%b %F{red}●%c%u'
  }
  vcs_info
  right_section=" %b${vcs_info_msg_0_} %B%F{white}/ $user_host "

  local left_section_width=${#${(S%%)left_section//(\%([KF1]|)\{*\}|\%[Bbkf])}}
  local right_section_width=${#${(S%%)right_section//(\%([KF1]|)\{*\}|\%[Bbkf])}}

  local num_columns=$(( COLUMNS - left_section_width - right_section_width ))

  # Try to fit in long path and user@host.
  if (( num_columns > 0 )); then
    local prompt_padding
    eval "prompt_padding=\${(l:${num_columns}::-:)}"
    line1="$left_section%b%F{cyan}$prompt_padding$right_section"
  fi

  PS1="$line1$line2"
  PS2="$line2%B%F{white}%_> %b%f%k"
  PS3="$line2%B%F{white}?# %b%f%k"
 # zle_highlight[(r)default:*]="default:fg=white,bold"
}

add-zsh-hook precmd prehook
