#!/bin/false
# vim:ft=sh

insert_path() {
    export PATH="${1}:${PATH}"
}

source_dir() {
	for file in $1/*.sh ; do
	    . $file
	done
}
