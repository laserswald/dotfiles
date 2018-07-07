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
    :
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
export PS1="${fblue}$(hostname)${normal}\$(prompt_dir)\$(prompt_git)\$(prompt_last_status) "

[ $TERM = "dumb" ] && export PS1='$ '
