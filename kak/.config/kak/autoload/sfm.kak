# sfm.kak
#
# Super simple file explorer

define-command -allow-override explore %{
    %sh{
    	output=$(mktemp -d "${TMPDIR:-/tmp}"/kak-explore.XXXXXXXX)/fifo
    	mkfifo ${output}
    	(ls -1 `dirname ${kak_buffile}` >${output} 2>&1) > /dev/null < /dev/null 2>&1 &
    	printf %s\\n "
    	edit! -fifo ${output} -scroll *explore*
    	set-option buffer filetype explore
    	"
    }
}

hook global WinSetOption filetype=explore %{
    hook buffer -group explore-hooks NormalKey <ret> explore-down
    hook buffer -group explore-hooks NormalKey <minus> explore-up
}

define-command -allow-override -hidden explore-up %{
}

define-command -allow-override -hidden explore-down %{
	evaluate-commands -collapse-jumps %{
    	execute-keys '<a-x>H:edit! <c-r>.<ret>'
    }
}
