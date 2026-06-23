eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

# prepend to path
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.bin/bin:$PATH"

# append to path
export PATH="$PATH:$HOME/Projects/mor/mor-pipeline-library/resources"
export PATH="$PATH:$HOME/svv-scripts/scripts"

# sdkman JAVA_HOME
export JAVA_HOME=/home/dag/.sdkman/candidates/java/current

alias nvdbc='curl -H "X-Client: tunfor"'

alias o='wsl-open'
alias bun='bun.exe'

alias kubectl='kubectl.exe'
alias wsl='wsl.exe'
alias winget='winget.exe'
alias wgit='/usr/bin/git'

alias jen='ssh -tt login ssh jenkins'

alias bloop="powershell.exe '[console]::beep(831.6,400)'"

# https://stackoverflow.com/a/49494561
export MAVEN_OPTS="-Dorg.slf4j.simpleLogger.dateTimeFormat=HH:mm:ss,SSS \
                   -Dorg.slf4j.simpleLogger.showDateTime=true"

export ANDROID_SDK_ROOT="/usr/lib/android-sdk/"
export PATH="$PATH:${ANDROID_HOME}tools/:${ANDROID_HOME}platform-tools/"

export DENO_INSTALL="/home/dag/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
. "$DENO_INSTALL/env"

. "$HOME/.cargo/env"

export KROKI_ENDPOINT="https://kroki-jenkins.atlas.vegvesen.no"
export KROKI_TIMEOUT=1m
