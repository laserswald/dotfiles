
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
# 
# 
promptfirst=""
npstart=""
npend=""

case $SHELL in
    *bash)
		npstart="\["
		npend="\]"
        ;;
    *ksh) 
        promptfirst=$(print \\001)
		npstart=$promptfirst
		npend=$promptfirst
        ;;
esac

nonprint() {
    printf "%s%s%s" $npstart $1 $npend
}

fg() {
    printf "%s%s%s" "$(nonprint $1)" "$2" "$(nonprint $normal)"
}

## Different prompt components

prompt_dir () {
    printf "%s" "$(pwd | sed 's:'$HOME':~:g')"
}

prompt_git () {
    if [ $(git rev-parse --abbrev-ref HEAD 2>/dev/null) ]; then
		printf " %s" $(fg $fyellow "($(git rev-parse --abbrev-ref HEAD))")
	fi
}

prompt_status_color () {
	if [ "$?" -eq 0 ]; then
		nonprint $fgreen
	else
        nonprint $fred
	fi
}

## Generate the prompt string

prompt () {
	statusc=$(prompt_status_color)
	printf '%s' "$(fg ${fblue} $(hostname)) $(prompt_dir)$(prompt_git) ${statusc}\$$(nonprint $normal) "
}

case $SHELL in
    *bash)
        export PROMPT_COMMAND='export PS1=$(prompt)'
        ;;
    *ksh) 
		# Micro
		export PS1="\$(prompt)"
        ;;
    *zsh)
		setopt PROMPT_SUBST
		export PS1="$(prompt)"
        ;;
esac


[ $TERM = "dumb" ] && export PS1='$ '

