. "$HOME/.local/lib/sh/path.sh"

insert_path "$HOME/.cargo/bin"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
