# Pure
# by Sindre Sorhus
# https://github.com/sindresorhus/pure
# MIT License

# For my own and others sanity
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
# %(?..) => prompt conditional - %(condition.true.false)
# terminal codes:
# \e7   => save cursor position
# \e[2A => move cursor 2 lines up
# \e[1G => go to position 1 in terminal
# \e8   => restore cursor position
# \e[K  => clears everything after the cursor on the current line


# turns seconds into human readable time
# 165392 => 1d 21h 56m 32s
# https://github.com/sindresorhus/pretty-time-zsh
human_time() {
	echo -n " "
	local tmp=$1
	local days=$(( tmp / 60 / 60 / 24 ))
	local hours=$(( tmp / 60 / 60 % 24 ))
	local minutes=$(( tmp / 60 % 60 ))
	local seconds=$(( tmp % 60 ))
	(( $days > 0 )) && echo -n "${days}d "
	(( $hours > 0 )) && echo -n "${hours}h "
	(( $minutes > 0 )) && echo -n "${minutes}m "
	echo "${seconds}s"
}

# displays the exec time of the last command if set threshold was exceeded
check_cmd_exec_time() {
	local stop=$EPOCHSECONDS
	local start=${cmd_timestamp:-$stop}
	integer elapsed=$stop-$start
	(($elapsed > ${PURE_CMD_MAX_EXEC_TIME:=5})) && human_time $elapsed
}

check_git_arrows() {
	# check if there is an upstream configured for this branch
	command git rev-parse --abbrev-ref @'{u}' &>/dev/null || return

	local arrows=""
	(( $(command git rev-list --right-only --count HEAD...@'{u}' 2>/dev/null) > 0 )) && arrows='↓'
	(( $(command git rev-list --left-only --count HEAD...@'{u}' 2>/dev/null) > 0 )) && arrows+='↑'
	# output the arrows
	[[ "$arrows" != "" ]] && echo " ${arrows}"
}

preexec() {
	cmd_timestamp=$EPOCHSECONDS

	# shows the current dir and executed command in the title when a process is active
	print -Pn "\e]0;"
	echo -nE "$PWD:t: $2"
	print -Pn "\a"
}

