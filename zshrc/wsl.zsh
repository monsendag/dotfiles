alias pbcopy='clip.exe'
alias pbpaste='powershell.exe Get-Clipboard'
alias 'o.'='explorer.exe .'
alias killall='taskkill.exe /F /IM'

# nice doesn't work on WSL
# https://github.com/microsoft/WSL/issues/1887
unsetopt BG_NICE
