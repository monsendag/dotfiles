# cygwin configuration

alias pbcopy='cat >/dev/clipboard'
alias pbpaste='cat /dev/clipboard'
alias open='cygstart'
alias -g .,='cygpath -wa .'
alias killall='taskkill /F /IM'

# set up ssh-agent to remember ssh auth through session
eval `ssh-agent` > /dev/null
# run ssh-add on first call to ssh
alias ssh='ssh-add -l || ssh-add && ssh'