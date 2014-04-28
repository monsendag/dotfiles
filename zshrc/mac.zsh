
# JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home)

# mac specific aliases
alias o='open'
alias mou='open -a Mou'
alias subl='Open -a "Sublime Text 2"'
alias br='Open -a "Brackets"'
alias v='qlmanage 2>/dev/null -p'
alias javarepl='java -jar /usr/local/lib/javarepl.jar'
alias trs='trash'	

# load virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh

# load autoenv
source /usr/local/opt/autoenv/activate.sh

# initialize autoenv
autoenv_init


