provide-module -override villain %{
    require-module scheme

	declare-option str villain_repl_cmd
	declare-option str villain_within_lib_cmd
	declare-option str villain_load_file_cmd

    define-command villain-funcinfo -docstring "Display information about a selected function" %{
        evaluate-commands -draft %{
            try %{
                execute-keys '[b;/\S+<ret>'
                evaluate-commands %sh{
                    f=${kak_selection%?}
                    sig='\tsignature:(.*)'
                    csn='\t(class|struct|namespace|record|library):\(([^\t]+)\)'
                    sigs=$(${kak_opt_readtagscmd} -e -Q '(eq? $kind "f")' "${f}" | sed -Ee "s/^.*${csn}.*${sig}$/\3 [\2]/ ;t ;s/^.*${sig}$/\1 [${f}]/")
                    if [ -n "$sigs" ]; then
                        printf %s\\n "evaluate-commands -client ${kak_client} %{info -anchor $kak_cursor_line.$kak_cursor_column -style above '$sigs'}"
                    fi
                }
            }
        }
    }

    define-command villain-enable-autoinfo -docstring "Automatically display ctags information about function" %{
		remove-hooks window ctags-autoinfo
		hook window -group villain-autoinfo NormalIdle .* villain-funcinfo
		hook window -group villain-autoinfo InsertIdle .* villain-funcinfo
    }

    define-command villain-disable-autoinfo -docstring "Disable automatic ctags information displaying" %{ remove-hooks window villain-autoinfo }

    define-command villain-eval -params 0..1  %{
        repl-send-text "%arg{1}"
        nop %sh{
            # Fix for silliness
            tmux send-keys -t "$kak_opt_tmux_repl_id" Enter
        }
    }

    define-command villain-select-library-name %{
        # Find the library declaration, if any
        villain-select-form-named "define-library"
    }

    define-command villain-repl %{
        tmux-repl-vertical "%opt{villain_repl_cmd}"
        try %{
	        villain-switch-library
        }
    }

    define-command villain-load %{
        %opt{villain_load_file_cmd} "%val{buffile}"
    }

    define-command villain-switch-library %{
	    villain-select-library-name
	    execute-keys "mf(m"
        %opt{villain_within_lib_cmd} %val{selection}
    }

    #
    # Select a Scheme form with the value given in the car position.
    # 
    define-command -params 1..1 villain-select-form-named %{
        # Search backwards for an open parenthesis and the name
        execute-keys "<a-/>\(%arg{1} <ret>"

        # Select to the matching parenthesis and the rest of the line
        execute-keys '<a-f>(m'
    }


    define-command -params 1..1 villain-eval-form-named %{
        villain-select-form-named %arg{1}
        villain-eval %val{selection}
    }

    define-command villain-enable-chibi %{
		set-option window villain_repl_cmd "rlwrap -t dumb -pblue chibi-scheme -R -I ."
        set-option window villain_within_lib_cmd "@in"
        set-option window villain_load_file_cmd 'villain-load-file-r7rs'
    }

    define-command villain-enable-gauche %{
		set-option window villain_repl_cmd "rlwrap -t dumb -pblue gosh -r7 -A ."
        set-option window villain_within_lib_cmd "villain-switch-library-gauche"
        set-option window villain_load_file_cmd 'villain-load-file-r7rs'
    }

    define-command -hidden -params 1..1 villain-switch-library-gauche %{
	    villain-eval "(select-module r7rs.user)"
	    villain-load
	    evaluate-commands %sh{
		    libname=$(echo "$1" | tr -d "()" | tr " " ".")
		    printf "%s\n" "villain-eval %{(select-module $libname)}"
	    }
	    villain-eval ",use gauche.base"
    }

    define-command -hidden -params 1..1 villain-load-file-r7rs %{
	    villain-eval "(import (scheme base) (scheme load)) (load ""%arg{1}"")"
    }

} # provide-module

provide-module scheme-fancy-highlighting %{
	add-highlighter shared/scheme/custom-defines regex 'define-[\w-]+' 0:keyword
} # provide-module scheme-fancy-highlighting

hook global WinSetOption filetype=scheme %{
    set-option buffer indentwidth 2
    set-option buffer tabstop 2

    parinfer-enable-window -smart
    rainbow-enable-window

    require-module villain
    villain-enable-gauche

    map -docstring "Open a Scheme repl." \
	   	buffer user R '<esc>: villain-repl<ret>'

    map -docstring "Send selection to repl window" \
    	buffer user s '<esc>: villain-eval<ret>'

    map -docstring "Send current definition to repl window" \
    	buffer user S '<esc>: villain-eval-form-named define<ret>'

    map -docstring "Load this file" \
    	buffer user l '<esc>: villain-load<ret>'

    map -docstring "Switch to this library" \
    	buffer user S '<esc>: villain-switch-library<ret>'

	require-module scheme-fancy-highlighting
}


