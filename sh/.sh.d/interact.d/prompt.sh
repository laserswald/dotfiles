#
# Lazr's prompt.
#

fblack=`tput setaf 0`
fred=`tput setaf 1`
fgreen=`tput setaf 2`
fyellow=`tput setaf 3`
fblue=`tput setaf 4`
fmagenta=`tput setaf 5`
fcyan=`tput setaf 6`
fwhite=`tput setaf 7`
normal=`tput sgr0`

# Set up nonprinting character support.

promptfirst=""
npstart=""
npend=""

case $SHELL in
	*bash)
		npstart="\["
		npend="\]"
        ;;
	*zsh)
		npstart="%{"
		npend="%}"
	;;
	*ksh) 
		promptfirst=$(print \\001)
		npstart=$promptfirst
		npend=$promptfirst
        ;;
esac

_nonprint () {
	printf "%s%s%s" "$npstart" "$1" "$npend"
}

prompt_fg () {
	printf "%s%s%s" "$(_nonprint $1)" "$2" "$(_nonprint $normal)"
}

# Different prompt components

prompt_host () {
	if command -v hostname >/dev/null 2>&1
	then
		host=$(hostname)
	else
		host=$(hostnamectl hostname)
	fi

	hostcolor=$fblue
	if [ $host = "betelgeuse" ]; then
		hostcolor=$fred
	elif [ $host = "gargantua" ]; then
		hostcolor=$fgreen
	elif [ $host = "polaris" ]; then
		hostcolor=$fred
	fi
	printf "%s" "$(prompt_fg ${hostcolor} $host)"
}

prompt_dir () {
	if [ $SHELL = "/bin/zsh" ]; then 
		printf "%%~" 
	else
		printf "%s" "$(pwd | sed 's:'$HOME':~:g')"
	fi
}

shorten () {
    len=$1
    str=$2
    if [ ${#str} -gt $len ]; then
        truncation=$(expr $len - 3)
        printf "%s..." "$(echo "$str" | cut -c 1-$truncation)"
    else
        printf "%s" $str
    fi
}

prompt_git () {
	if ! [ $(git rev-parse --abbrev-ref HEAD 2>/dev/null) ]; then
        	return 0
    	fi

    	git_branchname=`git rev-parse --abbrev-ref HEAD`

	printf " %s" $(prompt_fg $fyellow "($(shorten 20 "$git_branchname"))")

	unset git_status
}

prompt_environ () {
    if [ -n "$GUIX_ENVIRONMENT" ]; then
	printf " [%s]" $(prompt_fg $fmagenta "guix")
    elif [ -n "$IN_NIX_SHELL" ]; then
	printf " [%s]" $(prompt_fg $fmagenta "nix")
    fi
}

prompt_status_color () {
	if [ "$?" -eq 0 ]; then
		_nonprint $fgreen
	else
		_nonprint $fred
	fi
}

## Generate the prompt string

prompt () {
	statusc=$(prompt_status_color)
	printf '%s' "$(prompt_host) $(prompt_dir)$(prompt_git)$(prompt_environ) ${statusc}\$$(_nonprint $normal) "
}

case $SHELL in
	*bash)
		export PROMPT_COMMAND='export PS1=$(prompt)'
        ;;
	*ksh) 
		export PS1="$promptfirst\$(prompt)"
        ;;
	*zsh)
		setopt PROMPT_SUBST
		export PS1="\$(prompt)"
        ;;
esac

[ $TERM = "dumb" ] && export PS1='$ '

