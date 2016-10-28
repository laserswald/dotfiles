# Laserswald's standard profile. This is loaded only once.

# Say something funny.
command -v fortune >/dev/null 2>&1 && fortune

# Link ~/tmp to a temp directory.
export ENV="$HOME/.shrc"

#set up dir colors
d=.dircolors
test -r $d && eval "$(dircolors $d)"

source $ENV
