alias pbcopy='clip.exe'
alias pbpaste='powershell.exe Get-Clipboard'
alias killall='taskkill.exe /F /IM'
alias open='wsl-open'
alias o=open

# nice doesn't work on WSL
# https://github.com/microsoft/WSL/issues/1887
unsetopt BG_NICE
