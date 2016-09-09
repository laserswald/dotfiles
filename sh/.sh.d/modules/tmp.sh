# Check if the folder exists, if not create it.

[[ ! -d "/tmp/$USER" ]] && mkdir -p /tmp/$USER
[[ ! -L "$HOME/tmp" ]] && ln -s /tmp/$USER $HOME/tmp


