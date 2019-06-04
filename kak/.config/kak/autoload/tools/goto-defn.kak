#
# Globally useful code navigation tools.
# 

provide-module goto-definition %{

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

define-command -override goto-def-doc %{

}

}
