# sfm.kak
#
# Super simple file explorer

define-command \
    -docstring "Enable my simple explorer." \
simple-explorer-enable %{
    require-module simple-explorer
    map global normal <minus> ': explore-up<ret>'
}

define-command \
    -docstring "Disable my simple explorer." \
simple-explorer-disable %{
    remove-hooks buffer explore-hooks
    remove-hooks global explore-hooks
    remove-highlighter shared/sfm
    unmap global normal <minus> ': explore-up<ret>'
}

provide-module simple-explorer %{

declare-option -hidden str sfm_dir
declare-option -hidden str sfm_temp_dir

add-highlighter shared/sfm regions
add-highlighter shared/sfm/default default-region group
add-highlighter shared/sfm/default/files regex '([^\n]+)[\n]' 1:default
add-highlighter shared/sfm/default/dirs regex '([^\n]+/)[\n]' 1:variable

define-command -docstring \
"explore <path>: explore a directory" \
explore -params 1..1 %{ evaluate-commands %sh{
    dir=$1

    # If the given path is a link, follow it.
    if [ -L "$dir" ]
    then 
        dir=$(readlink "$dir")
    fi

    # Try to resolve the path.
    if [ `uname` == "Darwin" ]
    then
        # For some godforsaken reason, macOS doesn't have `realpath`.
        abspath() {
            pushd . > /dev/null
            if [ -d "$1" ]
            then
                cd "$1"
                dirs -l +0
            else
                cd "`dirname \"$1\"`"
                cur_dir=`dirs -l +0`
                if [ "$cur_dir" == "/" ]
                then
                    echo "$cur_dir`basename \"$1\"`"
                else
                    echo "$cur_dir/`basename \"$1\"`"
                fi
            fi
            popd > /dev/null
        }
        dir=$(abspath "$dir")
    else
        dir=$(realpath "$dir")
    fi

    # Open a fifo and pump the output of `ls` into it.
    output=$(mktemp -d "${TMPDIR:-/tmp}"/kak-explore.XXXXXXXX)/fifo
    mkfifo ${output}
    (ls -F -1 -p "$dir" >${output} 2>&1) > /dev/null < /dev/null 2>&1 &

    # Open that file as a fifo.
    printf %s\\n "
        edit! -readonly -fifo ${output} '$dir'
        set-option window filetype explore
        set-option window sfm_dir '$dir'
        hook -always -once buffer BufCloseFifo '' %(nop %sh(rm --recursive ${output}))
    "
}}


hook global -group explore-hooks RuntimeError "\d+:\d+: '\w+' (.*): is a directory" %{
    explore %val{hook_param_capture_1}
}

hook global -group explore-hooks WinSetOption filetype=explore %{
    set-option window readonly true

    map window normal '<ret>' ': explore-down<ret>'
    map window normal 'q' ': explore-close<ret>'
    map window normal 'o' ': explore-new-file<ret>'
    map window normal 'm' ': explore-make-directory<ret>'

    add-highlighter window/ ref sfm
}

define-command explore-close %{
    delete-buffer!
}

define-command explore-new-file %{
	prompt "Open file: " %{ edit "%opt{sfm_dir}/%val{text}" }
}

define-command -override explore-make-directory %{
	prompt "Create directory: " %{ nop %sh{ mkdir "$kak_opt_sfm_dir/$kak_text" } }
	explore %opt{sfm_dir}
}

define-command explore-up %{ evaluate-commands %sh{
    if [ "${kak_opt_sfm_dir}" ]; then
        # We are in a directory. Explore the parent directory.
        echo "explore '${kak_opt_sfm_dir}/..'"
    elif [ "${kak_buffile}" ]; then
        # We have a buffer. Explore the enclosing directory.
        dir=$(dirname "${kak_buffile}")
        echo "explore '$dir'"
    else
        echo "explore '.'"
    fi
}}

define-command -hidden explore-down %{
    execute-keys <a-l><a-h>
    evaluate-commands %sh{
    	file="${kak_opt_sfm_dir}/${kak_selection}"
    	if [ -d "$file" ]; then
            printf "explore '%s'\n"  "$file"
    	else 
            printf "edit -existing '%s'\n"  "$file"
        fi
    }
}

} # provide-module simple-explorer

