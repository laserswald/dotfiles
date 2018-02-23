
define-command -allow-override autotags-enable %{
    hook -group autotags buffer BufWritePost .* %{ evaluate-commands %{ ctags-update-tags } } 
}

define-command -allow-override autotags-disable %{
    remove-hooks buffer autotags
}
