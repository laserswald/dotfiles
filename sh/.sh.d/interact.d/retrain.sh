#!/bin/sh

# Retrain: tools to force you to use more general aliases

retrain (){
    alias_name=$1
    shift

    for cmd in "$@"; do
    	# Alias this command to the error doodle
    	eval "alias $cmd=\"echo retrain: Use \'$alias_name\' instead. \""
    done
}
