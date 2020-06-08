# My organization shortcuts

declare-option str notes_directory %sh{echo "${HOME}/org"}

declare-option str notes_inbox "%opt{notes_directory}/inbox.md"

define-command refile-selections %{
	prompt \
	-shell-script-candidates %{
		ls -1 $kak_opt_notes_directory
	} \
	"refile to where? " %{
		nop %sh{
			echo "$kak_selection" >> $kak_opt_notes_directory/$kak_text
		}
		execute-keys 'd'
	}
}

define-command open-notes %{
	edit %opt{notes_inbox}
}

