#!/bin/false
# vim:ft=sh
[ -n "$__LIB_PREFERRED_APP_SH__" ] && return || readonly __LIB_PREFERRED_APP_SH__=1

# Choose an application, in order of preference.
#
# Each application is an argument to this shell function. The first argument
# that actually exists is printed to STDOUT.
preferred_app () {
    for app in $@
    do
        if which $app >/dev/null 2>&1
        then
            which $app
            return 0
        fi
    done
    return 1
}
