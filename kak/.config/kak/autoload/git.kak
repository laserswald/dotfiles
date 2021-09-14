
try %{ declare-user-mode git }

define-command -hidden -override git-switch-branch %{
   nop %sh{
	   git pick-branch
   }
   edit '*scratch*'
   delete-other-buffers
}

map -docstring "Add this file to the current commit." \
    global git a %{: git add<ret>}

map -docstring "Open the log." \
    global git c %{: terminal GIT_EDITOR=kak-jump tig <ret>}

map -docstring "Open the status view." \
    global git s %{: terminal GIT_EDITOR=kak-jump tig status<ret>}

map -docstring "Switch branches." \
    global git S %{: git-switch-branch<ret>}

