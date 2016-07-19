# Laserswald's standard profile.

EDITOR=vim
VISUAL=$EDITOR
BROWSER=firefox
PAGER="less -R"

# Say something funny.
fortune

# Link ~/tmp to a temp directory.
if [ ! -d /tmp/ben ]; then 
	mkdir /tmp/ben
fi

export EDITOR VISUAL BROWSER XDG_CONFIG_HOME PAGER MAIL

export ENV="$HOME/.shrc"

#set up dir colors
export LS_COLORS=$(dircolors -b ~/.dircolors)
