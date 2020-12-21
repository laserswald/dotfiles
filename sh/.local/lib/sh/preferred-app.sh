
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
