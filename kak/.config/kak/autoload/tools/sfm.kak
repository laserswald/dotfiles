# sfm.kak
#
# Super simple file explorer

declare-option -hidden str sfm_dir
declare-option -hidden str sfm_temp_dir

try %{
    remove-hooks buffer explore-hooks
    remove-hooks global explore-hooks
    remove-highlighter shared/sfm
}

add-highlighter shared/sfm regions
add-highlighter shared/sfm/default default-region group
add-highlighter shared/sfm/default/files regex '^.+$' 0:Default
add-highlighter shared/sfm/default/dirs regex '^.+/$' 0:keyword
add-highlighter shared/sfm/default/dirs regex '^.+/$' 0:keyword

define-command -override -params 0..1 explore %{
    evaluate-commands %sh{
    	# Default directory is the current one.
    	dir=$(dirname "$kak_buffile")

		# If we have an argument, set the directory to that.
    	[ -e "$1" ] && dir="$1"

    	dir=$(readlink -f "$dir")
    	output=$(mktemp -d "${TMPDIR:-/tmp}"/kak-explore.XXXXXXXX)/fifo
    	mkfifo ${output}
    	(ls --group-directories-first -1 -p "$dir" >${output} 2>&1) > /dev/null < /dev/null 2>&1 &
    	printf %s\\n "
	    	edit! -fifo ${output} '$dir'
	     	set-option window filetype explore
	     	set-option window sfm_dir '$dir'
	     	set-option window readonly true
	     	hook -always -once buffer BufCloseFifo '' %(nop %sh(rm --recursive ${output}))
    	"
    }
}

hook global -group explore-hooks RuntimeError "\d+:\d+: '\w+' (.*): is a directory" %{
	explore %val{hook_param_capture_1}
}

map global normal <minus> ':explore-up<ret>'

hook global WinSetOption filetype=explore %{
    map window normal '<ret>' ':explore-down<ret>'
    map window normal 'q' ':delete-buffer<ret>'
    add-highlighter window/ ref sfm
}

define-command -override -hidden explore-up %{
    evaluate-commands %sh{
    	if [ "${kak_opt_sfm_dir}" ]; then
    		echo "explore '${kak_opt_sfm_dir}/..'"
    	elif [ "${kak_buffile}" ]; then 
    		echo "explore '${kak_buffile}/..'"
    	else
			echo "explore '.'"
		fi
	}
}

define-command -override -hidden explore-down %{
    execute-keys <a-l><a-h>
	evaluate-commands %sh{
    	file="${kak_opt_sfm_dir}/${kak_selection}"
    	if [ -d "$file" ]; then
    		echo 'explore' "$file"
    	else 
         	echo 'edit! -existing' "$file"
        fi
    }
}
