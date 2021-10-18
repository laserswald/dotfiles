#!/bin/sh

export RC_DIR=${RC_DIR:-$HOME/etc}

install_link () {
    file="$RC_DIR/$1"
    target="$HOME/$2"

    if [ -L "$target" ]
    then
        echo "Skipping installation of $file"
        return 0
    fi

    echo "Installing '$file'"
    ln -s "$file" "$target"
}

install_bin_links () {
:
}
