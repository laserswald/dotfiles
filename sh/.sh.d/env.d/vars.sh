# Preferred applications
preferred_app() {
    for app in $@; do
        if which $app >/dev/null 2>&1; then
            which $app
            return
        fi
    done
}

export EDITOR="$(preferred_app kak nvim vis vim vi)"
export VISUAL="$EDITOR"

export BROWSER="firefox"
export PAGER="less -R"
export TERMINAL="$(preferred_app st alacritty termite urxvt xterm)"

export FONT="Tamzen:size=9"

