#!/bin/false
# vim:ft=sh
[ -n "$__LAZR_LIB_PATH_SH" ] && return || readonly __LAZR_LIB_PATH_SH=1

insert_path() {
	if ! (echo "$PATH" | grep -q $1)
	then
	    export PATH="${1}:${PATH}"
    fi
}

source_dir() {
	for file in $(find $1 -maxdepth 1 -name '*.sh')
	do
		. $file
	done
}
