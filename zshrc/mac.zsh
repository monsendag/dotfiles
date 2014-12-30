
# JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home)

# mac specific aliases
$(hub alias -s)
alias mou='open -a Mou'
alias subl='Open -a "Sublime Text 2"'
alias br='Open -a "Brackets"'
alias v='qlmanage 2>/dev/null -p'
alias rstudio='open -a "Rstudio"'
alias javarepl='java -jar /usr/local/lib/javarepl.jar'
alias trs='trash'	
alias b2='boot2docker'
alias serve='open http://localhost:8080 && static' 

# load virtualenvwrapper
[ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh;

# load autoenv
[ -f /usr/local/opt/autoenv/activate.sh ] && source /usr/local/opt/autoenv/activate.sh;


# initialize autoenv
# autoenv_init


