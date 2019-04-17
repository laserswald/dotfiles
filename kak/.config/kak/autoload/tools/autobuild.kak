
define-command autobuild-enable %{
    hook -group autobuild buffer BufWritePost .* %{ evaluate-commands %{ make } } 
}

define-command autobuild-disable %{
    remove-hooks buffer autobuild
}
