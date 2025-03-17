
provide-module simple-finder %{
    declare-option \
        -docstring "File selection for :find function" \
        str findcmd \
        'find . -path */.git/ -prune -o -type f -print'

    declare-option \
        -docstring 'indicates if a file saved is new in BufWritePost' \
        bool new_file_saved false

    define-command find \
        -docstring "Fuzzy-find a file in the current directory."\
        -override \
        -params 1 \
        -shell-script-candidates %{
            # Launch the update command.
            (
                ${kak_opt_findcmd} >.kak_find_cache_tmp
                mv .kak_find_cache_tmp .kak_find_cache
            ) >/dev/null </dev/null 2>&1 &

        	PID=$!

            if ! [ -e ".kak_find_cache" ]; then
                wait $PID
            fi

            cat ".kak_find_cache"

        } \
    %{
        edit %arg{1}
    }
}

define-command \
    -override \
simple-finder-enable %{
    require-module simple-finder

    hook -group find global BufWritePre .* %{ evaluate-commands %sh{
        if ! [ -e "${kak_bufname}" ]; then
            printf 'set-option buffer new_file_saved true'
        fi
    }}

    hook -group find global BufWritePost .* %{ evaluate-commands %sh{
        if [ "true" = "${kak_opt_new_file_saved}" ]; then
        # Launch the indexer.
        (
        	${kak_opt_findcmd} >.kak_find_cache_tmp
        	mv .kak_find_cache_tmp .kak_find_cache
        ) >/dev/null </dev/null 2>&1 &
        fi
        printf 'set-option buffer new_file_saved false'
    }}
}

