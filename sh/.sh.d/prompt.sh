fblack=`tput setaf 0`
fred=`tput setaf 1`
fgreen=`tput setaf 2`
fyellow=`tput setaf 3`
fblue=`tput setaf 4`
fmagenta=`tput setaf 5`
fcyan=`tput setaf 6`
fwhite=`tput setaf 7`
normal=`tput sgr0`

# Micro
PS1="\[${fblue}\]$(hostname)\[${normal}\] \$(pwd | sed 's:$HOME:~:g') \[${fgreen}\]:\[${normal}\] "
