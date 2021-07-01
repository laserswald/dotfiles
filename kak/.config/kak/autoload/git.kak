
declare-user-mode git

map -docstring "Open the current git status." \
    global git s ': git status<ret>'


hook -group git-status-binds window W

map -docstring "Jump to the file in the status window."


