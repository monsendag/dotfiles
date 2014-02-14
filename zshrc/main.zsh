
# allow to define independent environment variables in ~/.environment
if [ -f "$HOME/.environment" ]; then
	source "$HOME/.environment"
fi

# load oh-my-zsh
source $HOME/.dotfiles/zshrc/oh-my-zsh.zsh
# load pure theme
source $HOME/.dotfiles/zshrc/pure.zsh

export JAVA_HOME=$(/usr/libexec/java_home)

export LC_ALL=no_NO.UTF-8;
export LANG=no_NO.UTF-8;

alias gr='cd $(git root)'
export EDITOR=vim

alias ls='ls -Gh'
alias subs='filebot -get-subtitles'
alias mou='open -a Mou'
alias subl='Open -a "Sublime Text 2"'
alias br='Open -a "Brackets"'

# ZMV
autoload zmv
alias zmz='noglob zmv'
alias zcp='noglob zmv -C'

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"
