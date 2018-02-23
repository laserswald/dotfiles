
define-command -allow-override autobuild-enable %{
    hook -group autobuild buffer BufWritePost .* %{ evaluate-commands %{ make } } 
}

define-command -allow-override autobuild-disable %{
    remove-hooks buffer autobuild
}
