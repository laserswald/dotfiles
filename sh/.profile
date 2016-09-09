# Laserswald's standard profile. This is loaded only once.

export EDITOR=nvim
export VISUAL=$EDITOR
export BROWSER=firefox
export PAGER="less -R"

# Say something funny.
fortune

# Link ~/tmp to a temp directory.
export ENV="$HOME/.shrc"

if [ ! -e /tmp/$USER ]; then
    mkdir "/tmp/$USER"
fi
if [[ ! -L ~/tmp ]]; then
    ln -s /tmp/$USER ~/tmp
fi

#set up dir colors
export LS_COLORS=$(dircolors -b ~/.dircolors)

