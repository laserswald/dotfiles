. "$HOME/.local/lib/sh/preferred_app.sh"
# Preferred applications

export EDITOR="$(preferred_app emacsclient kak)"
export VISUAL="$EDITOR"

export BROWSER="firefox"
export PAGER="less -R"
export TERMINAL="$(preferred_app alacritty kitty xst xterm)"

export FONT="Tamzen:size=9"

