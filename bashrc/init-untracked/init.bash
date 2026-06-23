# --------

#export UV_CACHE_DIR="/mnt/c/Data/Utvikling/Appdata/uv/cache"
#export UV_TOOL_DIR="/mnt/c/Data/Utvikling/Appdata/uv/tool"
#export UV_PYTHON_INSTALL_DIR="/mnt/c/Data/Utvikling/Appdata/uv/python"
#export UV_PYTHON_BIN_DIR="/mnt/c/Data/Utvikling/Appdata/uv/bin"

eval "$(uv generate-shell-completion zsh)"
eval "$(uv --generate-shell-completion zsh)"
#alias uv='uv.exe'
#alias uvx='uvx.exe'
#compdef _uv uv.exe
#compdef _uvx uvx.exe

export WSLENV="$WSLENV:UV_CACHE_DIR/p:UV_TOOL_DIR/p:UV_PYTHON_INSTALL_DIR/p:UV_PYTHON_BIN_DIR/p"
# --------


# ----
source "$HOME/.config/ac/ac-completion.zsh"
compdef _ac.exe ac=ac.exe

# ----

eval "$(fnm.exe env --use-on-cd --shell zsh)"
alias fnm='fnm.exe'

#alias idea='idea64.exe'

alias bfg='java -jar ~/bfg.jar'

export ANDROID_SDK_ROOT="/usr/lib/android-sdk/"
export PATH="${PATH}:${ANDROID_HOME}tools/:${ANDROID_HOME}platform-tools/"

iss() {
  command $(/usr/bin/git root)/scripts/get-issues.sh $@
}

nvdbt() {
 curl -Ls "https://nvdbapiles-v3.atlas.vegvesen.no/vegobjekter/581/$1?inkluder=metadata" \
  -H 'X-Client: tunfor' | jq
}


#source $HOME/.cargo/env

function to-jira-url {
sed -e 's/^/https:\/\/www.vegvesen.no\/jira\/browse\//'
}


export DOCKER_HOST="tcp://localhost:2375";

alias adb='adb.exe'
# alias ac='ac.exe'
 alias acr='ac login --refresh'

#export NVM_DIR="$HOME/.nvm"
#k[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

#export http_proxy=http://proxy.vegvesen.no:8080
#export https_proxy=http://proxy.vegvesen.no:8080
toast () { powershell.exe -command New-BurntToastNotification "-Text '$1'" }


#fix for gpg
#https://github.com/keybase/keybase-issues/issues/2798
export GPG_TTY=$(tty)


function idd() {
  win_path="$(wslpath -w "$1")"
  shift
  idea64.exe "$win_path" $@ &
}

function idf() {
  win_path=$(wslpath -w "$1")
  shift;
  idea64.exe -e "$win_path" $@ &
}

function idealog() {
  winpaths=()
  for arg in "$@"; do
    winpaths+=("$(wslpath -w "$arg")")
    #printf '%s\n' "$winpath"
    # command readarray -r wslpaths <<< $(wslpath -w "$arg")
  done
  #printf '%s\n' "${winpaths[@]}"
  idea '%s\n' "${wslpaths[@]}"
}

DOCKER_HOST=unix:///var/run/docker.sock
COMPOSE_HTTP_TIMEOUT=300

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

eval "$(atuin init zsh)"



