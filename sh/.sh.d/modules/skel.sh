# Personal template directory.
export SKELDIR="$HOME/skel"

[[ ! -d "$SKELDIR" ]] && mkdir "$SKELDIR"

# Create a node from a template
skel() {
    template="$1"
    target="$2"

	if ! [ "$@" ]; then
		echo "usage: $0 TEMPLATE_NAME TARGET_DIR"
	fi

    if [ ! -e "$SKELDIR/$template" ]; then
        echo "skel: no template '$template'" >&2
        return 1
    fi

    cp -r "$SKELDIR/$template" "$target"

	if test -x "$target/.skel-init"; then
		"$target/.skel-init"	
	fi

    return 0
}

mkskel() {
	if ! [ "$@" ]
	then
		echo "usage: $0 TARGET_DIR SKELETON_NAME"
		echo "Create a skeleton from a sample file or directory."
	fi

    cp -r "$1" "$SKELDIR/$2"
}

lsskel() {
    ls "$SKELDIR"
}
