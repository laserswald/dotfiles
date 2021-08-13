# http://todotxt.org
# ------------------

# Detection
# ---------

hook global BufCreate .*\.?todo\.txt %{
    set-option buffer filetype todotxt
}

# Highlighters
# ------------

add-highlighter shared/todotxt regions

add-highlighter shared/todotxt/other default-region group
add-highlighter shared/todotxt/complete region '^x ' '$' fill comment

# Date format
add-highlighter shared/todotxt/other/ regex \d{4}-\d{2}-\d{2} 0:value

# Project format
add-highlighter shared/todotxt/other/ regex \+\S+ 0:keyword
add-highlighter shared/todotxt/other/ regex @\S+ 0:string

# Priorities
add-highlighter shared/todotxt/other/ regex \(A\) 0:red
add-highlighter shared/todotxt/other/ regex \(B\) 0:yellow
add-highlighter shared/todotxt/other/ regex \(C\) 0:green

hook -group todotxt-highlight global WinSetOption filetype=todotxt %{
    add-highlighter window/ ref todotxt
}

declare-option completions todotxt_completions

define-command todotxt-complete %{
	nop %sh{ {
	    header="$kak_cursor_line.$kak_cursor_column@$kak_timestamp"
	    candidates=$(
	        grep -o ' [+@][^[:space:]]\+' $kak_bufname | sort | uniq |\
            grep $kak_selection | sed 's/^ \(.*\)$/\1||\1/' | tr '\n' ' ')
	    completions="$header $candidates"
	    echo "set buffer=${kak_bufname} todotxt_completions $completions" |\
	        kak -p ${kak_session}
	} > /dev/null 2>&1 < /dev/null & }
}

define-command todotxt-enable-autocomplete %{
	set-option window completers "option=todotxt_completions"
	hook window -group todotxt-autocomplete InsertIdle .* %{
		try %{
			evaluate-commands -draft %{
				execute-keys "<space>B_"
				todotxt-complete
			}
		}
	}
}

define-command todotxt-toggle %{
	try %{
		# set to complete
        evaluate-commands -save-regs '"/' %{
	        execute-keys '<a-x><a-s><a-K>^x<ret>'
	        execute-keys -itersel "<a-h>;ix <esc>!date +%Y-%m-%d | tr '\n' ' '<ret>"
        }
	    
	} catch %{
	    # set to incomplete
        evaluate-commands -draft %{
	        execute-keys "<a-x><a-s><a-k>^x (\d{4}-\d{2}-\d{2} )?<ret>"
	        execute-keys "s^x (\d{4}-\d{2}-\d{2})? <ret>d"
        }
	}
}

hook global WinSetOption filetype=todotxt %{
    set-option buffer extra_word_chars @ + _
	todotxt-enable-autocomplete
    set-option buffer formatcmd 'env LC_ALL=C sort'
	hook buffer BufWritePre .* %{ format }
}

