# -----------------------------------------------
# Set up the prompt
# -----------------------------------------------

# root prompt
[ $UID = 0 ] && export PROMPT=$'%{\e[0;31m%}[%{\e[0m%}%n%{\e[0;31m%}@%{\e[0m%}hostname%{\e[0;31m%}:%{\e[0m%}%~%{\e[0;31m%}]%{\e[0m%}%# '
# normal user prompt
[ $UID != 0 ] && export PROMPT=$'%{\e[0;36m%}[%{\e[0m%}%n%{\e[0;36m%}@%{\e[0m%}hostname%{\e[0;36m%}:%{\e[0m%}%~%{\e[0;36m%}]%{\e[0m%}%# '

autoload -U promptinit
promptinit
prompt adam2

export CLICOLOR=1
export LSCOLORS=CxFxExDxBxegedabagacad

# -----------------------------------------------
# Set zsh options
# -----------------------------------------------

setopt \
	no_beep \
	correct \
	auto_list \
	complete_in_word \
	auto_pushd \
	complete_aliases \
	extended_glob \
	zle


