
# because typing 'cd' is A LOT of work!!
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

alias v='vim'
alias o='open'
alias a='atom'

# reload zsh config
alias reload='. ~/.zshrc'

# simple hack to reset ls command 
# unalias ls
alias ls='ls --color'

alias vrc='vim ~/.vimrc'

alias l='ls -lFh --time-style=long-iso'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='l -t'   #long list,sorted by date,show type,human readable
alias ldot='ls -ld .*'

alias cr='cd "$(git root)"'
alias sr='cd $(svn info | grep "Working Copy Root Path:" | sed "s/.*://")'
alias less='less -S' # enable horizontal scrolling in less
alias s='ssh'
alias m='mosh'
alias subs='filebot -get-missing-subtitles'
alias ta='tmux a'
alias c='z'
alias d='docker'
alias dc='docker-compose'
alias dm='docker-machine --native-ssh'

# https://medium.com/@pixelstack/what-i-learnt-when-i-switched-to-docker-machine-71c4a9d11f4e
alias dcc='rm -v $(docker ps -a -q -f status=exited)'
alias dci='docker rmi $(docker images -f "dangling=true" -q)'

alias rm='rm -v'
alias gr='git remote -v'
alias t='tail -f'

alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g C='pbcopy'
alias -g P='pbpaste'


alias p='ps -f'

alias dud='du -d 1 -h'
alias duf='du -sh * | sort -h'
alias fd='noglob find . -type d -iname'
alias ff='noglob find . -type f -iname'

# git aliases
alias gst='git status'
alias gci='git commit'
alias gdf='git diff'
alias gbr='git branch'

alias cp='cp -v'
alias mv='mv -v'
alias zmv='noglob zmv'
alias zcp='noglob zmv -C'

# for transferring large data files over local network
# on receiving node run $ files-receive to start receiving hook
# on transferring node, run files send $folder $hostname
files-receive() {
  echo "Waiting for transfer.. Run files-send $HOST to send files here"
  'nc -l -p 1234 | tar xv'
}

files-send() {
  echo "transferring $1 to $2"
  tar cv "$1" | nc "$2" 1234
}

