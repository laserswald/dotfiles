# Personal template directory.
export SKELDIR="$HOME/skel"

[[ ! -d "$SKELDIR" ]] && mkdir "$SKELDIR"

# Create a node from a template
skel() {
    template="$1"
    target="$2"

    if [ ! -e "$SKELDIR/$template" ]; then
        echo "skel: no template '$template'" >&2
        return 1
    fi

    cp -r "$SKELDIR/$template" "$target"

    return 0
}

cskel() {
    cp -r "$2" "$SKELDIR/$1"
}

lsskel() {
    ls "$SKELDIR"
}
