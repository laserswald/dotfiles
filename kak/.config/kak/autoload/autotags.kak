
define-command autotags-enable %{
    hook -group autotags buffer BufWritePost .* %{ evaluate-commands %{ ctags-update-tags } } 
}

define-command autotags-disable %{
    remove-hooks buffer autotags
}
