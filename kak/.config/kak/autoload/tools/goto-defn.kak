#
# Globally useful code navigation tools.
#

# A command that should select the current symbol and attempt to jump to it.
declare-option -hidden str lazr_defn_handler "ctags-goto-definition"

# A command that should select the current symbol and look for all of it's references.
declare-option -hidden str lazr_refs_handler "grep-find-references"

define-command -override goto-definition %opt{lazr_defn_handler}
define-command -override find-references %opt{lazr_refs_handler}

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
