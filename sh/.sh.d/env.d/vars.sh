. "$HOME/.local/lib/sh/preferred_app.sh"
# Preferred applications

export EDITOR="$(preferred_app kak nvim vis vim vi)"
export VISUAL="$EDITOR"

export BROWSER="firefox"
export PAGER="less -R"
export TERMINAL="$(preferred_app st alacritty termite urxvt xterm)"

export FONT="Tamzen:size=9"

