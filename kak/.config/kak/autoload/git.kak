
try %{ declare-user-mode git }

map -docstring "Add this file to the current commit." \
    global git a %{: git add<ret>}

map -docstring "Open the status view." \
    global git s %{: terminal GIT_EDITOR=kak-jump tig status<ret>}

map -docstring "Open the log." \
    global git c %{: terminal GIT_EDITOR=kak-jump tig <ret>}

map -docstring "Pick an existing branch." \
    global git b %{:nop %sh{git pick-branch}<ret>}

