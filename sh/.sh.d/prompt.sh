fblack=`tput setaf 0`
fred=`tput setaf 1`
fgreen=`tput setaf 2`
fyellow=`tput setaf 3`
fblue=`tput setaf 4`
fmagenta=`tput setaf 5`
fcyan=`tput setaf 6`
fwhite=`tput setaf 7`
normal=`tput sgr0`

prompt_dir () {
    printf " %s" "$(pwd | sed 's:'$HOME':~:g')"
}

prompt_git () {
    if [ $(git rev-parse --abbrev-ref HEAD 2>/dev/null) ]; then
		printf " ${fyellow}%s${normal}" $(git rev-parse --abbrev-ref HEAD)
	fi
}

prompt_status_color () {
	if [ "$?" -eq 0 ]; then
		printf "${fgreen}"
	else
		printf "${fred}"
	fi
}

prompt () {
	statusc=$(prompt_status_color)
	printf "%s" "${fblue}$(hostname)${normal} $(prompt_dir)$(prompt_git) ${statusc}\$${normal} "
}

prompt_last_status () {
	char="$1"
	if test $? -eq 0; then
		echo " ${fgreen}:${normal}"
	else
		echo " ${fred}:${normal}"
	fi
}

# Micro
export PS1="\$(prompt)"

[ $TERM = "dumb" ] && export PS1='$ '

