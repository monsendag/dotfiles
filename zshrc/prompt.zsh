# zsh prompt
# based on pure by Sindre Sorhus
# https://github.com/sindresorhus/pure
# MIT License

# threshold (sec) for showing cmd exec time
CMD_MAX_EXEC_TIME=5

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

# turns seconds into human readable time
# 165392 => 1d 21h 56m 32s
human_time() {
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

# fastest possible way to check if repo is dirty
git_dirty() {
	# check if we're in a git repo
	command git rev-parse --is-inside-work-tree &>/dev/null || return
	# check if it's dirty
	command git diff --quiet --ignore-submodules HEAD &>/dev/null 

	[ $? -eq 1 ] && echo '*'
}

# displays the exec time of the last command if set threshold was exceeded
cmd_exec_time() {
	local stop=$EPOCHSECONDS
	local start=${cmd_timestamp:-$stop}
	integer elapsed=$stop-$start
	(($elapsed > ${MAX_EXEC_TIME:=5})) && human_time $elapsed
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
	echo ${#${(S%%)1//(\%([KF1]|)\{*\}|\%[Bbkf])}}
}

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

precmd() {
	# shows the full path in the title
	print -Pn '\e]0;%~\a'

	# git info
	vcs_info

	# replace $HOME with ~ (%~ also replaces with other vars like ~WORKON_HOME
	local currentpath="%F{33}$(collapse_pwd)"
	 
	local gitinfo="%F{242}$vcs_info_msg_0_$(git_dirty)"
	local exectime="%F{yellow}$(cmd_exec_time)"

	local preprompt="\n$userhost%f ${currentpath}${gitinfo} ${exectime}%f"
	print -P $preprompt

	# check async if there is anything to pull
	(( ${GIT_PULL:-1} )) && {
		# check if we're in a git repo
		command git rev-parse --is-inside-work-tree &>/dev/null &&
		# check check if there is anything to pull
		command git fetch &>/dev/null &&
		# check if there is an upstream configured for this branch
		command git rev-parse --abbrev-ref @'{u}' &>/dev/null && {
			local arrows=''
			(( $(command git rev-list --right-only --count HEAD...@'{u}' 2>/dev/null) > 0 )) && arrows='⇣'
			(( $(command git rev-list --left-only --count HEAD...@'{u}' 2>/dev/null) > 0 )) && arrows+='⇡'
			print -Pn "\e7\e[A\e[1G\e[`string_length $preprompt`C%F{151}${arrows}%f\e8"
		}
	} &!

	# reset value since `preexec` isn't always triggered
	unset cmd_timestamp
}

setup() {
	# prevent percentage showing up
	# if output doesn't end with a newline
	export PROMPT_EOL_MARK=''

	prompt_opts=(cr subst percent)

	zmodload zsh/datetime
	autoload -Uz add-zsh-hook
	autoload -Uz vcs_info

	add-zsh-hook precmd precmd
	add-zsh-hook preexec preexec

	zstyle ':vcs_info:*' enable git
	zstyle ':vcs_info:git*' formats ' %b'
	zstyle ':vcs_info:git*' actionformats ' %b|%a'

	# set ls colors
	eval `dircolors $HOME/.dotfiles/conf/dircolors.conf`


	# include zsh-syntax-highlighting
	source ~/.dotfiles/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

	ZSH_HIGHLIGHT_HIGHLIGHTERS=(pattern main brackets)
	ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan'
	ZSH_HIGHLIGHT_STYLES[path]='fg=33'
	ZSH_HIGHLIGHT_STYLES[alias]='fg=199'
	ZSH_HIGHLIGHT_STYLES[function]='fg=184'
	ZSH_HIGHLIGHT_PATTERNS+=('sudo *' 'bg=1')

	# ignore underscore-prefixed completions
	# see http://unix.stackexchange.com/a/116205/66370
	zstyle ':completion:*:*:-command-:*:*' ignored-patterns '_*'

	# Make zsh know about hosts already accessed by SSH
	zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

	# allow overriding hostname with $CUSTOM_HOST
	# used especially on AWS
	[[ -n $CUSTOM_HOST ]] && host="$CUSTOM_HOST" || host=$(hostname -s)

	# show username@host if logged in through SSH or inside docker container
	[[ "$SSH_CONNECTION" != '' || -f /.dockerenv ]] && userhost="%F{143}%n%F{242}@%F{136}$host"

	# prompt turns red if the previous command didn't exit with 0
	PROMPT='%(?.%F{magenta}.%F{red})->%f '
}

setup "$@"
