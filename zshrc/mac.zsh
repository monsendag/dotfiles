
# JAVA_HOME
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-12.jdk/Contents/Home"

export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"

# only update homebrew once a week
export HOMEBREW_AUTO_UPDATE_SECS=604800 

# mac specific aliases
alias g='gh'
alias gu='open -a GitUp'
alias mou='open -a Mou'
alias subl='Open -a "Sublime Text 2"'
alias br='Open -a "Brackets"'
alias q='qlmanage 2>/dev/null -p'
alias rstudio='open -a "Rstudio"'
alias javarepl='java -jar /usr/local/lib/javarepl.jar'
alias trs='trash'	
alias bic='brew install --cask'
