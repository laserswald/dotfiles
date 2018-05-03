# sfm.kak
#
# Super simple file explorer

declare-option -hidden str sfm_dir

try %{
    remove-hooks buffer explore-hooks
    remove-hooks global explore-hooks
}

add-highlighter shared/ group sfm
add-highlighter shared/sfm regex ^(.*/)$ 1:variable

define-command -allow-override -params 0..1 explore %{
    %sh{
    	dir="."
    	[ -e "$1" ] && dir="$1"
    	dir=$(readlink -f "$dir")
    	output=$(mktemp -d "${TMPDIR:-/tmp}"/kak-explore.XXXXXXXX)/fifo
    	mkfifo ${output}
    	(ls -1p "$dir" | sort >${output} 2>&1) > /dev/null < /dev/null 2>&1 &
    	printf %s\\n "
    	try %{ delete-buffer *explore* }
    	edit! -fifo ${output} *explore*
     	set-option buffer filetype explore
     	set-option buffer sfm_dir '$dir'
    	"
    }
}

hook global -group explore-hooks RuntimeError "\d+:\d+: '\w+' (.*): is a directory" %{ %sh{
	echo "explore" $kak_hook_param_capture_1
}}

hook global -group explore-hooks NormalKey <minus> explore-up

hook global WinSetOption filetype=explore %{
    hook buffer -group explore-hooks NormalKey <ret> explore-down
    add-highlighter buffer ref sfm
}

define-command -allow-override -hidden explore-up %{ %sh{
	if [ "${kak_opt_sfm_dir}" ]; then
		echo 'explore' "$kak_opt_sfm_dir/.."
	else
		echo 'explore' ".."
	fi
}}

define-command -allow-override -hidden explore-down %{
    execute-keys <a-l><a-h>
	evaluate-commands %{ %sh{
    	file="${kak_opt_sfm_dir}/${kak_selection}"
    	if [ -d "$file" ]; then
    		echo 'explore' "$file"
    	else 
         	echo 'edit! -existing' "$file"
        fi
    }}
}
