. "$HOME/.local/lib/sh/path.sh"

# Standard paths for bins. 
insert_path "$HOME/.local/bin" # Installed separately
insert_path "$HOME/bin"        # One-off or local scripts

# Ensure that Guix's binaries are in the path
insert_path "$HOME/.config/guix/current/bin"

# Add homebrew if we are on macOS
insert_path "/opt/homebrew/bin"

export FONT="Tamzen:size=9"

# Environmental paths
export SRC_PATH="$HOME/src"
export MAIL="$HOME/var/mail"
export ORG_PATH="$HOME/org"
export PUNCH_FILE="$ORG_PATH/.punches"
