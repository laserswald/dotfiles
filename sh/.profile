# Laserswald's standard profile. This is loaded only once.

export LC_CTYPE="en_US.UTF-8"
export ENV="$HOME/.shrc"

. ~/.local/lib/sh/path.sh

source_dir "$HOME/.sh.d/env.d"

source_dir "$HOME/.sh.d/interact.d"

# Say something funny.
command -v fortune >/dev/null 2>&1 && fortune

source_dir "$HOME/.sh.d/login.d"

