[ -n "$__LIB_PREFERRED_APP_SH__" ] && return || readonly __LIB_PREFERRED_APP_SH__=1

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
