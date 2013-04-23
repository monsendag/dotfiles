# My awesome bash prompt
#
# Copyright (c) 2012 "Cowboy" Ben Alman
# Licensed under the MIT license.
# http://benalman.com/about/license/
#
# Example:
# [master:!?][cowboy@CowBook:~/.dotfiles]
# [11:14:45] $
#
# Read more (and see a screenshot) in the "Prompt" section of
# https://github.com/cowboy/dotfiles

# ANSI CODES - SEPARATE MULTIPLE VALUES WITH ;
#
#  0  reset          4  underline
#  1  bold           7  inverse
#
# FG  BG  COLOR     FG  BG  COLOR
# 30  40  black     34  44  blue
# 31  41  red       35  45  magenta
# 32  42  green     36  46  cyan
# 33  43  yellow    37  47  white

 NONE="\[\033[0m\]"    # unsets color to term's fg color

# regular colors
 K="\[\033[0;30m\]"    # black
 R="\[\033[0;31m\]"    # red
 G="\[\033[0;32m\]"    # green
 Y="\[\033[0;33m\]"    # yellow
 B="\[\033[0;34m\]"    # blue
 M="\[\033[0;35m\]"    # magenta
 C="\[\033[0;36m\]"    # cyan
 W="\[\033[0;37m\]"    # white

# emphasized (bolded) colors
 EMK="\[\033[1;30m\]"
 EMR="\[\033[1;31m\]"
 EMG="\[\033[1;32m\]"
 EMY="\[\033[1;33m\]"
 EMB="\[\033[1;34m\]"
 EMM="\[\033[1;35m\]"
 EMC="\[\033[1;36m\]"
 EMW="\[\033[1;37m\]"

# background colors
 BGK="\[\033[40m\]"
 BGR="\[\033[41m\]"
 BGG="\[\033[42m\]"
 BGY="\[\033[43m\]"
 BGB="\[\033[44m\]"
 BGM="\[\033[45m\]"
 BGC="\[\033[46m\]"
 BGW="\[\033[47m\]"

pwd_maxlen() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=30
    # Indicate that there has been dir truncation
    local trunc_symbol="..."
    local dir=${PWD##*/}
    pwdmaxlen=$(((pwdmaxlen < ${#dir}) ? ${#dir} : pwdmaxlen))
   	path=${PWD/#$HOME/\~}
    local pwdoffset=$((${#path} - pwdmaxlen))
    if [ ${pwdoffset} -gt "0" ]
    then
        path=${path:$pwdoffset:$pwdmaxlen}
        path=${trunc_symbol}/${path#*/}
    fi
}

# Exit code of previous command.
function prompt_exitcode() {
  [[ $1 != 0 ]] && echo " $R$1$c9"
}

# Git status.
function prompt_git() {
  local status output flags
  status="$(git status 2>/dev/null)"
  [[ $? != 0 ]] && return;
  output="$(echo "$status" | awk '/# Initial commit/ {print "(init)"}')"
  [[ "$output" ]] || output="$(echo "$status" | awk '/# On branch/ {print $4}')"
  [[ "$output" ]] || output="$(git branch | perl -ne '/^\* (.*)/ && print $1')"
  flags="$(
    echo "$status" | awk 'BEGIN {r=""} \
      /^# Changes to be committed:$/        {r=r "+"}\
      /^# Changes not staged for commit:$/  {r=r "!"}\
      /^# Untracked files:$/                {r=r "?"}\
      END {print r}'
  )"
  if [[ "$flags" ]]; then
    output="$Y$output$W:$Y$flags"
  fi
  echo "$W[$output$W]$NONE"
}

# SVN info.
function prompt_svn() {
  local info="$(svn info . 2> /dev/null)"
  local last current
  if [[ "$info" ]]; then
    last="$(echo "$info" | awk '/Last Changed Rev:/ {print $4}')"
    current="$(echo "$info" | awk '/Revision:/ {print $2}')"
    echo "$W[$G$last$G:$Y$current$W]$NONE"
  fi
}

# Maintain a per-execution call stack.
prompt_stack=()
trap 'prompt_stack=("${prompt_stack[@]}" "$BASH_COMMAND")' DEBUG

function prompt_command() {
	pwd_maxlen

	USERCOLOR=$M
	if [[ "$SSH_TTY" ]]; then # connected via ssh
		USERCOLOR=$Y
	elif [[ "$USER" == "root" ]]; then # logged in as root
		USERCOLOR=$G
	fi

	local exit_code=$?
	# If the first command in the stack is prompt_command, no command was run.
	# Set exit_code to 0 and reset the stack.
	[[ "${prompt_stack[0]}" == "prompt_command" ]] && exit_code=0
	prompt_stack=()

	# While the simple_prompt environment var is set, disable the awesome prompt.
	[[ "$simple_prompt" ]] && PS1='\n$ ' && return

	# init PS1 with a newline
	PS1=""
	# svn: [repo:lastchanged]
	PS1="$PS1$(prompt_svn)"
	# git: [branch:flags]
	PS1="$PS1$(prompt_git)"
	# misc: [cmd#:hist#]
	# PS1="$PS1$c1[$c0#\#$c1:$c0!\!$c1]$c9"
	# path: [user@host:path]
	PS1="$PS1$W[$USERCOLOR\u$W@$C\h$W:$R$path$W]$NONE"
	PS1="$PS1\n"
	# date: [HH:MM:SS]
	# PS1="$PS1$c1[$c0$(date +"%H$c1:$c0%M$c1:$c0%S")$c1]$c9"
	# exit code: 127
	PS1="$PS1$(prompt_exitcode "$exit_code")"
	PS1="$PS1 \$ "
}

PROMPT_COMMAND="prompt_command"
