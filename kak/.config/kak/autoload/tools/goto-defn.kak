#
# Globally useful code navigation tools.
# 

set-option global grepcmd 'ag --column'

define-command -override grep-find-references %{
	evaluate-commands %sh{
		if [ "$kak_selection_length" -eq 1 ]; then
		    printf %s\\n "execute-keys <a-i>w"
		fi
		printf %s\\n "grep $kak_selection ."
	}
}

try %{
	alias global jump-to-definition ctags-search
	alias global tag ctags-search
}

alias global find-references grep-find-references
