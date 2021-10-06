#!/bin/false
# vim:ft=sh

insert_path() {
	if ! (echo "$PATH" | grep -q $1)
	then
	    export PATH="${1}:${PATH}"
    fi
}

source_dir() {
	for file in $1/*.sh ; do
	    . $file
	done
}
