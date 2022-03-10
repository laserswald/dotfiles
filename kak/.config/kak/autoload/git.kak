
try %{ declare-user-mode git }

define-command -hidden -override git-switch-branch %{
	nop %sh{
	   git pick-branch
	}
	edit '*scratch*'
	delete-other-buffers
}

define-command -hidden -override lazr-git-push %{
	nop %sh{ git push }
	echo "Successfully pushed branch."
}

map -docstring "Add this file to the current commit." \
    global git a %{: git add<ret>}

map -docstring "Open the log." \
    global git c %{: terminal GIT_EDITOR=kak-jump tig <ret>}

map -docstring "Open the status view." \
    global git s %{: terminal GIT_EDITOR=kak-jump tig status<ret>}

map -docstring "Switch branches." \
    global git S %{: git-switch-branch<ret>}

map -docstring "Push branch changes." \
    global git p %{: lazr-git-push<ret>}

