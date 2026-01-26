#!/bin/false
# vim:ft=sh
[ -n "$__LAZR_LIB_PATH_SH" ] && return || readonly __LAZR_LIB_PATH_SH=1

## Insert a path into the PATH variable, if it does not already exist.
insert_path() {
    if ! (echo "$PATH" | grep -q $1)
    then
	export PATH="${1}:${PATH}"
    fi
}

# Remove a path from the PATH variable, if it exists.
#
# Returns 1 (error) if the argument path was not in the PATH variable.
remove_path() {
    if echo "${PATH}" | grep -q -F $1
    then
	# We split by colon, remove the line (must match exactly) then join by colon again
	# grep: -v means inVerse, -F means Fixed Strings (no regex)
	export PATH=$(echo "${PATH}" | tr ":" "\n" | grep -v -F "$1" | tr "\n" ":")
	return 0
    else
	return 1
    fi 
}

# Source an entire directory of shell scripts, recursively.
source_dir() {
    for file in $(find $1 -maxdepth 1 -name '*.sh')
    do
	. $file
    done
}
