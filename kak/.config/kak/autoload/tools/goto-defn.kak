#
# Globally useful code navigation tools.
#

# A command that should select the current symbol and attempt to jump to it.
declare-option -hidden str lazr_defn_handler "ctags-goto-definition"

# A command that should select the current symbol and look for all of it's references.
declare-option -hidden str lazr_refs_handler "grep-find-references"

define-command -override goto-definition %{
	evaluate-commands %opt{lazr_defn_handler}
}

define-command -override find-references %{
	evaluate-commands %opt{lazr_refs_handler}
}

define-command -override ctags-goto-definition %{
    select-symbol
    evaluate-commands %sh{
        printf %s\\n "ctags-search"
    }
}

define-command -override grep-find-references %{
    select-symbol
    evaluate-commands %sh{
        printf %s\\n "grep -w $kak_selection ."
    }
}

define-command -override -hidden select-symbol %{
    evaluate-commands %sh{
        if [ "$kak_selection_length" -eq 1 ]; then
            printf %s\\n "execute-keys <a-i>w"
        fi
    }
}

define-command \
	-override \
	-hidden \
lazr-use-lsp %{
	 set-option window lazr_defn_handler 'lsp-definition'
	 set-option window lazr_refs_handler 'lsp-references'
}

define-command -override -params 1..1 lazr-autodetect-lsp \
%{ evaluate-commands %sh{
	if command -v "$1" >/dev/null 2>&1
	then
		 printf '%s\n' "lazr-use-lsp"
		 printf '%s\n' "echo -debug 'lazr-autodetect-lsp: enabling lsp jumping'"
	else
		 printf '%s\n' "echo -debug 'lazr-autodetect-lsp: could not find lsp server $1'"
	fi
}}
