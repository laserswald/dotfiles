# Include my preferred XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
if [ -f "$XDG_CONFIG_HOME/user-dirs.dirs" ]; then
    # shellcheck source=/dev/null
    . "$XDG_CONFIG_HOME/user-dirs.dirs"
fi
export XDG_RUNTIME_DIR="$HOME/.local/share"