# string length ignoring ansi escapes
string_length() {
	# Subtract one since newline is counted as two characters
	echo $(( ${#${(S%%)1//(\%([KF1]|)\{*\}|\%[Bbkf])}} - 1 ))
}

preprompt_render() {
	# check that no command is currently running, the prompt will otherwise be rendered in the wrong place
	[[ -n ${cmd_timestamp+x} && "$1" != "precmd" ]] && return

	# set color for git branch/dirty status, change color if dirty checking has been delayed
	local git_color=242
	[[ -n ${git_delay_dirty_check+x} ]] && git_color=red

	# construct prompt, beginning with path
	local prompt="%F{033}%~%f"
	# git info
	prompt+="%F{$git_color}${vcs_info_msg_0_}${git_dirty}%f"
	# git pull/push arrows
	prompt+="%F{cyan}${git_arrows}%f"
	# username and machine if applicable
	prompt+=$username
	# execution time
	prompt+="%F{yellow}${cmd_exec_time}%f"

	# if executing through precmd, do not perform fancy terminal editing
	if [[ "$1" == "precmd" ]]; then
		print -P "\n${prompt}"
	else
		# only redraw if prompt has changed
		[[ "${last_preprompt}" != "${prompt}" ]] || return

		# calculate length of prompt for redraw purposes
		local prompt_length=$(string_length $prompt)
		local lines=$(( $prompt_length / $COLUMNS + 1 ))

		# disable clearing of line if last char of prompt is last column of terminal
		local clr="\e[K"
		(( $prompt_length * $lines == $COLUMNS - 1 )) && clr=""

		# modify previous prompt
		print -Pn "\e7\e[${lines}A\e[1G${prompt}${clr}\e8"
	fi

	# store previous prompt for comparison
	last_preprompt=$prompt
}

precmd() {
	# store exec time for when preprompt gets re-rendered
	cmd_exec_time=$(check_cmd_exec_time)

	# by making sure that cmd_timestamp is defined here the async functions are prevented from interfering
	# with the initial preprompt rendering
	cmd_timestamp=

	# check for git arrows
	git_arrows=$(check_git_arrows)

	# shows the full path in the title
	print -Pn '\e]0;%~\a'

	# get vcs info
	vcs_info

	# preform async git dirty check and fetch
	# async_tasks

	# print the preprompt
	preprompt_render "precmd"

	# remove the cmd_timestamp, indicating that precmd has completed
	unset cmd_timestamp
}

# fastest possible way to check if repo is dirty
async_git_dirty() {
	local untracked_dirty=$1; shift
	local umode="-unormal"
	[[ "$untracked_dirty" == "0" ]] && umode="-uno"

	# use cd -q to avoid side effects of changing directory, e.g. chpwd hooks
	cd -q "$*"
	command test -n "$(git status --porcelain --ignore-submodules ${umode})" &>/dev/null
	(($? == 0)) && echo "*"
}

async_git_fetch() {
	# use cd -q to avoid side effects of changing directory, e.g. chpwd hooks
	cd -q "$*"

	# set GIT_TERMINAL_PROMPT=0 to disable auth prompting for git fetch (git 2.3+)
	GIT_TERMINAL_PROMPT=0 command git -c gc.auto=0 fetch
}

async_tasks() {
	# initialize async worker
	((!${async_init:-0})) && {
		async_start_worker "prompt_pure" -u -n
		async_register_callback "prompt_pure" async_callback
		async_init=1
	}

	# get the current git working tree, empty if not inside a git directory
	local working_tree="$(command git rev-parse --show-toplevel 2>/dev/null)"

	# check if the working tree changed, it is prefixed with "x" to prevent variable resolution in path
	if [ "${current_working_tree:-x}" != "x${working_tree}" ]; then
		# stop any running async jobs
		async_flush_jobs "prompt_pure"

		# reset git preprompt variables, switching working tree
		unset git_dirty
		unset git_delay_dirty_check

		# set the new working tree, prefixed with "x"
		current_working_tree="x${working_tree}"
	fi

	# only perform tasks inside git working tree
	[[ "${working_tree}" != "" ]] || return

	# tell worker to do a git fetch
	async_job "prompt_pure" async_git_fetch "$working_tree"

	# if dirty checking is sufficiently fast, tell worker to check it again, or wait for timeout
	local dirty_check=$(( $EPOCHSECONDS - ${git_delay_dirty_check:-0} ))
	if (( $dirty_check > ${PURE_GIT_DELAY_DIRTY_CHECK:-1800} )); then
		unset git_delay_dirty_check
		(( ${PURE_GIT_PULL:-1} )) &&
		# make sure working tree is not $HOME
		[[ "${working_tree}" != "$HOME" ]] &&
		# check check if there is anything to pull
		async_job "prompt_pure" async_git_dirty "${PURE_GIT_UNTRACKED_DIRTY:-1}" "$working_tree"
	fi
}

async_callback() {
	local job=$1
	local output=$3
	local exec_time=$4

	case "${job}" in
		async_git_dirty)
			git_dirty=$output
			preprompt_render

			# when git_delay_dirty_check is set, the git info is displayed in a different color, this is why the
			# prompt is rendered before the variable is (potentially) set
			(( $exec_time > 2 )) && git_delay_dirty_check=$EPOCHSECONDS
			;;
		async_git_fetch)
			git_arrows=$(check_git_arrows)
			preprompt_render
			;;
	esac
}

setup() {
  
  eval `dircolors $HOME/.dotfiles/conf/dircolors.conf`

  # show vim mode on RPS1
  function zle-line-init zle-keymap-select {
      VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
      RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
      zle reset-prompt
  }

  zle -N zle-line-init
  zle -N zle-keymap-select
  export KEYTIMEOUT=1

	# include zsh-syntax-highlighting
	source ~/.dotfiles/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  # configure colors
  # list of indices http://i.stack.imgur.com/UQVe5.png
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(pattern main brackets)
	ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan'
	ZSH_HIGHLIGHT_STYLES[path]='fg=033'
	ZSH_HIGHLIGHT_STYLES[alias]='fg=118'
	ZSH_HIGHLIGHT_STYLES[function]='fg=192'
	ZSH_HIGHLIGHT_PATTERNS+=('sudo *' 'bg=1')

	# ignore underscore-prefixed completions
	# see http://unix.stackexchange.com/a/116205/66370
	zstyle ':completion:*:*:-command-:*:*' ignored-patterns '_*'

	# prevent percentage showing up
	# if output doesn't end with a newline
	export PROMPT_EOL_MARK=''

  # set correct encoding 
   export LC_ALL=en_US.UTF-8

	prompt_opts=(cr subst percent)

	zmodload zsh/datetime
	autoload -Uz add-zsh-hook
	autoload -Uz vcs_info

	zstyle ':vcs_info:*' enable git
	zstyle ':vcs_info:*' use-simple true
	zstyle ':vcs_info:git*' formats ' %b'
	zstyle ':vcs_info:git*' actionformats ' %b|%a'

	# show username@host if logged in through SSH
	[[ "$SSH_CONNECTION" != '' ]] && username=' %F{242}%n@%m%f'

	# show username@host if root, with username in white
	[[ $UID -eq 0 ]] && username=' %F{white}%n%f%F{242}@%m%f'

	# prompt turns red if the previous command didn't exit with 0
	PROMPT="%(?.%F{magenta}.%F{red})${PURE_PROMPT_SYMBOL:-->}%f "
}

setup "$@"
