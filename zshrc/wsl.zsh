alias pbcopy='clip.exe'
alias pbpaste='powershell.exe -noprofile -command Get-Clipboard'
alias killall='taskkill.exe /F /IM'
alias open='wsl-open'
alias o=open

alias npmw='cmd.exe /C npm'
alias cmd='cmd.exe /C'

# nice doesn't work on WSL
# https://github.com/microsoft/WSL/issues/1887
unsetopt BG_NICE

wslrealpath() {
  if ( echo "$1" | grep -E -q '^(/c|/mnt/c)')
  # git bash returns paths prefixed with c
  then
    wslpath -wa "$1"
  # otherwise we are working on a repo within the WSL VM: use Linux git
  else
    realpath "$1"
  fi
}

unalias cr 2>/dev/null
cr() {
   cd "$(wslrealpath "$(git root)")" || return
}
