fblack=`tput setaf 0`
fred=`tput setaf 1`
fgreen=`tput setaf 2`
fyellow=`tput setaf 3`
fblue=`tput setaf 4`
fmagenta=`tput setaf 5`
fcyan=`tput setaf 6`
fwhite=`tput setaf 7`
normal=`tput sgr0`

# Git branch
function gb {
    branch=$(git branch 2>/dev/null | grep \* | tr -d '*')
    echo "${fmagenta}${branch}${normal}"
}

# Default
PS1="${fgreen}$(id -nu)${normal} at ${fblue}$(hostname)${normal} \$(pwd | sed s:$HOME:~:g)\$(gb)>${normal} "

# Micro
#PS1="\${PWD} ${fgreen}:${normal} "
